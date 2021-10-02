/*   2log.io
 *   Copyright (C) 2021 - 2log.io | mail@2log.io,  mail@friedemann-metzger.de
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


import QtQuick 2.5
import UIControls 1.0


Item
{
    property int size
    id: docroot

    width: size
    height: size
    property alias backgroundColor: background.color
    Rectangle
    {
        id: background
        radius: size/2
        anchors.fill: parent
        color: Colors.black
        opacity: .2
    }

    Image
    {
        id: spinner
        width: size-2
        height: size-2
        source:"qrc:/spinner_logo"
        anchors.centerIn: parent
        NumberAnimation
        {
            running: true
            target: spinner
            property: "rotation"
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 2000
        }
    }
}
