

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
import ControlLibrary 1.0

Item {
    id: docroot

    height: 52
    width: 200

    property bool enabled

    property string text: "Hallo"
    signal clicked

    Rectangle {
        id: background
        anchors.fill: parent
        color: Colors.es_blue
    }

    TextLabel {
        anchors.centerIn: parent
        color: Colors.es_white
        text: docroot.text.toUpperCase()
        fontSize: 20
    }

    MouseArea {
        id: mouseArea
        enabled: docroot.enabled
        anchors.fill: parent
        onClicked: docroot.clicked()
    }

    states: [
        State {
            name: "disabled"
            when: !docroot.enabled
            PropertyChanges {
                target: background
                opacity: 0.5
            }
        },
        State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                target: background
                color: "black"
            }
        }
    ]

    transitions: [
        Transition {
            from: "pressed"
            NumberAnimation {
                property: "opacity"
                target: background
            }
        }
    ]
}
