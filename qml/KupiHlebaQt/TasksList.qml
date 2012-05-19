import QtQuick 1.1
import com.nokia.symbian 1.1

Item{
    id: taskList

    property int selectedId: -1;
    property int selectedIdx: -1;

    property alias model: myModel
    property alias list: list
    property alias indicator: indicator
    signal taskClicked

    property variant noTimeTasks: 0


    Component.onCompleted:{
        console.log('onCompleted');
        var obj = new Object();
        noTimeTasks = obj;
    }
    Component {
        id: delegate
        Item{
            id: taskItem
            anchors.right: parent.right
            anchors.left: parent.left

            states:[
                State{
                    name: 'on'
                    PropertyChanges { target: commentText; visible: true}
                    PropertyChanges { target: subCol; visible: true}
                    PropertyChanges { target: subtaskButton; text: '-'}
                    PropertyChanges { target: taskItem; height: subCol.height + messageText.height + 20 + commentText.height + 20}

                },
                State{
                    name: 'off'
                    PropertyChanges { target: commentText; visible: false}
                    PropertyChanges { target: subCol; visible: false}
                    PropertyChanges { target: subtaskButton; text: '+'}
                    PropertyChanges { target: taskItem; height: subtaskButton.height + 20}
                }

            ]
            state: qmlState

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
                    text: message

                    wrapMode: Text.WordWrap
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: subtaskButton.left
                    //color: "#fff"
                }
                MouseArea{
                    anchors.left: bannerDelegateRectangle.left
                    anchors.top: bannerDelegateRectangle.top
                    anchors.bottom: bannerDelegateRectangle.bottom
                    anchors.right: bannerDelegateRectangle.right

                    onClicked:{
                        rootRect.selectedId = nid;
                        rootRect.selectedIdx = index;
                        rootRect.taskClicked();
                        console.log('MouseArea Clicked');
                    }
                }
                Button{
                    id: subtaskButton
                    text: '+'
                    visible: true
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 5
                    onClicked:{
                        taskItem.state = taskItem.state == 'off'? 'on': 'off';
                        myModel.setProperty(index, "qmlState", taskItem.state);
                        rootRect.selectedId = nid;
                        rootRect.selectedIdx = index;
                        rootRect.taskClicked();
                    }

                }
                Text{
                    id: commentText

                    text: comment

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
                        model: subtasks
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

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        running: false
        width: parent.width / 3
        height: parent.width / 3
        visible: false
    }


    ListModel{
        id: myModel

    }

    ListView{
        id: list
        anchors.fill: parent
        anchors.topMargin: 10
        clip: true
        delegate: delegate
        model: myModel
        visible: false
    }




}
