#include <QtNetwork>
#include <QTimer>
#include <QTemporaryFile>
#include "abstract_stock.hpp"

AbstractStock::AbstractStock(QString url, QString name) :QObject(), QStandardItem(name)
{
	m_url.setUrl(url);
	m_name=name;
	m_provider=DataProvider::Unknown;
	ScrapUrl();
	AffectData();
	m_retrievetimer=new QTimer(this);
	QObject::connect(m_retrievetimer,SIGNAL(timeout()),this,SLOT(RetrieveData()));
}
AbstractStock::~AbstractStock()
{
}
//-----------------------------------------------------------------------------------
//			Public
//-----------------------------------------------------------------------------------
void AbstractStock::ScrapUrl()
{
	if(m_url.toDisplayString().contains("onvista.de"))
	{
		m_provider=DataProvider::Onvista;
	}	
}

//-----------------------------------------------------------------------------------
//			Private
//-----------------------------------------------------------------------------------
void AbstractStock::RetrieveData()
{
	if(m_tmpfile)
	{
		return;	//If somebody is using the temporaray file already, return, the timer will call us back in there once m_tmpfile is nullptr again !
	}
	delete m_tmpfile;
	m_tmpfile=new QTemporaryFile;
	m_tmpfile->setAutoRemove(false);
	m_tmpfile->open();
	qDebug()<<"Tempfile created"<<m_tmpfile->fileName();
	bool httpRequestAborted = false;
	m_reply = m_qnam.get(QNetworkRequest(m_url));
	
	connect(m_reply,&QNetworkReply::finished,this,&AbstractStock::HttpFinished);	
	connect(m_reply, &QIODevice::readyRead, this, &AbstractStock::DataReadyRead);
}
void AbstractStock::DataReadyRead()
{
	if(m_tmpfile&&m_tmpfile->isOpen())
	{
		m_tmpfile->write(m_reply->readAll());
	}
}
void AbstractStock::HttpFinished()
{
	qDebug()<<"HttpFinishedCalled";
	m_tmpfile->reset();			//Replace thecursor at begining of file !
	QString filename=m_tmpfile->fileName();
	QString content=m_tmpfile->readAll();
	m_tmpfile->close();
	delete m_tmpfile;
	m_tmpfile=nullptr;
	m_retrievetimer->stop();
	int index=content.indexOf("class=\"price\"");  //Brutal search for a Tag( this gonna be the Geld !
	QString price_substring;
	if (index>=0)
	{
	
		for (int i=0;i<200;i++)
		{
			price_substring.push_back(content[i+index]);
		}
		QStringList price_substringlst=price_substring.split('>');
		QString str;
		for(int i=0;i<price_substringlst.count();i++)
		{
			str=price_substringlst.at(i);
			if (str.contains("EUR"))
			{
				QString strprice=str.split(" EUR")[0];
				strprice.replace(',','.');
				m_price=strprice.toDouble();
			};
			if (str.contains("%"))
			{
				QString strincrease=str.split("%")[0];
				strincrease.replace(',','.');
				m_increase=strincrease.toDouble();
			};
		}
	}
	else
	{
		qDebug()<<"Finds index"<<index<<" when looking for class=\"price\" in "<<filename;
		qDebug()<<"Content";
		qDebug()<<content;
	}
	AffectData();
	
}
void AbstractStock::Refresh()
{
	m_retrievetimer->start(500);
}
void AbstractStock::AffectData()
{
	bool is_increasing=true;
	if (m_increase<0)
		is_increasing=false;
	setData(m_increase,WarrantRoles::Increase);
	setData(m_price,WarrantRoles::Valuerole);
	setData(is_increasing,WarrantRoles::IsIncreasing);
	setData(m_name,WarrantRoles::Displayrole);
	setData(m_url.toDisplayString(),WarrantRoles::Tooltiprole);
}


