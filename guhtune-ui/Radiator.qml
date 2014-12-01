import QtQuick 2.3

Item {
    id: root

    property int targetValue: 22
    property int currentValue: 16

    property int minValue: 14
    property int maxValue: 35

    Repeater {
        model: 18

        Image {
            source: "qrc:///images/radiator-particle.svg"
            anchors.centerIn: parent
            height: parent.height * 0.96
            width: height
            sourceSize.height: height
            sourceSize.width: width

            rotation: (-3+index) * 15

            opacity: ((root.currentValue - root.minValue) * 18 / (root.maxValue - root.minValue)) > index ? 1 : 0.5
            Behavior on opacity {
                NumberAnimation { duration: 1000 * 30 }
            }
        }
    }

    Repeater {
        model: 18

        Image {
            source: "qrc:///images/radiator-particle-inset.svg"
            anchors.centerIn: parent
            height: parent.height * 0.96
            width: height
            sourceSize.height: height
            sourceSize.width: width

            rotation: (-3+index) * 15

            property int value: ((root.targetValue - root.minValue) * 18 / (root.maxValue - root.minValue))
            opacity: value > index - 18 / (maxValue - minValue) && value < index + 18 / (maxValue - minValue)
                     ? 1 : 0.5
        }
    }

    Text {
        color: "white"
        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: parent.height * 0.25
            bottomMargin: parent.height * 0.3
        }
        text: root.minValue + "°"
        font.pixelSize: root.height / 15
        font.family: "Ubuntu"
    }

    Text {
        color: "white"
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: parent.height * 0.25
            bottomMargin: parent.height * 0.3
        }
        text: root.maxValue + "°"
        font.pixelSize: root.height / 15
        font.family: "Ubuntu"
    }

    Text {
        color: "white"
        anchors {
            top: parent.top
            topMargin: parent.height * 0.2
            horizontalCenter: parent.horizontalCenter
        }
        text: ((root.maxValue - root.minValue) / 2) + "°"
        font.pixelSize: root.height / 15
        font.family: "Ubuntu"
    }

    Text {
        color: "white"
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: parent.height * 0.15
        }
        text: "AKTUELL"
        font.pixelSize: root.height / 15
        font.family: "Ubuntu"
    }

    Text {
        color: "white"
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: parent.height * 0.05
        }
        text: root.currentValue + "°"
        font.pixelSize: root.height / 10
        font.family: "Ubuntu"
    }
}
