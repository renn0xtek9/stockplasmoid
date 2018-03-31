//You can change the name of this file
//In here you define the ui for a tab (when you right click on the plasmoid then "plasmoid" settings)
import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls
import org.kde.plasma.configuration 2.0
import QtQuick.Layouts 1.0 as Layouts
Rectangle {
	id: root
	color: syspal.window
	width: units.gridUnit * 40
	height: units.gridUnit * 30
	Layouts.GridLayout {
		columns: 2
		QtControls.Label {
			text: i18n("What the")
			Layouts.Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
		}
		QtControls.Label {
			text: i18n("FUCK!")
			Layouts.Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
		}
	}
}
