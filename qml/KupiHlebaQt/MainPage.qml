import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: mainPage
    property alias loginForm: loginForm
    property alias registerForm: registerForm
    property alias tasksList: tasksList
    property alias flickPages: flickPages

    FlickPages{
        id: flickPages
        anchors.fill: parent
        content: [
            LoginForm{
                id: loginForm
                width: mainPage.width
                height: mainPage.height
            },
            RegisterForm{
                id: registerForm
                width: mainPage.width
                height: mainPage.height
            },
            TasksList{
                id: tasksList
                width: mainPage.width
                height: mainPage.height
            },
            Rectangle{
                id: item1
                width: mainPage.width;
                height: mainPage.height
                color: "green"
            }

        ]
    }


}
