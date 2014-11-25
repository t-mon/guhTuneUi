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

    // value : 100 = x : 40

    Repeater {
        model: 40

        Item {
            height: root.height * 0.95
            width: height / 100
            anchors.centerIn: parent

            rotation: -59 + index * 3
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: width * 10
                radius: width / 2
                opacity: index <= root.value * 40 / 100 ? 1 : 0.2
            }
        }
    }

    Text {
        font.pixelSize: root.height / 10
        color: "white"
        text: "-"
        anchors { left: parent.left; leftMargin: root.height / 15; verticalCenter: parent.verticalCenter; verticalCenterOffset: -root.height / 7 }
    }

    Text {
        font.pixelSize: root.height / 10
        color: "white"
        text: "+"
        anchors { right: parent.right; rightMargin: root.height / 15; verticalCenter: parent.verticalCenter; verticalCenterOffset: -root.height / 7 }
    }
}
