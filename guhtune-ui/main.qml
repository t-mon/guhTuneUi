/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                                                                         *
 *  This file is part of guh.                                              *
 *                                                                         *
 *  Guh is free software: you can redistribute it and/or modify            *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation, version 2 of the License.                *
 *                                                                         *
 *  Guh is distributed in the hope that it will be useful,                 *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with guh. If not, see <http://www.gnu.org/licenses/>.            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

import QtQuick 2.1
import core 1.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    anchors.fill: parent
    color: "#000000"

    Component.onCompleted: root.forceActiveFocus()

    property int currentItem: 3
    property bool buttonPressed: false
    property bool selectionMode: false
    property bool sleeping: false

    property bool selectedWhilePressed: false

    Connections {
        target: controller
        onButtonPressed: {
            if (root.selectionMode) {
                root.selectionMode = false;
            } else {
                root.buttonPressed = true;
                root.selectedWhilePressed = false;
            }
        }
        onButtonReleased: {
            root.buttonPressed = false;
            if (root.selectedWhilePressed) {
                root.selectionMode = false;
            }
        }
        onSmallStep: {
            print("smallstep!", rotation);
            if (!root.selectionMode) {
                var currentItem = repeater.itemAt(root.currentItem);
                currentItem.value = Math.min(100, Math.max(0, currentItem.value + (rotation == Core.RotationLeft ? -1 : 1)));
                controller.setValue(root.currentItem, currentItem.value)
            }
        }
        onBigStep: {
            print("bigstep!", rotation);
            if (root.selectionMode) {
                if (rotation == Core.RotationLeft) {
                    root.currentItem = (root.currentItem + 1) % 4;
                } else {
                    if (root.currentItem == 0) {
                        root.currentItem = 3;
                    } else {
                        root.currentItem--;
                    }
                }
            }
            root.selectedWhilePressed = true;
        }
        onHandDisappeared: {
            root.sleeping = false;
            sleepTimer.restart()
        }
        onHandDetected: {
            root.sleeping = false;
            sleepTimer.stop();
        }
    }

    Timer {
        running: root.buttonPressed
        interval: 300
        repeat: false
        onTriggered: {
            selectionMode = true;
        }
    }

    Timer {
        id: sleepTimer
        interval: 5000
        repeat: repeat
        running: !root.selectionMode
        onTriggered: {
            root.sleeping = true
        }
    }

    onButtonPressedChanged: {
        if (!root.buttonPressed) {
            controller.toggle(root.currentItem)
            selectionMode = false;

            switch (root.currentItem) {
            case 0:
                notification.play();
                break;
            case 1:
                notification.stop();
                break;
            }

        }
        root.sleeping = false;
        sleepTimer.restart();
    }

    states: [
        State {
            name: "splash"; when: splashTimer.running && !root.sleeping
            PropertyChanges { target: splashImage; opacity: 1 }
        },
        State {
            name: "buttons"; when: !splashTimer.running && !root.sleeping
            PropertyChanges { target: rotator; opacity: 1 }
        },
        State {
            name: "clock"; when: root.sleeping
            PropertyChanges { target: clock; opacity: 1 }
        }

    ]
    transitions: [
        Transition {
            from: "clock"
            to: "buttons"
            PropertyAnimation { target: splashImage; property: "opacity"; duration: 200 }
            PropertyAnimation { target: rotator; property: "opacity"; duration: 200 }
            PropertyAnimation { target: clock; property: "opacity"; duration: 200 }
        },
        Transition {
            PropertyAnimation { target: splashImage; property: "opacity"; duration: splashTimer.interval }
            PropertyAnimation { target: rotator; property: "opacity"; duration: splashTimer.interval }
            PropertyAnimation { target: clock; property: "opacity"; duration: splashTimer.interval }
        }
    ]

    Timer {
        id: splashTimer
        interval: 1500
        repeat: false
        running: true
    }

    Timer {
        id: longPressedTimer
        interval: 500
        repeat: false
        running: false
    }

    property int maxSize: Math.min(root.height, root.width)
    property int innerSize: maxSize * 0.6

    Rectangle {
        anchors.centerIn: parent
        height: maxSize - maxSize / 10
        width: height
        color: "black"
        radius: height / 2
    }

    Rectangle {
        anchors.centerIn: parent
        height: innerSize
        width: innerSize
        color: "#4DC6A9"
        radius: height / 2
    }


    Rectangle {
        id: rotator
        height: innerSize - innerSize / 10
        width: height
        radius: height / 2
        anchors.centerIn: parent
        rotation: root.currentItem * -90
        Behavior on rotation {
            RotationAnimation {
                direction: RotationAnimation.Shortest
            }
        }
        color: "#cbdccc"
        border.width: 0
        border.color: "white"
        opacity: 0

        Repeater {
            id: repeater
            model: 4

            delegate: Item {
                id: imageItem
                anchors.fill: parent
                rotation: index * 90
                z: index == root.currentItem ? 1 : 0

                property int value: 50
                onValueChanged: {
                    print("value changed", value)
                    root.sleeping = false;
                    sleepTimer.restart();
                }

                // This should be the image
                Rectangle {
                    id: image
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width
                    radius: width/2
                    color: "#DBE6DE"
                    Image {
                        id: realImage
                        anchors.centerIn: parent
                        height: parent.height * 0.4
                        width: height
                        sourceSize.width: width
                        sourceSize.height: height
                        source: {
                            switch(index) {
                            case 0:
                                return "qrc:///images/couch.svg";
                            case 1:
                                return "qrc:///images/work.svg";
                            case 2:
                                return "qrc:///images/light.svg";
                            case 3:
                                return "qrc:///images/radiator.svg";
                            }
                        }
                    }

                    rotation: index * -90 + root.currentItem * 90
                    Behavior on rotation {
                        RotationAnimation {
                            direction: RotationAnimation.Shortest
                        }
                    }
                    Behavior on scale {
                        NumberAnimation {}
                    }
                    Behavior on opacity {
                        NumberAnimation {}
                    }

                    ValueCircle {
                        id: valueCircle
                        height: parent.height
                        width: height
                        anchors.centerIn: parent
                        value: imageItem.value
                        visible: index == 0 || index == 1
                        opacity: root.selectionMode ? 0 : 1
                        Behavior on opacity {
                            NumberAnimation {}
                        }
                    }

                    Image {
                        source: onOffStates[index] ? "qrc:///images/on-area.svg" : "qrc:///images/off-area.svg"
                        height: parent.height * 0.95
                        width: parent.width * 0.95
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: parent.height * 0.025
                        }
                        visible: index !== 3
                        opacity: root.selectionMode ? 0 : 1
                        Behavior on opacity {
                            NumberAnimation {}
                        }
                    }

                    Text {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: parent.height * 0.075
                        }
                        text: onOffStates[index] == true ? "ON" : "OFF"
                        font.pixelSize: parent.height / 15

                        visible: index !== 3
                        opacity: root.selectionMode ? 0 : 1
                        Behavior on opacity {
                            NumberAnimation {}
                        }
                    }

                    Item {
                        anchors.fill: parent
                        visible: index == 3

                        Radiator {
                            anchors.fill: parent
                            // value : 100 = x : max
                            currentValue: targetValue
                            Behavior on currentValue {
                                NumberAnimation { duration: 1000 * 60 * 5 }
                            }

                            targetValue: imageItem.value * (maxValue - minValue) / 100 + minValue
                        }
                    }
                }

                property int distanceFromCenter: height / 3.5

                states: [
                    State {
                        name: "shown"; when: index == root.currentItem && !root.selectionMode
                        PropertyChanges { target: imageItem }
                    },
                    State {
                        name: "hidden"; when: !root.selectionMode && index != root.currentItem
                        PropertyChanges { target: imageItem; opacity: 0 }
                    },
                    State {
                        name: "rotating"; when: root.selectionMode
                        PropertyChanges {
                            target: image;
                            scale: index == root.currentItem ? 0.4 : 0.3;
                            anchors.verticalCenterOffset: -distanceFromCenter
                            opacity: index == root.currentItem ? 1 : 0.8
                        }
                    }
                ]

                transitions: [
                    Transition {
                        PropertyAnimation { target: imageItem; properties: "opacity,scale,anchors.verticalCenterOffset,anchors.horizontalCenterOffset" }
                        PropertyAnimation { target: image; properties: "opacity,scale,anchors.verticalCenterOffset,anchors.horizontalCenterOffset" }
                    }
                ]
            }
        }
    }

    Rectangle {
        height: maxSize
        width: maxSize
        anchors.centerIn: parent
        opacity: clock.opacity
        color: "black"
    }

    Text {
        id: clock
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                var now = new Date()
                clock.text = Qt.formatTime(now, "hh:mm")
            }
        }
        anchors.centerIn: parent
        color: "white"
        opacity: 0
        font.pixelSize: root.height / 6
        font.family: "Ubuntu"
        font.weight: Font.Light
    }

    Image {
        id: splashImage
        width: innerSize
        height: innerSize
        anchors.centerIn: parent
        source: "qrc:///images/logo.svg"
        opacity: 0
    }

    Image {
        height: maxSize
        width: maxSize
        anchors.centerIn: parent
        source: "qrc:///images/front.png"
    }

    DebugUi {
    }

    Notification {
        id: notification
    }
}
