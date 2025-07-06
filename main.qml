import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Calculator 1.0

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: "Give me the offer, please"
    color: "#024873"

    minimumWidth: 360
    maximumWidth: 360
    minimumHeight: 640
    maximumHeight: 640

    Calculator {
        id: calculator
    }

    FontLoader {
        id: oss
        source: "fonts/Open_Sans_Semibold.ttf"
    }

    Rectangle {
        height: 160
        width: parent.width
        color: "#04bfad"
        radius: 25

        Rectangle {
            height: 50
            width: parent.width
            color: "#04bfad"
        }

        Text {
            id: expressionText
            width: parent.width
            font.family: oss.font.family
            font.pixelSize: 24
            color: "white"
            text: calculator.expression
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 105
        }

        Text {
            id: resultText
            width: parent.width
            font.family: oss.font.family
            font.pixelSize: 48
            color: "white"
            text: calculator.result
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
        }
    }

    Timer {
        id: holdTimer
        interval: 4000
        running: false
        repeat: false
        onTriggered: {
            passwordWindow.visible = true;
        }
    }

    Window {
        id: passwordWindow
        width: 200
        height: 200
        visible: false
        title: "Введите пароль"
        color: "#B0D1D8"

        TextField {
            id: passwordInput
            anchors.centerIn: parent
            width: 150
            height: 40
            font.pixelSize: 16
            echoMode: TextInput.Password
            placeholderText: "Введите пароль"
            placeholderTextColor: "black"

            onTextChanged: {
                if (passwordInput.text !== "") {
                    passwordInput.placeholderText = "";
                }
            }

            onAccepted: {
                if (passwordInput.text === "123") {
                    secretWindow.visible = true;
                    passwordWindow.visible = false;
                } else {
                    passwordInput.clear();
                    passwordInput.placeholderText = "Неверный пароль!";
                }
            }
        }

        Button {
            height: 20
            width: 60

            Text {
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.horizontalCenter: parent.horizontalCenter
                text: "назад"
                color: "black"
            }

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: passwordWindow.visible = false
        }
    }

    Window {
        id: secretWindow
        width: 400
        height: 300
        visible: false
        title: "Секретное меню"

        Text {
            anchors.centerIn: parent
            color: "black"
            font.pixelSize: 20
            text: "Добро пожаловать в секретное меню!"
        }

        Button {
            height: 60
            width: 180

            Text {
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                text: "назад"
                color: "black"
                font.pixelSize: 20
            }

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: secretWindow.visible = false
        }
    }

    GridLayout {
        columns: 4
        rowSpacing: 16
        columnSpacing: 16
        anchors.topMargin: 180
        anchors.fill: parent
        anchors.margins: 20

        Repeater {
            model: ["bkt", "plus_minus", "percent", "division"]
            Button {
                Layout.preferredHeight: 70
                Layout.preferredWidth: 70
                background: Rectangle {
                    color: parent.pressed ? "#f7e425" : "#0889A6"
                    radius: width/2
                }

                Image {
                    anchors.centerIn: parent
                    source: "images/" + modelData + ".png"
                }

                onClicked: {
                    if (modelData === "bkt") calculator.brackets()
                    else if (modelData === "plus_minus") calculator.toggleSign()
                    else if (modelData === "percent") calculator.inputPercent()
                    else if (modelData === "division") calculator.inputOperator("/")
                }
            }
        }

        Repeater {
            model: ["7", "8", "9"]
            Button {
                Layout.preferredHeight: 70
                Layout.preferredWidth: 70
                background: Rectangle {
                    color: parent.pressed ? "#04bfad" : "#b0d1d8"
                    radius: width/2
                }

                Text {
                    anchors.centerIn: parent
                    color: parent.pressed ? "white" : "#024873"
                    text: modelData
                    font.family: oss.font.family
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: calculator.inputDigit(modelData)
            }
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#f7e425" : "#0889A6"
                radius: width/2
            }

            Image {
                anchors.centerIn: parent
                source: "images/multiplication.png"
            }

            onClicked: calculator.inputOperator("*")
        }

        Repeater {
            model: ["4", "5", "6"]
            Button {
                Layout.preferredHeight: 70
                Layout.preferredWidth: 70
                background: Rectangle {
                    color: parent.pressed ? "#04bfad" : "#b0d1d8"
                    radius: width/2
                }

                Text {
                    anchors.centerIn: parent
                    color: parent.pressed ? "white" : "#024873"
                    text: modelData
                    font.family: oss.font.family
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: calculator.inputDigit(modelData)
            }
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#f7e425" : "#0889A6"
                radius: width/2
            }

            Image {
                anchors.centerIn: parent
                source: "images/minus.png"
            }

            onClicked: calculator.inputOperator("-")
        }

        Repeater {
            model: ["1", "2", "3"]
            Button {
                Layout.preferredHeight: 70
                Layout.preferredWidth: 70
                background: Rectangle {
                    color: parent.pressed ? "#04bfad" : "#b0d1d8"
                    radius: width/2
                }

                Text {
                    anchors.centerIn: parent
                    color: parent.pressed ? "white" : "#024873"
                    text: modelData
                    font.family: oss.font.family
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: calculator.inputDigit(modelData)
            }
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#f7e425" : "#0889A6"
                radius: width/2
            }

            Image {
                anchors.centerIn: parent
                source: "images/plus.png"
            }

            onClicked: calculator.inputOperator("+")
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: "#f9aeae"
                radius: width/2
            }

            Image {
                anchors.centerIn: parent
                width: 70
                height: 70
                fillMode: Image.Stretch
                source: parent.pressed ? "images/active.png" : "images/normal.png"
            }

            onClicked: calculator.clear()
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#04bfad" : "#b0d1d8"
                radius: width/2
            }

            Text {
                anchors.centerIn: parent
                color: parent.pressed ? "white" : "#024873"
                text: "0"
                font.family: oss.font.family
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: calculator.inputDigit("0")
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#04bfad" : "#b0d1d8"
                radius: width/2
            }

            Text {
                anchors.centerIn: parent
                color: parent.pressed ? "white" : "#024873"
                text: "."
                font.family: oss.font.family
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: calculator.inputDigit(".")
        }

        Button {
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            background: Rectangle {
                color: parent.pressed ? "#f7e425" : "#0889A6"
                radius: width/2
            }

            Image {
                anchors.centerIn: parent
                source: "images/equal.png"
            }

            onPressed: {
                holdTimer.start()
            }

            onReleased: {
                holdTimer.stop()
            }

            onClicked: calculator.calculate()
        }
    }
}
