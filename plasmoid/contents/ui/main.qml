import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml 2.2
import QtQml.Models 2.2
import org.kde.plasma.plasmoid 2.0 //needed to give the Plasmoid attached properties
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import OnvistaScrapper 1.0 as OnvistaScrapper
import "stockparser.js" as Stockparser
import "config/configscripts.js" as Configscripts

Item {
	id: mainWindow
	function clearAndRecreateList(id,list_of_tags)
	{
		samplemodel.clear();
		var codearray=Stockparser.getListofStockCodes(list_of_tags);
		var codearraylength=codearray.length;
		for (var i=0; i<codearraylength;i++)
		{
			Stockparser.httpGetAsync(codearray[i],plasmoid.configuration.alphavantageapikey,insertRecordInModel);
		}
	}
	function insertRecordInModel(jsonanswer,symbol)
	{
		var record=Stockparser.AlphaVantageTimeSeriesDailyParse(jsonanswer);
		var name=Stockparser.getDictOfStockCodesAndNames(plasmoid.configuration.list_of_tags)[symbol];
		samplemodel.append({"name":name,"code":symbol,"price":record[0],"increase":record[2],"increasing":Stockparser.isIncreaseing(record[2])});
	}
	Plasmoid.toolTipMainText: i18n("Show stock prices using AlphaVantage API")
	ListModel{
		id: samplemodel
	}
	OnvistaScrapper.Warrantmodel{
		id: itemmodel
	}
	function configChanged()
	{
		clearAndRecreateList(samplemodel,plasmoid.configuration.list_of_tags);
	}
	Plasmoid.fullRepresentation:  Item{
		id: mainrepresentation
		Layout.minimumHeight:300
		Layout.minimumWidth:300
		Column{
			id:mainview
			anchors.left:parent.left
			anchors.top:parent.top
			anchors.right:parent.right
// 			
			
			
			ListView{
				id: mainlistview
// 				anchors.top:parent.top
				anchors.left:parent.left
				anchors.right:parent.right
// 				width:parent.width			
				header:Rectangle{
					id:list_header
					width:parent.width
					height:50
					color:theme.backgroundColor
					Text{
						anchors.horizontalCenter:parent.horizontalCenter
						anchors.verticalCenter:parent.verticalCenter
						id:txt_title
						text: "Stock Prices"
						color: theme.textColor

						font.italic: true
						font.pixelSize: 22
					}
				}
				model: samplemodel
				focus:true
				delegate: Stockdelegate{
					itemheight:20
					stockcode:code
					stockprice:price
					stockincrease:increase
					stockname:name
					stockisincreasing:increasing
				}
				Component.onCompleted:{
					mainWindow.clearAndRecreateList(samplemodel,plasmoid.configuration.list_of_tags)
	// 				Stockparser.makeList(samplemodel,plasmoid.configuration.list_of_tags);
				}
				onCountChanged:{
					var root = mainlistview.visibleChildren[0]
					var listViewHeight = 0
					var listViewWidth = 0

					// iterate over each delegate item to get their sizes
					for (var i = 0; i < root.visibleChildren.length; i++) {
						listViewHeight += root.visibleChildren[i].height
						listViewWidth  = Math.max(listViewWidth, root.visibleChildren[i].width)
					}

					mainlistview.height = listViewHeight
	// 				mainlistview.width = listViewWidth
				}
			}
			ListView{
				id: derivate_product_view
// 				anchors.top:mainlistview.bottom
				anchors.left:parent.left
				anchors.right:parent.right
				width:parent.width	
				header:Rectangle{
					id:list_header
					width:parent.width
					height:50
					color:theme.backgroundColor
					Text{
						anchors.horizontalCenter:parent.horizontalCenter
						anchors.verticalCenter:parent.verticalCenter
						id:txt_title
						text: "Options and Warrants"
						color: theme.textColor
						font.italic: true
						font.pixelSize: 22
					}
				}				
				model :onvistamodel
				DelegateModel {
					id: onvistamodel
					model: itemmodel
					delegate: Stockdelegate{
						itemheight:20
						stockcode: ""		//TODO implement code !
						stockprice:value
						stockincrease:increase
						stockname:display
						stockisincreasing:increasing
					}
				}	
				function populateOnvistaModel()
				{
					Configscripts.PopulateOnvistaItemModel(onvistamodel,plasmoid.configuration.onvistaurllist);
// 					console.log("Model is populated!");
// 					itemmodel.addItem("https://www.onvista.de/derivate/optionsscheine/SG-CALL-TESLA-MOTORS-380-0-01-17-12-21-DE000SG73UZ6?custom=c","Warrant TESLA");
// // 					itemmodel.addItem("https://www.onvista.de/derivate/optionsscheine/COMMERZBANK-CALL-DEUTSCHE-BOERSE-40-0-1-13-06-18-DE000CE4R7X6","Warrant COMBANK");	itemmodel.addItem("https://www.onvista.de/derivate/optionsscheine/COMMERZBANK-CALL-DEUTSCHE-BOERSE-40-0-1-13-06-18-DE000CE4R7X6","Warrant COMBANK");
				}
				function refresh()
				{
					itemmodel.refreshAll();
				}
				function evaluateHeight()
				{
					var cumulheight=0
					for(var child in derivate_product_view.contentItem.children) {
						cumulheight+=derivate_product_view.contentItem.children[child].height;
					}
					derivate_product_view.height=cumulheight;
				}
				onCountChanged:{
					evaluateHeight();
				}
				Component.onCompleted:{
					populateOnvistaModel();
					refresh();
				}
			}
		}
		Timer {
			id: updateTimer
			interval: 300000		//300 000 ms =5min
			repeat: true
			running: true
			triggeredOnStart: false
			onTriggered: {
				mainWindow.clearAndRecreateList(samplemodel,plasmoid.configuration.list_of_tags);
				derivate_product_view.refresh();
				derivate_product_view.evaluateHeight();
			}
		}
	}
	
	Connections{
		target:plasmoid.configuration
		onOnvistaurllistChanged:{
			Configscripts.PopulateOnvistaItemModel(itemmodel,plasmoid.configuration.onvistaurllist);
			itemmodel.refreshAll();
		}
	}
}
