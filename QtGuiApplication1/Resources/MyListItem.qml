import QtQuick 2.7


Rectangle {
    id: root
    width: 40
    height: 24
    property string text: ""
    color: "lightGreen"
    Text {
        anchors.centerIn: parent
        font.pixelSize: 11
        text: root.text
        color: Qt.darker(root.color)
        font.family: qsTr("微软雅黑")
    }
}
