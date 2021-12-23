

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

Row {
    id: docroot
    spacing: baseSize / 2
    anchors.centerIn: parent
    property int baseSize: 20
    property color baseColor: Colors.greyBlue

    Rectangle {
        id: a
        width: baseSize
        height: baseSize
        radius: baseSize / 2
        color: baseColor
        opacity: .5
    }
    Rectangle {
        id: b
        width: baseSize
        height: baseSize
        radius: baseSize / 2
        color: baseColor
        opacity: .5
    }
    Rectangle {
        id: c
        width: baseSize
        height: baseSize
        radius: baseSize / 2
        color: baseColor
        opacity: .5
    }
    Rectangle {
        id: d
        width: baseSize
        height: baseSize
        radius: baseSize / 2
        color: baseColor
        opacity: .5
    }
    SequentialAnimation {
        running: docroot.visible
        loops: Animation.Infinite

        ParallelAnimation {
            NumberAnimation {
                target: a
                property: "opacity"
                to: 1
            }

            NumberAnimation {
                target: d
                property: "opacity"
                to: 0.5
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: a
                property: "opacity"
                to: .5
            }
            NumberAnimation {
                target: b
                property: "opacity"
                to: 1
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: b
                property: "opacity"
                to: .5
            }
            NumberAnimation {
                target: c
                property: "opacity"
                to: 1
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: c
                property: "opacity"
                to: .5
            }
            NumberAnimation {
                target: d
                property: "opacity"
                to: 1
            }
        }
    }
}
