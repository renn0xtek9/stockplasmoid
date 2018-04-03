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
	void refreshed(Warrantmodel*);

public:
	Warrantmodel();
	virtual ~Warrantmodel();
	
	
	QHash<int, QByteArray> roleNames() const ;
	
public slots:


	Q_INVOKABLE void refreshAll();
	Q_INVOKABLE void addItem(QString url,QString name);

private:

	QModelIndex* m_rootmodelindex;
// 	QString getCustomOrThemeIconPath(QString iconpathfromxml,QStandardItem* p_item);
// 	bool FileExists(const QString & path) const noexcept;
// 	//path
// 	QString m_konquerorpath;
// 	QString m_okularpath;
// 	QString m_firefoxpath;
// 	QString m_chromepath;
// 	bool m_konquerorpathhaschangedsincelastread={true};
// 	bool m_okularpathhaschangedsincelasteread={true};
// 	bool m_firefoxpathhaschangedsincelastread={true};
// 	bool m_chromepathhaschnagedsincelastread={true};
// 	
// 	QString getStandardIcon(const QStandardItem* p_item) const noexcept;
// 	CurrentlyParsing m_currentlyparsed;
// 	//Methods to read an xbel based bookmark fodlder
// 	bool readXBEL(QIODevice* device);
// 	QString readXBELTitle();
// 	void readXBELSeparator();
// 	QStandardItem* readXBELFolder();
// 	QStandardItem* readXBELBookmark();
// 	void readXBELInfoAndMetadata(QString p_blockname,QStandardItem* p_item);	
// 	QXmlStreamReader xml;
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
        	Q_ASSERT(uri == QLatin1String("MyPlugins"));
        	qmlRegisterType<Warrantmodel,1>(uri, 1, 0, "Warrantmodel");
// 		qmlRegisterType<Launcher,1>(uri,1,0,"Launcher");
    	}
};


// undefined reference to `QQmlExtensionPlugin::qt_metacast(char const*)'

#endif


