import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: window


    ToolBar {
        id: topToolBar

        anchors { left: parent.left; right: parent.right; top: statusBar.bottom }

        tools: ToolBarLayout {
            ToolButton { text: "Untitled"; enabled: false; flat: true }
            ToolButton { iconSource: "toolbar-add" }
        }
    }

    Item {
        id: filler

        anchors { left: parent.left; right: parent.right; top: topToolBar.bottom }
        height: platformStyle.graphicSizeMedium * 2 - topToolBar.height

        Text {
            id: dateText

            anchors {
                left: parent.left; leftMargin: platformStyle.paddingSmall
                verticalCenter: parent.verticalCenter
            }

            color: platformStyle.colorNormalLight
            font { family: platformStyle.fontFamilyRegular; pixelSize: platformStyle.fontSizeMedium; weight: Font.Bold }
            text: Qt.formatDate(new Date(), " dddd d MMMM yyyy")
        }

        Text {
            id: timeText

            anchors {
                right: parent.right; rightMargin: platformStyle.paddingSmall
                verticalCenter: parent.verticalCenter
            }

            color: platformStyle.colorNormalLight
            font { family: platformStyle.fontFamilyRegular; pixelSize: platformStyle.fontSizeMedium; weight: Font.Bold }
            text: symbian.currentTime

            Behavior on opacity { PropertyAnimation { duration: 200 } }
        }

        states: [
            State {
                name: "Edit"; when: inputContext.visible
                AnchorChanges { target: dateText; anchors.left: parent.left }
                PropertyChanges { target: timeText; opacity: 1 }
            },

            State {
                name: "View"; when: !inputContext.visible
                AnchorChanges { target: dateText; anchors.left: undefined; anchors.horizontalCenter: parent.horizontalCenter }
                PropertyChanges { target: timeText; opacity: 0 }
            }
        ]

        transitions: [ Transition { AnchorAnimation { duration: 200 } } ]
    }

    TextArea {
        id: textArea

        anchors {
            top: filler.bottom; bottom: splitViewInput.top
            left: parent.left; right: parent.right;
        }

        placeholderText: "Tap to write"

        Behavior on height { PropertyAnimation { duration: 200 } }
    }

    Item {
        id: splitViewInput

        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }

        Behavior on height { PropertyAnimation { duration: 200 } }

        states: [
            State {
                name: "Visible"; when: inputContext.visible
                PropertyChanges { target: splitViewInput; height: inputContext.height }
            },

            State {
                name: "Hidden"; when: !inputContext.visible
                PropertyChanges { target: splitViewInput; height: toolBar.height }
            }
        ]
    }

    ToolBar {
        id: toolBar

        anchors { bottom: parent.bottom }

        opacity: !inputContext.visible

        Behavior on opacity { PropertyAnimation { duration: 200 } }

        tools: ToolBarLayout {

            ToolButton { iconSource: "toolbar-back"; onClicked: window.pageStack.pop() }

            ButtonRow {
                exclusive: false
                ToolButton { iconSource: "toolbar-previous" }
                ToolButton { iconSource: "toolbar-share" }
                ToolButton { iconSource: "toolbar-delete" }
                ToolButton { iconSource: "toolbar-next" }
            }
        }
    }

}
