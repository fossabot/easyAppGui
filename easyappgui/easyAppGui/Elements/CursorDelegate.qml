import QtQuick 2.13

Rectangle {
    id: cursor

    ///color: parent.Material.accentColor
    width: 2
    visible: parent.activeFocus && !parent.readOnly && parent.selectionStart === parent.selectionEnd

    Connections {
        target: cursor.parent
        onCursorPositionChanged: {
            // keep a moving cursor visible
            cursor.opacity = 1
            timer.restart()
        }
    }

    Timer {
        id: timer
        running: cursor.parent.activeFocus && !cursor.parent.readOnly && interval != 0
        repeat: true
        interval: Qt.styleHints.cursorFlashTime / 2
        onTriggered: cursor.opacity = !cursor.opacity ? 1 : 0
        // force the cursor visible when gaining focus
        onRunningChanged: cursor.opacity = 1
    }
}
