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
import QtQuick.Controls 2.0

AbstractButton
{
    id: docroot

    opacity: 1
    checkable: true
    property string bubbleText
    property bool selected

    height: parent.height
    width:  row.width + 26

    Rectangle
    {
        id: background
        anchors.fill: parent
        color: "transparent"
    }

    Row
    {
        id: row
        spacing: 10
        anchors.centerIn: parent

        TextLabel
        {
            id: text
            text: docroot.text
            color: Colors.white_op50
            anchors.verticalCenter: parent.verticalCenter
            fontSize: Fonts.subHeaderFontSize
        }

        CounterBubble
        {
            id: bubble
            visible: docroot.bubbleText != ""
            text: docroot.bubbleText
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1//.5
        }
    }

    Shadow
    {
        id: shadow
        shadowBottom: false
        visible: false
    }
    states:
    [
        State
        {
            name: "selected"
            when: docroot.checked

            PropertyChanges
            {
                target: background
                color: Colors.darkBlue
            }

            PropertyChanges
            {
                target: docroot
                opacity:1
                height: docroot.height
            }

            PropertyChanges
            {
                target: text
                color: Colors.white
            }

            PropertyChanges
            {
                target: bubble
                opacity: 1
            }

            PropertyChanges
            {
                target: shadow
                visible: true
            }
        }
    ]
}
