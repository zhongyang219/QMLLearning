import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: global.dpi(800)
    height: global.dpi(320)
    visible: true
    color: "#F2F8FF"
    //property var dataSource: null

    signal btn1Clicked()
    signal edit1TextChanged(var text)

    Global {
        id: global
    }

    /*Rectangle
	{
		id: btn1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
		width: 60
        height: 26
        color: btn1Area.pressed ? "#69B2FF" : (btn1Area.containsMouse ? "#95C9FF" : "#C8E3FF")
        border.color: "#69B2FF"
        radius: 8

		MouseArea
		{
            id: btn1Area
            anchors.fill: parent
            hoverEnabled: true
            enabled: true
            onClicked: {
                root.btn1Clicked();
            }
        }

        Text {
            id: btn1Text
            text: qsTr("btn1")
            anchors.centerIn: parent    //文本显示在按钮中间
            font.family: qsTr("微软雅黑")
            font.pixelSize: 11
            color: "#012C6E"
        }
    }*/

    MyButton
    {
        id: btn1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: global.dpi(10)
        btnText: "Btn1"

        onClicked:
        {
            root.btn1Clicked();
        }

    }

    TextField
    {
        id: edit1
        anchors.left: btn1.right
        anchors.top: btn1.top
        anchors.leftMargin: global.dpi(10)
        width: global.dpi(120)
        height: global.dpi(26)
        color: "#012C6E"
        font.family: qsTr("微软雅黑")
        font.pixelSize: global.dpiFloat(11)
        selectByMouse: true
        onTextChanged: {
            edit1TextChanged(text.trim())
        }
        Keys.onEscapePressed: {     //按esc键取消焦点
            focus = false
        }
    }

    MyButton2
    {
        id: btn2
        anchors.left: edit1.right
        anchors.leftMargin: global.dpi(10)
        anchors.top: edit1.top
        btnText: "切换样式"
        onClicked:
        {
            listExample.bRound = !listExample.bRound
        }
    }

    MyButton2
    {
        id: btn3
        anchors.left: btn2.right
        anchors.leftMargin: global.dpi(10)
        anchors.top: edit1.top
        btnText: "切换视图"
        onClicked:
        {
            listExample.bList = !listExample.bList
        }
    }
    Text
    {
        id: label
        width: global.dpi(200)
        height: global.dpi(24)
        anchors.left: btn1.left
        anchors.top: btn1.bottom
        anchors.topMargin: global.dpi(10)
        color: "#012C6E"
        font.family: qsTr("微软雅黑")
        font.pixelSize: global.dpiFloat(11)

        // custom counter property for space presses
        property int spacePresses: 0
        text: "Space pressed: " + spacePresses + " times"
        // (1) handler for text changes
        onTextChanged: console.log("text changed to:", text)
        // need focus to receive key events
        focus: true
        // (2) handler with some JS
        Keys.onSpacePressed: {
            increment()
        }
        // clear the text on escape
        Keys.onEscapePressed: {
            label.text = ''
        }
        // (3) a JS function
        function increment() {
            spacePresses = spacePresses + 1
        }
    }


    Column
    {
        id: columExample
        anchors.left: root.left
        anchors.top: label.bottom
        anchors.margins: global.dpi(10)
        spacing: global.dpi(2)
        Repeater {
            model: ["Enterprise", "Colombia", "Challenger", "Discovery", "Endeavour"]
            Rectangle {
                width: global.dpi(100)
                height: global.dpi(20)
                radius: global.dpi(3)
                color: "lightBlue"
                Text {
                    anchors.centerIn: parent
                    text: index +": "+modelData
                }
            }
        }
    }

    Rectangle {
        id: listExample
        width: global.dpi(290)
        height: global.dpi(200)
        color: "white"
        anchors.left: columExample.right
        anchors.top: label.bottom
        anchors.margins: global.dpi(10)

        property bool bRound: false     //是否使用圆角矩形
        property bool bList: true       //是否使用列表视图
        property int itemWidth: bList ? global.dpi(150) : global.dpi(40)

        ListView {
            anchors.fill: parent
            anchors.margins: global.dpi(20)
            clip: true
            model: 100
            delegate: parent.bRound ? numberDelegate1 : numberDelegate
            spacing: global.dpi(5)
            visible: parent.bList
        }

        GridView {
            anchors.fill: parent
            anchors.margins: global.dpi(20)
            clip: true
            model: 100
            cellWidth: global.dpi(50)
            cellHeight: global.dpi(32)
            delegate: parent.bRound ? numberDelegate1 : numberDelegate
            visible: !parent.bList
        }

        Component {
            id: numberDelegate
            MyListItem {
                width: listExample.itemWidth
                color: "lightGreen"
                text: index
            }
        }

        Component {
            id: numberDelegate1
            MyListItem {
                width: listExample.itemWidth
                radius: global.dpi(6)
                color: "#FDB4AD"
                text: index
            }
        }
    }

    Canvas {
        id: testCanvas
        width: global.dpi(100); height: global.dpi(150)
        anchors.left: listExample.right
        anchors.top: root.top
        anchors.margins: global.dpi(10)
        onPaint: {
            var ctx = getContext("2d")
            // setup your path
            // fill or/and stroke
            ctx.strokeStyle = "red"
            // create a path
            ctx.beginPath()
            ctx.moveTo(0,0)
            ctx.lineTo(global.dpi(20),0)
            // stroke path
            ctx.stroke()
        }
    }

    ListView {
        width: global.dpi(200)
        height: global.dpi(300)
        anchors.top: testCanvas.top
        anchors.left: testCanvas.right
        clip: true
        spacing: global.dpi(5)
        model: dataSource.listData
        delegate: Item {
            height: global.dpi(20)
            width: parent.width
            Rectangle {
                id: itemRect
                anchors.fill: parent
                color: "#a1f27c"
            }
            Text {
                anchors.fill: parent
                text: modelData.name + " " + modelData.value + " " + modelData.unit
                font.family: qsTr("微软雅黑")
                font.pixelSize: global.dpi(11)
                color: Qt.darker(itemRect.color)
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    
}
