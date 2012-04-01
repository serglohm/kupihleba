import QtQuick 1.1
import com.nokia.symbian 1.1

Item{
    id: rootRect

    property int selectedId: -1;
    property int selectedIdx: -1;

    property string sid: "d78f9b9fe18037214e2ad1703c40b21e"
    property string urlstart: "http://kupihleba.ru"

    signal taskClicked

    property variant noTimeTasks: 0


    Component.onCompleted:{
        console.log('onCompleted');
        var obj = new Object();
        noTimeTasks = obj;
    }

    Button{
        id: loadAllBtn
        text: "loadAll"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: {
            indicator.running = true;
            indicator.visible = true;

            try{
                var load_url = rootRect.urlstart + '/cgi-bin/mf_widget.cgi?sid=' + rootRect.sid + '&cmd=load_all&rnd=' + Math.random(1);
                getJSON(load_url, function(data){
                    parseLoadAll(data);
                });
            } catch(e){
                console.log(obj2json(e));
            }

        }
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
        anchors.top: loadAllBtn.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.topMargin: 10
        clip: true
        delegate: delegate
        model: myModel
        visible: false
    }

    function parseLoadAll(data){
        var subtasks = new Array();
        var tempArray = new Array();
        for(var i = 0; i < data.notime_tasks.length; i++){
            var task = data.notime_tasks[i];
            task.qmlState = 'off';
            if(task.comment != ''){
                task.comment = task.comment.split('\r').join('<br>');
            }

            if(parseInt(task.list_nid) == 0){
                task.subtasks = new Array();
                tempArray[task.nid] = task;
            } else {
                subtasks.push(task);
            }
        }

        for(var i = 0; i < subtasks.length; i++){
            tempArray[subtasks[i].list_nid].subtasks.push(subtasks[i]);
            //console.log(subtasks[i].list_nid + ' ' + tempArray[subtasks[i].list_nid]);

            //console.log(obj2json(subtasks[i]));
        }
        //noTimeTasks = tempArray;
        for(var i in tempArray){
            myModel.append(tempArray[i]);
        }
        indicator.visible = false;
        indicator.running = false;

        list.visible = true;
    }



    function postJSON(url, data, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.onreadystatechange = function()
        {
            console.log("readyState: " + xhr.readyState + "\n");
            console.log("status: " + xhr.status + "\n");

            if ( xhr.readyState == xhr.DONE){
                if ( xhr.status == 200){
                    var jsonObject = eval('(' + xhr.responseText + ')');
                    callback(jsonObject);
                } else {
                    console.log("ERROR\n Headers: " + xhr.getAllResponseHeaders() + "\n");
                }
            }
        }
        xhr.send(data);
    }

    function getJSON(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);
        xhr.onreadystatechange = function()
        {
            if ( xhr.readyState == xhr.DONE)
            {
                if ( xhr.status == 200)
                {
                    var jsonObject = eval('(' + xhr.responseText + ')');
                    callback(jsonObject);
                } else{
                    console.log("ERROR: " + xhr.responseText + "\n");
                }
            }
        }
        xhr.send(null);
    }

    function obj2json(obj){
        var str = '{';
        var f = 0;
        for( var p in obj) {
            if(f){str += ", "} else {f = 1;}
            if(obj[p] instanceof Array){
                var arr = obj[p];
                str += '"' + p + '":[';
                for(var i = 0; i < arr.length; i++){
                    if(i > 0){str += ','}
                    if(arr[i] instanceof Object){
                        str += obj2json(arr[i]);
                    } else {
                        str += '"' + arr[i] + '"';
                    }
                }
                str += ']';
            } else if(obj[p] instanceof Object){
                str += '"' + p + '":';
                str += obj2json(obj[p]);
            } else {
                str += '"' + p + '":"' + obj[p] + '"';
            }
        }
        str += '}';
        return str;
    }


}
