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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import UIControls 1.0

AbstractButton
{
    id: docroot

    property string iconChar
    property color iconCheckedColor
    property color checkedBackgroundColor: Colors.darkBlue
    property color borderColor: Colors.greyBlue
    property color iconNormalColor: Colors.white
    property int alignment
    property double shadowOpacity: 0.5
    property bool borderVisible: true
    property string toolTipText
    checkable: false

    clip: true
    width: 30
    height: 25


    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
        {
            docroot.clicked()
            if(docroot.checkable)
            {
               // docroot.checked = !docroot.checked
            }
        }
    }

    Rectangle
    {
        id: background
        width: parent.width +4
        height: parent.height
        border.color: docroot.borderVisible ? docroot.borderColor : "transparent"
        color: "transparent"
        radius: 4
    }


    InnerShadow {
        id: shadow
        anchors.fill: background
        anchors.margins: 1
        radius: 8.0
        opacity: docroot.shadowOpacity
        samples: 16
        horizontalOffset: -3
        verticalOffset: 3
        color: "#b0000000"
        source: background
        visible: false
    }

    Rectangle
    {
        id: hoverLayer
        anchors.fill: background
        radius: background.radius
        opacity: .0
    }

    Rectangle
    {
        id: line
        visible: docroot.borderVisible
        width:1
        height: parent.height
        color: docroot.borderColor
    }

    Icon
    {
        id: icon
        anchors.centerIn: parent
        icon: docroot.iconChar
        iconColor: docroot.iconNormalColor
        iconSize: 12
        opacity: 0.4
    }

    Item
    {
        id: directionStates

        states:
        [
            State
            {
                name: "left"
                when: docroot.alignment == Qt.AlignLeft
                AnchorChanges
                {
                    target: line
                    anchors.right: parent.right
                }
            },
            State
            {
                name: "right"
                when: docroot.alignment == Qt.AlignRight
                AnchorChanges
                {
                    target: background
                    anchors.right: parent.right
                }
            },
            State
            {
                name: "center"
                when: docroot.alignment == Qt.AlignCenter

                PropertyChanges
                {
                    target: line
                    visible: false
                }

                PropertyChanges
                {
                    target: background
                    radius: 0
                }
            },
            State
            {
                name: "single"
                when: docroot.alignment < 0

                PropertyChanges
                {
                    target: line
                    visible: false
                }

                PropertyChanges
                {
                    target: background
                    width: docroot.width
                }
            }
        ]
    }




    TooltipFlyout
    {
        id: toolTip
        text: docroot.toolTipText
        isHovered: mouseArea.containsMouse
    }



    states:
    [
        State
        {
            name:"checked"
            when: docroot.checked
            PropertyChanges
            {
                target: hoverLayer
                opacity: 0
            }

            PropertyChanges
            {
                target: shadow
                visible: true
            }

            PropertyChanges
            {
                target: background
                color: docroot.checkedBackgroundColor
            }

            PropertyChanges
            {
                target: icon
                iconColor: docroot.iconCheckedColor
                opacity: 1
            }
        },
        State
        {
            name:"hover"
            when: mouseArea.containsMouse
            PropertyChanges
            {
                target: hoverLayer
                opacity: .05
            }

            PropertyChanges
            {
                target: icon
                opacity: .7
                iconColor: docroot.iconCheckedColor
            }
        }
    ]

}
