import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponent

PlasmaComponent.ListItem {
	id: root 
	anchors.left:parent.left

	width:parent.width

	property string stockurl: "www.onvista.de"
	property string stockname: "stock1"
	property int itemheight: 20
	
	signal removedClicked(int index)
	signal itemModified()
	
	RowLayout{
		id: rootlayout
		Layout.fillHeight:true
		Layout.minimumWidth:200
		anchors{
			left:parent.left
			right:parent.right
		}
		PlasmaComponent.TextField{
			id: name
			Layout.preferredWidth:300
			Layout.minimumWidth:100
			Layout.fillHeight:true
			text:stockname
			clearButtonShown:true
			anchors{
				right:url.left
				left:parent.left
			}
			onEditingFinished:{
				console.log("Stock Name is accepted");
				root.itemModified();
			}
		}		
		PlasmaComponent.TextField{
			id: url
			text:stockurl
			clearButtonShown:true
			Layout.fillWidth:true
			onEditingFinished:{
				console.log("Stock url is accepted");
				root.itemModified();
			}
		}
		PlasmaComponent.Button{
			width:itemheight
			anchors{
				right:parent.right
			}
			id: removebutton
			iconName: "edit-delete"
			tooltip: "Remove this entry" 
			onClicked:{
				console.log("Button clicked")
				console.log("index" +index)
				root.removedClicked(index)
				root.itemModified();
			}
		}		
	}
	
}
		
