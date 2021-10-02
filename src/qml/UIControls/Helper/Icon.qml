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

Rectangle
{
    id: docroot

    property string     icon
    property color      iconColor:  Colors.highlightBlue
    property int        iconSize:   20
    property string     iconFont:   Fonts.iconFont
    property string     iconUrl
    property alias      image:      image

    width:  iconSize
    height: iconSize
    color: "transparent"

    TextLabel
    {
        visible: !docroot.iconUrl
        font.family: iconFont
        font.weight: Font.Normal
        font.pixelSize: docroot.iconSize
        id: name
        color: docroot.iconColor
        anchors.centerIn:  parent
        text: docroot.icon

        anchors.verticalCenterOffset:
        switch (Qt.platform.os)
        {
            case "windows": return -2
            default: return 0
        }
    }

    Image
    {
        id: image
        visible:  iconUrl
        anchors.centerIn: docroot
        source: docroot.iconUrl
    }
}
