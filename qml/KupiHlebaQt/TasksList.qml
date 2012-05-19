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
            height: messageText.height + 20
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
                    anchors.right: parent.right
                    //color: "#fff"
                }
                MouseArea{
                    anchors.left: bannerDelegateRectangle.left
                    anchors.top: bannerDelegateRectangle.top
                    anchors.bottom: bannerDelegateRectangle.bottom
                    anchors.right: bannerDelegateRectangle.right

                    onClicked:{
                        window.pageStack.push(Qt.resolvedUrl("TaskPage.qml"), {task: myModel.get(index)});
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
