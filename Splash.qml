import QtQuick 2.7
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

Window {
    id: splash
    color: "transparent"
    title: "Splash Window"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen | Qt.WindowStaysOnTopHint
    x: (Screen.width - splashImage.width) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height

	property alias timer: timer

    Image {
        id: splashImage
        source: "qrc:/res/splashscreen.png"
    }
	Text{
		id: textCtrl
		width: contentWidth
		height: contentHeight
		anchors{left: splashImage.left; bottom: splashImage.bottom}
		font{pointSize: 30}
	}

    Timer {
		id: timer
        interval: 1000; running: false; repeat: false
        onTriggered: {
			splash.visible = false;
        }
    }

	function delay(){
		timer.start();
	}

    Component.onCompleted: visible = true
}
