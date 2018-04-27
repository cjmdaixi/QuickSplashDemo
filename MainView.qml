import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import CppBackend 1.0
import QuickOSG 1.0

ApplicationWindow {
	id: window
    visible: true
    width: 1024
    height: 768
    title: qsTr("易加鞋模修复软件") + " Ver." + $app.version

	property alias toast: toast
	property alias busyIndicator: busyIndicator
	property alias viewer: viewer

	Rectangle{
		anchors.fill: parent
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#e4e4e4" }
			GradientStop { position: 1.0; color: "#d4d4d4" }
		}
	}

	QuickOSGViewer{
		id: viewer
		anchors.fill: parent
		framerate: 100
		scene: $app.sceneNode
	}

	DropArea{
		id: dropArea
		anchors.fill: parent
		onDropped:{
			//console.log("dropped", drop.keys);
			var path = drop.urls[0].toString();
			// remove prefixed "file:///"
			path= path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
			// unescape html codes like '%23' for '#' 
			var cleanPath = decodeURIComponent(path);
			console.log("clean path:", cleanPath);
			if($app.fileSuffix(cleanPath) !== "stl"){
				toast.show(qsTr("目前只支持STL格式模型！"));
			}else{
				$app.loadModel(cleanPath);
			}
			
		}
	}

	Parameters{
		id: parameters
		width: 300
		height: 200
		x: (parent.width - width) / 2
		y: (parent.height - height) / 2
		focus: true
		onOk:{
			$app.repairShoeMesh(extendThreshold);
		}
	}

	Connections{
		target: $openFileDialog
		onAccepted: {
		    var filePath = $openFileDialog.fileUrl.toString();
			filePath = filePath.replace(/^(file:\/{3})/,"");
			$app.loadModel(filePath);
        }
		onRejected: {}
	}
	Connections{
		target: $saveFileDialog
		onAccepted: {
		    var filePath = $saveFileDialog.fileUrl.toString();
			filePath = filePath.replace(/^(file:\/{3})/,"");
			$app.saveRepairedModel(filePath);
        }
		onRejected: {}
	}

	Connections{
		target: $app
		onBeginLoading:{
			$busyIndicator.visible = true;
		}
		onFinishLoading:{
			$busyIndicator.visible = false;
			if(success === false){
				$toast.show(qsTr("STL模型加载失败！"));
			}else{
				$app.renderMesh(true);
				repairShoeModelBtn.enabled = true;
				repairModelBtn.enabled = true;
			}
		}
		onBeginRendering:{
			$busyIndicator.visible = true;
		}
		onFinishRendering:{
			$busyIndicator.visible = false;
		}
		onBeginRepairing:{
			$busyIndicator.visible = true;
		}
		onFinishRepairing:{
			$busyIndicator.visible = false;
			$app.renderMesh(false);
		}
		onBeginSaving:{
			$busyIndicator.visible = true;
		}
		onFinishSaving:{
			$busyIndicator.visible = false;
		}
	}

	header: ToolBar {
		RowLayout {
			anchors.fill: parent
			ToolButton {
				id: loadModelBtn
				text: qsTr("加载模型")
				onClicked: {
					$openFileDialog.open();
				}
				ToolTip.visible: hovered
				ToolTip.text: qsTr("加载STL待修复模型")
			}
			ToolSeparator {}
			ToolButton {
				id: repairModelBtn
				text: qsTr("普通修复")
				enabled: false
				onClicked: {
					$app.repairMesh();
				}
				ToolTip.visible: hovered
				ToolTip.text: qsTr("点击进行普通模型修复")
			}
			ToolButton {
				id: repairShoeModelBtn
				text: qsTr("高级修复")
				enabled: false
				onClicked: {
					parameters.open();
				}
				ToolTip.visible: hovered
				ToolTip.text: qsTr("点击进行真对鞋模的高级修复")
			}

			ToolSeparator {}
			ToolButton {
				id: restoreRepairBtn
				text: qsTr("恢复")
				enabled: $app.restoreAvailable
				onClicked: {
					$app.restoreRepair();
				}
				ToolTip.visible: hovered
				ToolTip.text: qsTr("放弃当前修复结果，回到修复前模型")
			}
			ToolSeparator {}
			ToolButton {
				id: saveRepairedModelBtn
				text: qsTr("保存")
				enabled: $app.saveAvailable
				onClicked: {
					$saveFileDialog.open();
				}
				ToolTip.visible: hovered
				ToolTip.text: qsTr("保存修复模型到STL文件")
			}
			Item{Layout.fillWidth: true}
		}
	}

	Toast{
		id: toast
		anchors{centerIn: parent}
	}

	Rectangle{
		id: busyIndicator
		anchors.fill: parent
        color: "#ccffffff"
		visible: false 
		MouseArea{
			anchors.fill: parent
		}
		BusyIndicator {
			anchors.centerIn: parent
		}
	}

	Component.onCompleted: {
		//viewer.scene = $app.loadModelFile("cessna.osg");
	}
}
