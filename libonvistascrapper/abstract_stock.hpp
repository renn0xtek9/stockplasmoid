#ifndef ABSTRACTSTOCK_H
#define ABSTRACTSTOCK_H
#include <QStandardItem>
#include <QNetworkReply>
#include <QUrl>
#include <QTimer>
#include <QTemporaryFile>
/*! \class AbstractStock
*  \brief This is an abastract template class for stock, warrant, raw materials etc..
*/

enum WarrantRoles {
		Iconpathrole = Qt::UserRole,
		Displayrole =Qt::DisplayRole,
		Tooltiprole =Qt::ToolTipRole,
		Valuerole = Qt::UserRole+2,
		Increase = Qt::UserRole+3
};
	

class AbstractStock: public QObject, public QStandardItem
{
	Q_OBJECT
public:
	enum class  DataProvider 
	{
		Onvista,	/**< Onvista.de */
		Unknown		/**< Unknown provider*/
	};
	//-----------------------------------------------------------------------------------
	//			Public method
	//-----------------------------------------------------------------------------------
	AbstractStock(QString url,QString name);
	~AbstractStock();
	//-----------------------------------------------------------------------------------
	//			Public functions
	//-----------------------------------------------------------------------------------
	
	//-----------------------------------------------------------------------------------
	//			Public members
	//-----------------------------------------------------------------------------------
	
	
	//-----------------------------------------------------------------------------------
	//			Public Slots
	//-----------------------------------------------------------------------------------
public slots:
	void Refresh();
protected:
	//-----------------------------------------------------------------------------------
	//			Protected method
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//			Protected functions
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//			Protected members
	//-----------------------------------------------------------------------------------	
	//-----------------------------------------------------------------------------------
	//			Private slots
	//-----------------------------------------------------------------------------------
private slots:
	void DataReadyRead();
	void HttpFinished();
	void RetrieveData();
private:
		
	
	//-----------------------------------------------------------------------------------
	//			Private method
	//-----------------------------------------------------------------------------------
	void ScrapUrl();
	//-----------------------------------------------------------------------------------
	//			Private functions
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	//			Private members
	//-----------------------------------------------------------------------------------
	QUrl m_url={""};
	QString m_name={""};
	double m_price=-1.0;
	double m_increase=-1.0;
	DataProvider m_provider;
	QNetworkAccessManager m_qnam;
	QNetworkReply *m_reply=nullptr;
	QTemporaryFile* m_tmpfile=nullptr;
	QTimer* m_retrievetimer;
};

#endif //ABSTRACTSTOCK_H
