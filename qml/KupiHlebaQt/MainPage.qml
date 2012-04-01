import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: mainPage

    FlickPages{
        id: flickPages
        anchors.fill: parent
        content: [
            Rectangle{
                id: item2
                width: mainPage.width;
                height: mainPage.height
                color: "red"
            },
            Rectangle{
                id: item1
                width: mainPage.width;
                height: mainPage.height
                color: "blue"
            }

        ]
    }


}