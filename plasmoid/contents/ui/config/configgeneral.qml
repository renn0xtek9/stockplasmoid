//You can change the name of this file
//In here you define the ui for a tab (when you right click on the plasmoid then "plasmoid" settings)
import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls
import org.kde.plasma.configuration 2.0
import org.kde.plasma.components 2.0 as PlasmaComponent
import QtQuick.Layouts 1.3
Rectangle {
	id: root
	color: syspal.window
// 	width: units.gridUnit * 40
// 	height: units.gridUnit * 30
	property alias cfg_list_of_tags: list_of_tags.text
	ColumnLayout {
		anchors.fill:parent
		
		PlasmaComponent.TextField{
			id: list_of_tags
			width:parent.width
			text:plasmoid.configuration.list_of_tags
			clearButtonShown:true
			anchors{
				left:parent.left 
				right:parent.right
			}
		}
		PlasmaComponent.Label{
			id: apilabel
			text: "API Key https://www.alphavantage.co/support/#api-key"
			color: "black"
			anchors{
				left:parent.left
			}
		}
		PlasmaComponent.TextField{
			id: alphavantageapikey
			width:parent.width
			text:plasmoid.configuration.alphavantageapikey
			clearButtonShown:true 
			anchors{
				left:parent.left
				right:parent.right
			}
		}
		Item
		{
			id: spacer
			Layout.fillHeight:true
		}
		
	}
}
