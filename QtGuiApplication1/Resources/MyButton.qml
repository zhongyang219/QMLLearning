import QtQuick 2.7
Rectangle
{
    id: root
    width: 70
    height: 26
    color: btn1Area.pressed ? "#69B2FF" : (btn1Area.containsMouse ? "#95C9FF" : "#C8E3FF")
    border.color: "#69B2FF"
    radius: 6
    signal clicked

    property string btnText: ""

    MouseArea
    {
        id: btn1Area
        anchors.fill: parent
        hoverEnabled: true
        enabled: true
        onClicked: {
            root.clicked();
        }
    }

    Text {
        id: label
        text: root.btnText
        anchors.centerIn: parent    //文本显示在按钮中间
        font.family: qsTr("微软雅黑")
        font.pixelSize: 11
        color: "#012C6E"
    }
}
