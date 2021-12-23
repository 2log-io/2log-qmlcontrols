

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
import QtQuick.Controls 2.0
import UIControls 1.0

AbstractButton {

    id: docroot

    property alias size: docroot.height
    property int margin: 2
    height: 40
    width: height * 2
    checkable: true
    opacity: enabled ? 1 : 0.5
    property string onIcon: Icons.power
    property string offIcon: Icons.power
    property color offColor: Colors.lightGrey
    property color onColor: Colors.highlightBlue
    Rectangle {
        id: background
        anchors.fill: parent
        radius: 20
        color: Colors.black_op25

        Rectangle {
            id: handle
            width: docroot.size - 2 * docroot.margin
            height: width
            color: Colors.greyBlue
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: undefined
            anchors.margins: docroot.margin
            radius: width / 2

            Icon {
                id: icon
                anchors.centerIn: parent
                icon: docroot.offIcon
                iconColor: docroot.offColor
                iconSize: 16
            }
        }
    }

    Item {
        states: [
            State {
                when: docroot.checked
                name: "checked"
                AnchorChanges {
                    target: handle
                    anchors.left: undefined
                    anchors.right: background.right
                }

                PropertyChanges {
                    target: icon
                    iconColor: docroot.onColor
                    icon: docroot.onIcon
                }
            }
        ]

        transitions: [
            Transition {
                AnchorAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }

                ColorAnimation {
                    target: icon
                    duration: 100
                }
            }
        ]
    }
}
