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

Item {
    id: root

    property int value: 10
    property bool on: true

    // value : 100 = x : 50

    Repeater {
        model: 50

        Item {
            height: root.height * 0.95
            width: height / 100
            anchors.centerIn: parent

            rotation: -79 + index * 3.2
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: width * 10
                radius: width / 2
                opacity: index <= root.value/2 ? 1 : 0.2
            }
        }
    }

    Text {
        font.pixelSize: root.height / 10
        color: "white"
        text: "-"
        anchors { left: parent.left; leftMargin: root.height / 20; verticalCenter: parent.verticalCenter; verticalCenterOffset: -root.height / 40 }
    }

    Text {
        font.pixelSize: root.height / 10
        color: "white"
        text: "+"
        anchors { right: parent.right; rightMargin: root.height / 40; verticalCenter: parent.verticalCenter; verticalCenterOffset: -root.height / 40 }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: root.height * 0.1
        }
        text: root.on ? "ON" : "OFF"
        font.pixelSize: root.height / 10
    }
}
