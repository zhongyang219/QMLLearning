import QtQuick 2.7


Rectangle {
    id: root
    width: global.dpi(40)
    height: global.dpi(24)
    property string text: ""
    color: "lightGreen"

    Global {
        id: global
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: global.dpi(11)
        text: root.text
        color: Qt.darker(root.color)
        font.family: qsTr("微软雅黑")
    }
}
