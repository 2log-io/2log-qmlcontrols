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

Loader
{
    id: docroot

    property string helpText
    property int flyoutWidth
    property int triangleDelta:-1
    property var flyoutParent
    property int flyoutX: -1

    active: docroot.helpText !== ""

    sourceComponent:
    Item
    {
        Icon
        {
            id: toolTipIcon
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            icon: Icons.infoRound
            iconColor: Colors.white
            iconSize: 16
            opacity: .25

            states:
            [
                State
                {
                    name:"open"
                    when: toolTip.opened
                    PropertyChanges
                    {
                        target: toolTipIcon
                        opacity: 1
                    }
                },
                State
                {
                    name:"hover"
                    when: toolTipMouseArea.containsMouse
                    PropertyChanges
                    {
                        target: toolTipIcon
                        opacity: .5
                    }
                }
            ]

            transitions:
            [
                Transition {
                    from: "hover, open"
                    to: ""

                    NumberAnimation
                    {
                        property:"opacity"
                    }

                }
            ]
        }


        MouseArea
        {
            TooltipFlyout
            {
                id: toolTip
                closePolicy: Popup.CloseOnPressOutsideParent
                flyoutWidth: docroot.flyoutWidth
                parent: docroot.flyoutParent
                x: docroot.flyoutX < 0 ? - (toolTip.width-docroot.width)  / 2 : docroot.flyoutX
                triangleDelta: docroot.triangleDelta < 0 ? toolTip.width/2 -8 : docroot.triangleDelta
                text: docroot.helpText
                fontSize: Fonts.contentFontSize
                verticalOffset: 0
            }


            property bool checked: false
            id: toolTipMouseArea
            hoverEnabled: true
            onContainsMouseChanged:
            {
                if(containsMouse)
                    toolTip.open()
                else if(!toolTipMouseArea.checked)
                    toolTip.close()
            }

            anchors.fill: parent
            onClicked:
            {
                checked = !checked
                if(checked)
                 toolTip.open()
                else
                    toolTip.close()
            }
        }
    }
}
