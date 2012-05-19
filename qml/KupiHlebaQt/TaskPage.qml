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
                window.pageStack.push(Qt.resolvedUrl("TaskEditPage.qml"), {task: task});
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
                height: subCol.height + messageText.height + 20 + commentText.height + 20

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
                    Text{
                        id: messageText
                        text: task.message

                        wrapMode: Text.WordWrap
                        anchors.leftMargin: 10
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.right: parent.right
                        //color: "#fff"
                    }
                    Text{
                        id: commentText

                        text: task.comment

                        visible: false

                        wrapMode: Text.WordWrap

                        anchors.leftMargin: 50
                        anchors.right: parent.right
                        anchors.top: messageText.bottom
                        anchors.left: parent.left

                        //color: "#fff"
                    }
                    Column{
                        id: subCol
                        anchors.top: commentText.bottom
                        anchors.leftMargin: 30
                        anchors.right: parent.right
                        anchors.left: parent.left
                        spacing: 2
                        visible: true
                        Repeater{
                            model: task.subtasks
                            Item{
                                width: parent.width
                                height: subTaskMessage.height + subTaskComment.height
                                Text{
                                    id: subTaskMessage
                                    text: message
                                    wrapMode: Text.WordWrap

                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.left: parent.left

                                }
                                Text{
                                    id: subTaskComment
                                    text: comment

                                    anchors.top: subTaskMessage.bottom
                                    anchors.leftMargin: 30
                                    anchors.right: parent.right
                                    anchors.left: parent.left

                                    wrapMode: Text.WordWrap
                                    visible: true
                                }
                            }
                        }
                    }
                }
            }

    }


}
