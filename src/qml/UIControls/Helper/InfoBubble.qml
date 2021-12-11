

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

Rectangle {
    id: docroot
    property int size: 22
    property int state: 1
    property color infoColor: Colors.white
    property string icon
    property string image
    property alias iconSize: icon.iconSize

    height: size
    width: size
    radius: size / 2
    border.width: 1
    border.color: infoColor
    color: Colors.darkBlue

    Icon {
        id: icon
        iconColor: infoColor
        anchors.centerIn: parent
        icon: docroot.icon
        iconSize: Fonts.verySmallControlFontSize
    }

    states: [
        State {
            name: "ok"
            when: docroot.state == 1
            PropertyChanges {
                target: docroot
                icon: Icons.check
                infoColor: Colors.highlightBlue
            }
        },
        State {
            name: "info"
        },
        State {
            name: "warning"
        },
        State {
            name: "error"
        }
    ]
}
