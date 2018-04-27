import QtQuick 2.7
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

QtObject {
	id: root

	property QtObject $splashScreen: Splash{}

	property var loader: Loader{
        asynchronous: true
        source: "qrc:/MainView.qml"
		active: false
        onLoaded: {
            $splashScreen.delay();
        }
    }

	Component.onCompleted:{
		loader.active = true;
	}
}
