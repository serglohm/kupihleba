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
        TextField{
            id: usernameText
            width: parent.width
            text: "user1"
        }
        Label{
            width: parent.width
            text: "Password"
        }
        TextField{
            id: passwordText
            text: "qwerty"
            width: parent.width
            echoMode: TextInput.Password
        }
        Label {
            width: parent.width
            text: qsTr("Remember me")
        }

        CheckBox {
            id: rememberMe
            checked: true
            anchors.left: parent.left
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
