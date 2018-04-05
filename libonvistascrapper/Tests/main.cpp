#include<iostream>
#include<QtCore/QString>
#include<QtCore/QFile>
#include<QtCore/QDebug>
#include<QtCore/QModelIndex>
#include<QtGui/QStandardItem>
#include<QApplication>
#include<QCommandLineParser>
#include "warrantmodel.hpp"
using namespace std;

void showModel(Warrantmodel& wmodel)
{
	QModelIndex parent;
	QModelIndex current;
	int i=0;
	int n=wmodel.rowCount(parent);
	qDebug()<<wmodel.rowCount();
	qDebug()<<wmodel.columnCount();
	for (int i=0 ; i<n ; i++)
 	{
		current=wmodel.index(i,0,parent);
		int rowforthis=current.row();
// 		int subrows=current.
		qDebug()<<wmodel.data(current,Qt::DisplayRole)<<" row for this:"<<rowforthis;
		qDebug()<<wmodel.data(current,Qt::ToolTipRole)<<" is the tooltip";
		qDebug()<<wmodel.data(current,Qt::UserRole+2)<<" is price";
	}
	
}


int main(int argc, char **argv) 
{  
	QApplication a(argc, argv);
	
	
	qDebug()<<"shit";
	Warrantmodel wmodel;
	QString url="https://www.onvista.de/derivate/optionsscheine/SG-CALL-TESLA-MOTORS-380-0-01-17-12-21-DE000SG73UZ6?custom=c";
	wmodel.addItem(url,"Warrant TESLA");
	QString url2="https://www.onvista.de/derivate/optionsscheine/COMMERZBANK-CALL-DEUTSCHE-BOERSE-40-0-1-13-06-18-DE000CE4R7X6";
	wmodel.addItem(url2,"Warrant COMbank");
	wmodel.refreshAll();
// 	QObject::connect(wmodel,&Warrantmodel::refreshed,showModel);
	
	
	
	
	return a.exec();
}


