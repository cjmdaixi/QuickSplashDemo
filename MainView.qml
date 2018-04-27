import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow {
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
}
