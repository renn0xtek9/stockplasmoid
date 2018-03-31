//In here you list the tabs that will appear in the configuration dialog of the plasmoid (when you right click it and click on settings)
import org.kde.plasma.configuration 2.0
ConfigModel {
     ConfigCategory {
          name: "General"
          icon: "bookmarks-organize.png"
          source: "config/configgeneral.qml"
     }
}
