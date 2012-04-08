import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: mainPage

    FlickPages{
        id: flickPages
        anchors.fill: parent
        content: [
            Rectangle{
                width: mainPage.width
                height: mainPage.height
                color: "green"
                Column{
                    width: mainPage.width
                    height: 300
                    TextArea{
                        height: 300
                        width: 300
                        text: "test text"
                    }
                }
            },
            RegisterForm{
                width: mainPage.width
                height: mainPage.height

            },
            TasksList{
                id: item2
                width: mainPage.width
                height: mainPage.height
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
