import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import "stockparser.js" as Stockparser


PlasmaComponents.ListItem {
	id: stockitem
	property string stockcode : "TSLA"
	property string stockname: "Tesla Motors"
	property string stockprice: "-1.0"
	property string stockincrease: "99.9"
	property int pixelSize: 14
	property bool stockisincreasing: true
	property int itemheight: 20
	height: itemheight
	width: parent.width
	anchors.left:parent.left
	visible: true
	RowLayout{
		id: stockitemlayout
		anchors.fill:parent
		spacing: 15
		state: "positive"
		height:itemheight
		Text{
			id:lbl_stockname
			text:stockname 
			color:PlasmaCore.ColorScope.textColor
			font.bold:true 
			height:parent.height
			font.pixelSize:pixelSize
		}
		
		
		Text{
			id: lbl_stockcode 
			text: '('+stockcode+')'
			color:PlasmaCore.ColorScope.textColor
			font.bold: false 
			font.pixelSize:pixelSize
			height:parent.height
		}
		Item{
			id: spacer
			Layout.fillWidth:true
		}
		Text{
			width:50
// 			anchors.right:lbl_stockincrease.left
			id: lbl_stockprice
			text: Stockparser.FormatPrice(stockprice)
			font.bold: false
			font.pixelSize:pixelSize
			height:parent.height
		}
		Text{
			width:50
			anchors.right:parent.right
			id: lbl_stockincrease
			text: Stockparser.FormatPrice(stockincrease)+"%"
			font.bold: true
			font.pixelSize:pixelSize
			height:parent.height
		}
		states: [
			State{
				name: "positive";
				when: stockisincreasing==true;
				PropertyChanges{
					target: lbl_stockincrease;color: "green"}
				PropertyChanges{
					target: lbl_stockprice; color:"green"}
			},
			State{
				name: "negative";
				when: stockisincreasing==false;
				PropertyChanges{
					target: lbl_stockincrease;color: "red"}
				PropertyChanges{
					target: lbl_stockprice; color:"red"}
			}
		]
	}
}
