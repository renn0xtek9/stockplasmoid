#include "abstract_stock.hpp"
#include "warrantmodel.hpp"

Warrantmodel::Warrantmodel() : QStandardItemModel(nullptr)
{
}
Warrantmodel::~Warrantmodel()
{
}
void Warrantmodel::addItem(QString url,QString name)
{
	AbstractStock* stock=new AbstractStock(url,name);
	appendRow(stock);
// 	emit rowCountChanged(rowCount());
}
void Warrantmodel::refreshAll()
{
	QModelIndex parent;
	int i=rowCount(parent);
	for (int i=0;i<rowCount(parent);i++)
	{
		QStandardItem* itm=item(i,0);
		AbstractStock* absstock=dynamic_cast<AbstractStock*>(itm);
		absstock->Refresh();
	};
}


QHash<int, QByteArray> Warrantmodel::roleNames() const 
{
	QHash<int, QByteArray> roles;
	roles[Iconpathrole] = "icon";
	roles[Displayrole] = "display";
	roles[Tooltiprole] = "ttp";
	roles[Valuerole] = "value";
	roles[Increase] = "increase" ;
	roles[IsIncreasing] = "increasing";
	return roles;
	
}

void Warrantmodel::emitRefreshed()
{
	emit refreshed();
}



