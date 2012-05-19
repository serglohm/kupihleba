import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    anchors.fill: parent

    property variant task: 0

    signal taskClicked

    tools: toolBarLayout

    ToolBarLayout {
        id: toolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
        ToolButton {
            flat: true
            iconSource: "toolbar-menu"
            onClicked: {
                window.pageStack.push(Qt.resolvedUrl("SplitViewPage.qml"));
            }
        }
    }

    Flickable{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left

        //contentWidth: taskItem.width
        contentHeight: taskItem.height


        Item{
            id: taskItem
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            height: subCol.height + messageText.height + commentText.height + splitViewInput.height + unusedItem.height

            Rectangle{
                id: bannerDelegateRectangle

                color: "white"
                radius: 5
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 0
                clip: true
                TextArea{
                    id: messageText
                    text: task.message
                    wrapMode: Text.WordWrap
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                }
                TextArea{
                    id: commentText
                    text: task.comment
                    visible: false
                    wrapMode: Text.WordWrap
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: messageText.bottom
                }



                Column{
                    id: subCol
                    anchors.top: commentText.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    spacing: 2
                    visible: true
                    Repeater{
                        model: task.subtasks
                        Item{
                            width: parent.width
                            height: subTaskMessage.height + subTaskComment.height
                            TextArea{
                                id: subTaskMessage
                                text: message
                                wrapMode: Text.WordWrap

                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.left: parent.left

                            }
                            TextArea{
                                id: subTaskComment
                                text: comment

                                anchors.top: subTaskMessage.bottom
                                anchors.right: parent.right
                                anchors.left: parent.left

                                wrapMode: Text.WordWrap
                                visible: true
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: splitViewInput

                color: "red"
                anchors { bottom: unusedItem.top; left: parent.left; right: parent.right }
                Behavior on height { PropertyAnimation { duration: 200 } }

                states: [
                    State {
                        name: "Visible"; when: inputContext.visible
                        PropertyChanges { target: splitViewInput; height: inputContext.height }
                    },

                    State {
                        name: "Hidden"; when: !inputContext.visible
                        PropertyChanges { target: splitViewInput; height: 1 }
                    }
                ]
            }
            Button{
                text: "unused"
                id: unusedItem
                height: 40;
                anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
            }

        }


    }

    Text{
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        text: "h = " + splitViewInput.height
        height: 50
        color: "red"
    }
}
