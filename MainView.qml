import QtQuick 2.6
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Window {
	id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Splash Demo")
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    Rectangle{
        id: rect
        color: "red"
        anchors.fill: parent
        anchors.margins: 30
    }

    Text{
        text: qsTr("Test window");
        anchors.centerIn: parent
    }
    Component.onCompleted: window.show()
}
