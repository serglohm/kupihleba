import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: rootItem
    property alias content: rowCnt.children

    property int currentPageIdx: flick.currentIdx
    property int pageCount: rowCnt.children.length
    Flickable{
        id: flick
        flickableDirection: Flickable.HorizontalFlick

        property int startX: 0
        property int stopX: 0
        property int currentIdx: 0
        property bool wasFlicked: false

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        clip: true

        flickDeceleration: 4000

        contentWidth: rowCnt.width
        contentHeight: rootItem.height
        Row{
            id: rowCnt
        }

        interactive: true
        Behavior on contentX {
            NumberAnimation {
                id: bouncebehavior
                easing.type: Easing.InOutQuad
            }
        }
        transitions: Transition {
            PropertyAnimation { property: "contentX"; easing.type: Easing.InOutQuart; duration: 300 }
        }

        onMovementStarted:{
            console.log("onMovementStarted");
            flick.startX = flick.contentX;
            flick.wasFlicked = false;
        }
        onMovementEnded:{
            console.log("onMovementEnded: " + flick.wasFlicked);
            if(! flick.wasFlicked){
                flick.stopX = flick.contentX;
                flick.currentIdx = Math.round(flick.stopX / rootItem.width);
                moveToIndex();
                console.log('move to ' + flick.currentIdx * rootItem.width);
            }
        }
        onFlickStarted:{
            flick.wasFlicked = true;
            flick.startX = flick.contentX
            console.log("onFlickStarted: " + flick.startX);
        }
        onFlickEnded:{
            flick.stopX = flick.contentX;
            if(flick.startX <= rootItem.width * (rootItem.pageCount - 1) && flick.startX > 0){
                if(flick.stopX - flick.startX > 0){
                    flick.currentIdx = Math.ceil(flick.stopX / rootItem.width);
                } else {
                    flick.currentIdx = Math.floor(flick.stopX / rootItem.width);
                }
                flick.currentIdx = Math.round(flick.stopX / rootItem.width);
            }
            if(flick.currentIdx < 0){flick.currentIdx = 0;}
            else if(flick.currentIdx > (rootItem.pageCount - 1)){flick.currentIdx = (rootItem.pageCount - 1);}

            console.log("onFlickEnded: " + flick.startX + " " + flick.stopX + ' ' + flick.currentIdx);
            moveToIndex();
        }
    }
    function moveToPrev(){
        flick.currentIdx--;
        if(flick.currentIdx < 0){flick.currentIdx = 0;}
        moveToIndex();
    }
    function moveToNext(){
        flick.currentIdx++;
        if(flick.currentIdx > 3){flick.currentIdx = 3;}
        moveToIndex();
    }

    function moveToIndex(){
        flick.contentX = flick.currentIdx * rootItem.width;
    }
}
