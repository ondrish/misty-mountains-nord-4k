import QtQuick 2.12
import QtQuick.Controls 2.12
import SddmComponents 2.0
import "SimpleControls" as Simple

Rectangle {

    readonly property color backgroundColor: Qt.rgba(0.231, 0.259, 0.322, 0.85)      // Nord1 #3B4252
    readonly property color hoverBackgroundColor: Qt.rgba(0.263, 0.298, 0.369, 0.92) // Nord2 #434C5E

    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        function onLoginSucceeded() {}

        function onLoginFailed() {
            pw_entry.clear()
            pw_entry.focus = true

            errorMsgContainer.visible = true
        }
    }

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        Simple.ComboBox {
            id: user_entry
            model: userModel
            currentIndex: userModel.lastIndex
            textRole: "realName"
            width: 500
            height: 60
            font.pixelSize: 24
            KeyNavigation.backtab: session
            KeyNavigation.tab: pw_entry
        }

        TextField {
            id: pw_entry
            color: "#ECEFF4"
            echoMode: TextInput.Password
            focus: true
            placeholderText: textConstants.promptPassword
            width: 500
            height: 60
            font.pixelSize: 24
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 60
                color: pw_entry.activeFocus ? hoverBackgroundColor : backgroundColor
                border.color: "#88C0D0"
                radius: 3
            }
            onAccepted: sddm.login(user_entry.getValue(), pw_entry.text, session.currentIndex)
            KeyNavigation.backtab: user_entry
            KeyNavigation.tab: loginButton
        }

        Simple.Button {
            id: loginButton
            text: textConstants.login
            width: 500
            height: 60
            font.pixelSize: 24
            bgColor: "#5E81AC"
            activeBgColor: "#81A1C1"
            onClicked: sddm.login(user_entry.getValue(), pw_entry.text, session.currentIndex)
            KeyNavigation.backtab: pw_entry
            KeyNavigation.tab: suspend
        }

        Rectangle {
            id: errorMsgContainer
            width: 500
            height: loginButton.height
            color: "#BF616A"
            clip: true
            visible: false
            radius: 3

            Label {
                anchors.centerIn: parent
                text: textConstants.loginFailed
                width: 480
                color: "#ECEFF4"
                font.bold: true
                font.pixelSize: 24
                elide: Qt.locale().textDirection == Qt.RightToLeft ? Text.ElideLeft : Text.ElideRight
                horizontalAlignment: Qt.AlignHCenter
            }
        }

    }

    Row {
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 10

        Simple.Button {
            id: suspend
            text: textConstants.suspend
            height: 60
            font.pixelSize: 24
            onClicked: sddm.suspend()
            visible: sddm.canSuspend
            KeyNavigation.backtab: loginButton
            KeyNavigation.tab: hibernate
        }

        Simple.Button {
            id: hibernate
            text: textConstants.hibernate
            height: 60
            font.pixelSize: 24
            onClicked: sddm.hibernate()
            visible: sddm.canHibernate
            KeyNavigation.backtab: suspend
            KeyNavigation.tab: restart
        }

        Simple.Button {
            id: restart
            text: textConstants.reboot
            height: 60
            font.pixelSize: 24
            onClicked: sddm.reboot()
            visible: sddm.canReboot
            KeyNavigation.backtab: suspend; KeyNavigation.tab: shutdown
        }

        Simple.Button {
            id: shutdown
            text: textConstants.shutdown
            height: 60
            font.pixelSize: 24
            onClicked: sddm.powerOff()
            visible: sddm.canPowerOff
            KeyNavigation.backtab: restart; KeyNavigation.tab: session
        }
    }

    Simple.ComboBox {
        id: session
        anchors {
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 20
        }
        currentIndex: sessionModel.lastIndex
        model: sessionModel
        textRole: "name"
        width: 400
        height: 60
        font.pixelSize: 24
        visible: sessionModel.rowCount() > 1
        KeyNavigation.backtab: shutdown
        KeyNavigation.tab: user_entry
    }

    Rectangle {
        id: timeContainer
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 20
            rightMargin: 20
        }
        border.color: "#88C0D0"
        radius: 3
        color: backgroundColor
        width: timelb.width + 20
        height: session.height

        Label {
            id: timelb
            anchors.centerIn: parent
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: "#88C0D0"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Timer {
        id: timetr
        interval: 500
        repeat: true
        running: true
        onTriggered: {
            timelb.text = Qt.formatDateTime(new Date(), "HH:mm")
        }
    }
}
