import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: control

    property color bgColor: Qt.rgba(0.231, 0.259, 0.322, 0.85)       // Nord1 #3B4252
    property color activeBgColor: Qt.rgba(0.263, 0.298, 0.369, 0.92)  // Nord2 #434C5E

    contentItem: Text {
        text: control.text
        font: control.font
        color: "#ECEFF4"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 60
        color: control.down ? control.activeBgColor : control.bgColor
        border.color: "#88C0D0"
        border.width: 1
        radius: 3
    }
}
