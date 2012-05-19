import QtQuick 1.1
import com.nokia.symbian 1.1


Item{
    id: loginForm
    property alias username: usernameText.text
    property alias password: passwordText.text

    Column{
        id: loginCol
        anchors.fill: parent

        anchors.leftMargin: platformStyle.paddingLarge
        anchors.rightMargin: platformStyle.paddingLarge
        anchors.topMargin: platformStyle.paddingLarge

        spacing: 5

        Label{
            width: parent.width
            text: "Username"
        }
        TextArea{
            id: usernameText
            width: parent.width
            text: ""
        }
        Label{
            width: parent.width
            text: "Password"
        }
        TextArea{
            id: passwordText
            text: ""
            width: parent.width
        }
        Button{
            text: "Login"
            width: parent.width
            onClicked: {
                login(username, password);
            }
        }

    }
}
