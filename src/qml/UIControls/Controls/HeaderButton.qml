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

    id: docroot

    property bool selected
    property alias text: text.text
    property alias icon: icon.icon

    height: parent.height
    width: layout.width + 40

    signal clicked()

    Rectangle
    {
        id: background
        opacity: .05
        anchors.fill: parent
        color:"transparent"
    }

    Row
    {

        id: layout
        opacity: .6
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        spacing: 20

        Icon
        {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            icon: Icons.user
            iconSize:  Fonts.smallControlFontSize
            width: 20
            height: 20
            iconColor:  Colors.grey
        }

        TextLabel
        {
            id: text
            color: Colors.grey
            fontSize: Fonts.subHeaderFontSize
            anchors.verticalCenter: parent.verticalCenter
            text: "Benutzer"
        }
    }

//    Rectangle
//    {
//        id: line
//        width: parent.width
//        anchors.top: parent.top
//        height: 2
//        visible: false

//    }

    states:
    [

        State
        {
            when: docroot.selected
            name:"checked"

            PropertyChanges
            {
                target: icon
                iconColor: Colors.highlightBlue
            }

            PropertyChanges
            {
                target: layout
                opacity: 1
            }

            PropertyChanges
            {
                target: text
                color: Colors.white
            }
            PropertyChanges
            {
                target: background
                color: Colors.black
                opacity: .1
            }

//            PropertyChanges
//            {
//                target: line
//                visible: true
//                opacity:.5
//            }

        },
        State
        {
            name:"hover"
            when: area.containsMouse

            PropertyChanges
            {
                target: background
                color: Colors.white
            }
        }
    ]

    transitions:
    [
        Transition
        {
            SequentialAnimation
            {
                PropertyAction
                {
                    target: background
                    property: "color"
                }
                ColorAnimation
                {
                    targets: [icon, text]
                }
            }
        }
    ]


    MouseArea
    {
        id: area
        anchors.fill: parent
        onClicked: docroot.clicked()
        hoverEnabled: true
    }
}
