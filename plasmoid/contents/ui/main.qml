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
	Plasmoid.toolTipMainText: i18n("Show stock prices using AlphaVantage API")
	Plasmoid.switchWidth: units.gridUnit * 10
	Plasmoid.switchHeight: units.gridUnit * 10	
	Layout.preferredHeight:800
	ListModel{
		id: samplemodel
	}
	Plasmoid.fullRepresentation:  Item{
		id: mainrepresentation
// 		Layout.minimumHeight:300
// 		Layout.minimumWidth:300
// 		Layout.fillHeight : true
		ListView{
			id: mainlistview
// 			anchors.top:parent.top
// 			width:parent.width
			anchors.fill:parent
			model: samplemodel
			focus:true
			delegate: Stockdelegate{
				itemheight:20
				stockcode:name
				stockprice:price
				stockincrease:increase
				stockname:name
				stockisincreasing:increasing
			}
				
			
// 			delegate: Text{
// 				text: name+' '+price
// 				color: 'red'
// 			}
			Component.onCompleted:Stockparser.makeList(samplemodel,plasmoid.configuration.list_of_tags)
		}
	}
}

