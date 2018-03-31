import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml 2.2
import org.kde.plasma.plasmoid 2.0 //needed to give the Plasmoid attached properties
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
Item {
	id: mainWindow
	Plasmoid.toolTipMainText: i18n("Show stock prices using AlphaVantage API")
	Plasmoid.switchWidth: units.gridUnit * 10
	Plasmoid.switchHeight: units.gridUnit * 10	
	Layout.preferredHeight:800
	Plasmoid.fullRepresentation:  Item{
		id: mainrepresentation
		Layout.minimumHeight:300
		Layout.minimumWidth:300
		Layout.fillHeight : true
		Label{
			id: lbl
			text: plasmoid.configuration.propertyone	//This a persistant property. look at main.xml to define those !!
		}
	}
	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: {
			var exitCode = data["exit code"]
			var exitStatus = data["exit status"]
			var stdout = data["stdout"]
			var stderr = data["stderr"]
			exited(exitCode, exitStatus, stdout, stderr)
			disconnectSource(sourceName) // cmd finished
		}
		function exec(cmd) {
			connectSource(cmd)
		}
		signal exited(int exitCode, int exitStatus, string stdout, string stderr)
	}	
// 	call with  executable.exec("keditbookmarks "+itemmodel.konquerorBookmarks)
}
