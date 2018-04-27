import QtQuick 2.6
import QtQuick.Window 2.3

Window {
	id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Splash Demo")

    Rectangle{
        color: "red"
        anchors.fill: parent
    }

    Text{
        text: qsTr("Test window");
        anchors.centerIn: parent
    }
    Component.onCompleted: window.show()
}
