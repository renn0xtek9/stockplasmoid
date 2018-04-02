import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml 2.2
import org.kde.plasma.plasmoid 2.0 //needed to give the Plasmoid attached properties
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "stockparser.js" as Stockparser
Item {
	id: mainWindow
	function updateList(id,list_of_tags)
	{
		for (var i=0; i<samplemodel.count;i++)
		{	
			var record=Stockparser.getRecordListForSymbol(samplemodel.get(i).code)
			samplemodel.get(i).price=record[0]
			samplemodel.get(i).increase=record[1]
			samplemodel.get(i).increasing=Stockparser.isIncreaseing(record[1])
		}		
	}
	Plasmoid.toolTipMainText: i18n("Show stock prices using AlphaVantage API")
	ListModel{
		id: samplemodel
	}
	Plasmoid.fullRepresentation:  Item{
		id: mainrepresentation
		Layout.minimumHeight:150
		Layout.minimumWidth:300
		ListView{
			id: mainlistview
			anchors.top:parent.top
			anchors.left:parent.left
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
			Component.onCompleted:Stockparser.makeList(samplemodel,plasmoid.configuration.list_of_tags)
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
		Timer {
			id: updateTimer
			interval: 300000		//300 000 ms =5min
			repeat: true
			running: true
			triggeredOnStart: true
			onTriggered: mainWindow.updateList(samplemodel,plasmoid.configuration.list_of_tags)
		}
	}
}

