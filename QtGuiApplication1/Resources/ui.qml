import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
Rectangle {
    id: root
    width: 800
    height: 320
    visible: true
    color: "#F2F8FF"
    //property var dataSource: null

    signal btn1Clicked()
    signal edit1TextChanged(var text)

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
        anchors.margins: 10
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
        anchors.leftMargin: 10
        width: 120
        height: 26
        color: "#012C6E"
        font.family: qsTr("微软雅黑")
        font.pixelSize: 11
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
        anchors.leftMargin: 10
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
        anchors.leftMargin: 10
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
        width: 200
        height: 24
        anchors.left: btn1.left
        anchors.top: btn1.bottom
        anchors.topMargin: 10
        color: "#012C6E"
        font.family: qsTr("微软雅黑")
        font.pixelSize: 11

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
        anchors.margins: 10
        spacing: 2
        Repeater {
            model: ["Enterprise", "Colombia", "Challenger", "Discovery", "Endeavour"]
            Rectangle {
                width: 100
                height: 20
                radius: 3
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
        width: 290
        height: 200
        color: "white"
        anchors.left: columExample.right
        anchors.top: label.bottom
        anchors.margins: 10

        property bool bRound: false     //是否使用圆角矩形
        property bool bList: true       //是否使用列表视图
        property int itemWidth: bList ? 150 : 40

        ListView {
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 100
            delegate: parent.bRound ? numberDelegate1 : numberDelegate
            spacing: 5
            visible: parent.bList
        }

        GridView {
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 100
            cellWidth: 50
            cellHeight: 32
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
                radius: 6
                color: "#FDB4AD"
                text: index
            }
        }
    }


    Canvas {
        id: testCanvas
        width: 100; height: 150
        anchors.left: listExample.right
        anchors.top: root.top
        anchors.margins: 10
        onPaint: {
            var ctx = getContext("2d")
            // setup your path
            // fill or/and stroke
            ctx.strokeStyle = "red"
            // create a path
            ctx.beginPath()
            ctx.moveTo(0,0)
            ctx.lineTo(50,0)
            // stroke path
            ctx.stroke()
        }
    }

    ListView {
        width: 200
        height: 300
        anchors.top: testCanvas.top
        anchors.left: testCanvas.right
        clip: true
        spacing: 5
        model: dataSource.listData
        delegate: Item {
            height: 20
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
                font.pixelSize: 11
                color: Qt.darker(itemRect.color)
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    
}
