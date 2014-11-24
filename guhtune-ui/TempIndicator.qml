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

Rectangle {
    id: root

    border.width: width / 10
    border.color: "black"
    color: "transparent"
    radius: width / 4

    property int minTemp: 0
    property int maxTemp: 50
    property int percentage: 50

    property real currentTemp: (minTemp +  1.0 * (maxTemp - minTemp) * percentage / 100)

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: root.height * (100 - root.percentage) / 100
        color: "black"
        radius: parent.radius
    }
}
