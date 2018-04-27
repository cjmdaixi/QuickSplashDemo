import QtQuick 2.7
import QtQuick.Window 2.3
import CppBackend 1.0
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

QtObject {
	id: root
	property Item $toast
	property Item $busyIndicator
	property Item $viewer

	property QtObject $splashScreen: Splash{}

	property QtObject $app: AppGlobal{
		viewer: $viewer
	}

	property var loader: Loader{
        asynchronous: true
        source: "qrc:/MainView.qml"
		active: false
        onLoaded: {
			$busyIndicator = item.busyIndicator;
			$toast = item.toast;
			$viewer = item.viewer;
            $splashScreen.delay();
        }
    }
	property var $openFileDialog:FileDialog {
        title: qsTr("请选择要导入的STL文件")
        nameFilters: ["STL文件(*.stl)"]
        selectExisting: true
    }

	property var $saveFileDialog:FileDialog {
        title: qsTr("另存为...")
        nameFilters: ["STL文件(*.stl)"]
        selectExisting: false
    }

	Component.onCompleted:{
		loader.active = true;
	}
}
