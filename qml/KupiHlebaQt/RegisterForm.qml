import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: regForm
    state: "showForm"
    property alias username: usernameText.text
    property alias password: passwordText.text
    property alias confirmPassword: confirmPasswordText.text
    property alias email: emailText.text

    states: [
        State {
            name: "showForm"
            PropertyChanges { target: registerCol; visible: true }
            PropertyChanges { target: indicator; visible: false}
            PropertyChanges { target: indicator; running: false}
        },
        State {
            name: "loaded"
            PropertyChanges { target: registerCol; visible: false }
            PropertyChanges { target: indicator; visible: true }
            PropertyChanges { target: indicator; running: true }
        }
    ]

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        running: false
        width: parent.width / 3
        height: parent.width / 3
        visible: false
    }

    Column{
        id: registerCol
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
        Label{
            width: parent.width
            text: "Confirm Password"
        }
        TextArea{
            id: confirmPasswordText
            width: parent.width
            text: ""
        }
        Label{
            width: parent.width
            text: "E-mail"
        }
        TextArea{
            id: emailText
            width: parent.width
            text: ""
        }
        Button{
            width: parent.width
            text: "Register"
            onClicked: {
                regForm.state = "loaded";
            }
        }

    }

}
