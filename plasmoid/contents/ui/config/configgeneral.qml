//You can change the name of this file
//In here you define the ui for a tab (when you right click on the plasmoid then "plasmoid" settings)
import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls
import org.kde.plasma.configuration 2.0
import org.kde.plasma.components 2.0 as PlasmaComponent
import QtQuick.Layouts 1.3
import "configscripts.js" as Configscripts
import org.kde.plasma.extras 2.0 as PlasmaExtras
Rectangle {
	id: root
	color: syspal.window
// 	width: units.gridUnit * 40
// 	height: units.gridUnit * 30
	property alias cfg_list_of_tags: list_of_tags.text
	
	ListModel{
			id: onvistaurlmodel
	}
	
			
	ColumnLayout {
		anchors.fill:parent
		QtControls.Label{
			id: alphavantagetitle
			text: "Provide: Alphavantage"
			font.bold: true
		}
		PlasmaComponent.Label{
			id:tagaslable
			text:"e.g. AAPL:Apple;GOOGL:Google"
			color: "black"
		}
		PlasmaComponent.TextField{
			id: list_of_tags
			Layout.fillWidth:true
			text:plasmoid.configuration.list_of_tags
			clearButtonShown:true
		}
		PlasmaComponent.Label{
			id: apilabel
			text: "API Key https://www.alphavantage.co/support/#api-key"
			color: "black"
		}
		PlasmaComponent.TextField{
			id: alphavantageapikey
			Layout.fillWidth:true
			text:plasmoid.configuration.alphavantageapikey
			clearButtonShown:true 
		}
		RowLayout{
			id: onvistatitlelayout		
			QtControls.Label{
				id: onvistaprovidertitle
				text: "Provider: onvista.de"
				font.bold: true
				Layout.fillWidth:true
			}
			PlasmaComponent.Button{
				id: addButton 
				iconName : "list-add"
				width: 20
				onClicked:{
					onvistaurlmodel.append({"stock_name":"Name of stock","stock_url":"https://www.onvista.de/..."});
				}
			}
		}
		PlasmaExtras.ScrollArea
		{
			id: mainScrollArea
			anchors{
				left:parent.left
				right:parent.right
				top:onvistatitlelayout.bottom
			}
			Layout.minimumHeight: 50 
			Layout.preferredHeight: 400
			Layout.fillHeight: true
			ListView
			{
				id: onvistaurlview
				model: onvistaurlmodel
				delegate: Onvistaurldelegate{
						itemheight:20
						stockurl: stock_url
						stockname: stock_name
						onRemovedClicked:{
							onvistaurlmodel.remove(index);
						}
						onItemModified:{
							onvistaurlmodel.get(index)[key]=newvalue;
							plasmoid.configuration.onvistaurllist=Configscripts.DressNewListOfOnvistaModelData(onvistaurlmodel);
						}
				}
				Component.onCompleted:{
					Configscripts.PopulateOnvistaUrlModel(onvistaurlmodel)
				}
				onCountChanged:{
					var cumulheight=0
					for(var child in onvistaurlview.contentItem.children) {
						cumulheight+=onvistaurlview.contentItem.children[child].height;
					}
					onvistaurlview.height=cumulheight;
				}
			}
		}
		Item
		{
			id: spacer
			Layout.fillHeight:true
		}
	}
	
}
