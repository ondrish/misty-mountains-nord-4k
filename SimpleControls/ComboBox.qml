import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id: control

    delegate: ItemDelegate {
        id: itemDelegate
        text: model.realName ? model.realName : model.name
        width: control.width
        contentItem: Text {
            text: itemDelegate.text
            color: "#ECEFF4"
            font: itemDelegate.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            visible: itemDelegate.down || itemDelegate.highlighted || itemDelegate.visualFocus
            color: Qt.rgba(0.263, 0.298, 0.369, 0.92)
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 24
        height: 16
        contextType: "2d"

        Connections {
            target: control
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = "#88C0D0";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 5
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText ? control.displayText : getValue()
        font: control.font
        color: "#ECEFF4"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 240
        implicitHeight: 60
        border.color: "#88C0D0"
        border.width: 1
        color: control.pressed ? Qt.rgba(0.263, 0.298, 0.369, 0.92) : Qt.rgba(0.231, 0.259, 0.322, 0.85)
        radius: 3
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#88C0D0"
            color: Qt.rgba(0.231, 0.259, 0.322, 0.85)
        }
    }

    function getValue() {
        var items = control.delegateModel.items
        var index = control.currentIndex
        if (0 <= index && index < items.count) {
            return items.get(index).model.name
        }
        // index error, return last user
        else {
            return userModel.lastUser
        }
    }
}
