import QtQuick 2.7
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

Window {
    id: splash
    color: "transparent"
    title: "Splash Window"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen | Qt.WindowStaysOnTopHint
    property int timeoutInterval: 2000
    signal timeout
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

	Button{
		id: quitBtn
		text: qsTr("退出")
		anchors{right: splashImage.right; bottom: splashImage.bottom; margins: 10}
		onClicked:{
			Qt.quit();
		}
		visible: false
	}

    Timer {
		id: timer
        interval: timeoutInterval; running: false; repeat: false
        onTriggered: {
			splash.visible = false;
            splash.timeout();
        }
    }

	function delay(){
		timer.start();
	}

	function showMessage(msg){
		textCtrl.text = msg;
	}

	function enableQuit(){
		quitBtn.visible = true;
	}

    Component.onCompleted: visible = true
}
