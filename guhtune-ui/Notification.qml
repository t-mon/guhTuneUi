import QtQuick 2.3

Rectangle {
    id: root
    anchors {
        top: parent.top
        right: parent.right
        margins: parent.height / 20
    }

    height: parent.height / 10
    width: height * 4
    radius: height / 10
    opacity: timer.running ? 1 : 0
    Behavior on opacity {
        NumberAnimation {}
    }

    function play() {
        playStatusText.text = "Playing"
        timer.restart();
    }

    function stop() {
        playStatusText.text = "Stopped"
        timer.restart();
    }

    Timer {
        id: timer
        interval: 5000
        running: false
        repeat: false
    }

    Row {
        anchors.fill: parent
        anchors.margins: parent.height / 10
        spacing: parent.height / 10

        Image {
            source: "qrc:///images/music.svg"
            height: parent.height
            width: height
            sourceSize.height: height
            sourceSize.width: width
        }

        Column {
            width: parent.width - x
            Text {
                text: "Funk Chili"
                font.pixelSize: root.height / 4
            }
            Text {
                text: "Play that funky music"
                font.pixelSize: root.height / 5
            }
            Text {
                id: playStatusText
                font.pixelSize: root.height / 4
                font.bold: true
            }
        }
    }
}
