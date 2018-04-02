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
	width: parent.width
	height: itemheight
	
	RowLayout{
		anchors.fill:parent
		spacing: 15
		
		PlasmaComponents.Label{
			id: lbl_stockncode
			text: stockcode
			font.bold: true
		}
		PlasmaComponents.Label{
			width:50
			anchors.right:lbl_stockincrease.left
			id: lbl_stockprice
			text: Stockparser.FormatPrice(stockprice)
			font.bold: true
		}
		PlasmaComponents.Label{
			width:50
			anchors.right:parent.right
			id: lbl_stockincrease
			text: Stockparser.FormatPrice(stockincrease)+"%"
			font.bold: true
		}
	}
}
