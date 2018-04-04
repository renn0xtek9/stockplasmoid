#ifndef WARRANTMODEL_HPP
#define WARRANTMODEL_HPP
#include <QtCore/QObject>
#include <QtGui/QStandardItemModel>
#include <QtCore/QIODevice>
#include <QtCore/QString>
#include <QtCore/QList>
#include <QtCore/QXmlStreamReader>
#include <QtCore/QHash>
#include <QtQml/QtQml>
#include <QtQml/qqml.h>
#include <QtQml/QQmlExtensionPlugin>
#include <QtQml/QQmlExtensionInterface>
#include "abstract_stock.hpp"

class Warrantmodel :public QStandardItemModel
{
	Q_OBJECT
	Q_PROPERTY(int rowCount READ rowCount NOTIFY rowCountChanged);
signals:
	void rowCountChanged(int newcount);
	void refreshed();
public:
	Warrantmodel();
	virtual ~Warrantmodel();
	QHash<int, QByteArray> roleNames() const ;
public slots:
	Q_INVOKABLE void refreshAll();
	Q_INVOKABLE void addItem(QString url,QString name);
private slots:
	void emitRefreshed();
private:
	QModelIndex* m_rootmodelindex;
};

class WarrantmodelPlugin : public QQmlExtensionPlugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
	WarrantmodelPlugin()
	{
		
	}
	~WarrantmodelPlugin()
	{
		
	}
    	void registerTypes(const char *uri)
    	{
        	Q_ASSERT(uri == QLatin1String("OnvistaScrapper"));
        	qmlRegisterType<Warrantmodel,1>(uri, 1, 0, "Warrantmodel");
// 		qmlRegisterType<Launcher,1>(uri,1,0,"Launcher");
    	}
};
#endif


