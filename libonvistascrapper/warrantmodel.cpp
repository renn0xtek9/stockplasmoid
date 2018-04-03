#include "abstract_stock.hpp"
#include "warrantmodel.hpp"

Warrantmodel::Warrantmodel() : QStandardItemModel()
{
}
Warrantmodel::~Warrantmodel()
{
}
void Warrantmodel::addItem(QString url,QString name)
{
	AbstractStock* stock=new AbstractStock(url,name);
	
	invisibleRootItem()->appendRow(stock);	
}
void Warrantmodel::refreshAll()
{
	QModelIndex parent;
	int i=rowCount(parent);
	qDebug()<<"Refresh There are rows"<<i;
	for (int i=0;i<rowCount(parent);i++)
	{
		QStandardItem* itm=item(i,0);
		AbstractStock* absstock=dynamic_cast<AbstractStock*>(itm);
		absstock->Refresh();
	};
	emit refreshed(this);
	
	
	
	
	QModelIndex current;
	for (int i=0 ; i<rowCount(parent) ; i++)
 	{
		current=index(i,0,parent);
		int rowforthis=current.row();
		qDebug()<<data(current,Qt::DisplayRole)<<" row for this:"<<rowforthis;
		qDebug()<<data(current,Qt::ToolTipRole)<<" is the tooltip";
		qDebug()<<data(current,Qt::UserRole+2)<<" is price";
	}
	
}


QHash<int, QByteArray> Warrantmodel::roleNames() const 
{
	QHash<int, QByteArray> roles;
	roles[Iconpathrole] = "icon";
	roles[Displayrole] = "display";
	roles[Tooltiprole] = "ttp";
	roles[Valuerole] = "value";
	roles[Increase] = "increase" ;
	return roles;
	
}



