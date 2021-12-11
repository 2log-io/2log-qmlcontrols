

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
import QtQuick 2.14
import UIControls 1.0

ListView {

    property bool showScrollableIndication: false

    Rectangle {
        z: 10
        anchors.top: parent.top
        height: 20
        width: parent.width
        opacity: 1
        visible: parent.contentY > 0 && showScrollableIndication
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Colors.darkBlue
            }
            GradientStop {
                position: 1.0
                color: "transparent"
            }
        }
    }

    Rectangle {
        z: 10
        anchors.bottom: parent.bottom
        visible: showScrollableIndication
        height: 20
        width: parent.width
        opacity: 1
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: Colors.darkBlue
            }
            GradientStop {
                position: 0.0
                color: "transparent"
            }
        }
    }
}
