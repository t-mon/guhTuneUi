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

// Debug ui
Column {
    anchors { top: parent.top; left: parent.left }
    width: root.width / 10
    spacing: width / 10
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "press" }
        MouseArea {
            anchors.fill: parent
            onClicked: root.buttonPressed = true
        }
    }
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "release" }
        MouseArea {
            anchors.fill: parent
            onClicked: { root.buttonPressed = false; root.selectionMode = false }
        }
    }
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "click (press & release)" }
        MouseArea {
            anchors.fill: parent
            onClicked: { root.buttonPressed = true; root.buttonPressed = false }
        }
    }
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "rotate left" }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.selectionMode) {
                    root.currentItem = (root.currentItem + 1) % 4;
                } else {
                    repeater.itemAt(root.currentItem).value++;
                }
            }
        }
    }
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "rotate right" }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.selectionMode) {
                    if (root.currentItem == 0) {
                        root.currentItem = 3;
                    } else {
                        root.currentItem--;
                    }
                } else {
                    repeater.itemAt(root.currentItem).value--;
                }
            }
        }
    }
    Rectangle { width: parent.width; height: width / 4; color: "white"
        Text{ anchors.centerIn: parent; text: "wakeup" }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.sleeping = false;
                sleepTimer.restart();
            }
        }
    }
}
