import QtQuick 1.1
import com.nokia.symbian 1.1

import "code.js" as Code
import "engine.js" as Engine
import "myDB.js" as Mdb

PageStackWindow {
    id: window
    initialPage: MainPage {
        id: mainPage
        tools: toolBarLayout
    }
    showStatusBar: true
    showToolBar: true
    //platformSoftwareInputPanelEnabled: true

    ToolBarLayout {
        id: toolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
        ToolButton {
            flat: true
            iconSource: "toolbar-home"
            onClicked: {

            }
        }
    }

    function login(uname, password){
        Engine.engineLogin(uname, password);

    }
}
