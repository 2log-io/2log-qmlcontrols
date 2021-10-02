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


import QtQuick 2.12
import UIControls 1.0


Item
{
    id: docroot

    height: 40
    width: 200
    clip: true

    property bool hideLine: false
    property alias nextOnTab: input.nextTab
    property alias field: input
    property string placeholderText: ""
    property alias text: input.text
    property string currentText: input.displayText
    property alias icon: icon.icon
    property alias fontSize: input.font.pixelSize
    property alias inputMethodHints: input.inputMethodHints
    property alias validator: input.validator
    property bool acceptableInput: input.acceptableInput && !(mandatory && text == "")
    property color stateColor: lineOnHover ? "transparent": Colors.lightGrey
    property bool mandatory: false
    property bool lineOnHover: false
    property bool centerPlaceholder: false
    property alias placeholderLabel: placeholderLabel

    function showErrorAnimation()
    {
        errorAnimation.start();
    }
    signal accepted()

    function forceActiveFocus()
    {
        field.forceActiveFocus()
    }
    function check()
    {
        if(!docroot.acceptableInput)
        {
            line.color = Colors.grey
            errorAnimation.start()
        }
        return docroot.acceptableInput
    }

    SequentialAnimation
    {
        id: errorAnimation
        ColorAnimation {target: line; property:"color"; from: Colors.lightGrey; to: Colors.warnRed; duration: 50}
        PauseAnimation {duration: 200}
        ColorAnimation {target: line; property:"color"; to: Colors.lightGrey; from: Colors.warnRed; duration: 50}
        PauseAnimation {duration: 100}
        ColorAnimation {target: line; property:"color"; from: Colors.lightGrey; to: Colors.warnRed; duration: 50}
        PauseAnimation {duration: 200}
        ColorAnimation {target: line; property:"color"; to: Colors.lightGrey; from: Colors.warnRed; duration: 50}
        onRunningChanged: if(!running) line.color = Qt.binding(function(){return docroot.stateColor})
    }


    MouseArea
    {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        onClicked:  input.forceActiveFocus()
    }

    Item
    {
        height: 35
        width: parent.width

        Icon
        {
            id: icon
            height: iconSize
            width: iconSize
            iconColor: Colors.lightGrey
            anchors.verticalCenter: parent.verticalCenter
            anchors.bottomMargin: 10
            iconSize: input.font.pixelSize
        }

        TextInput
        {
            id: input
            property Item nextTab
            KeyNavigation.tab: nextTab
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin:  icon.icon !== "" ? font.pixelSize + 8 : 0
            font.pixelSize: Fonts.controlFontSize
            anchors.rightMargin: 1
            font.family: Fonts.simplonNorm_Medium
            onAccepted: docroot.accepted()
            color: Colors.white
            inputMethodHints: Qt.ImhNoPredictiveText
            selectionColor: Colors.highlightBlue
            selectedTextColor: Colors.darkBlue
            selectByMouse: true
            verticalAlignment: Text.AlignVCenter
            height: 35
            clip: true

            TextLabel
            {
                id: placeholderLabel
                visible: input.displayText == ""
                verticalAlignment: Text.AlignVCenter
                anchors.fill: input
                text: docroot.placeholderText + (docroot.mandatory ? "*" : "")
                font.pixelSize: parent.font.pixelSize
                font.family: Fonts.simplonNorm_Medium
                color: Colors.lightGrey
                horizontalAlignment: docroot.centerPlaceholder ? Qt.AlignHCenter : input.horizontalAlignment
            }
        }

        Rectangle
        {
            id: line
            height: 1
            width: parent.width
            anchors.bottom: input.bottom
            anchors.bottomMargin: 3
            color:  docroot.hideLine ? "transparent" : docroot.stateColor
        }

        states:
        [
            State
            {
                when: input.activeFocus
                name:"focus"
                PropertyChanges
                {
                    target: docroot
                    stateColor: Colors.highlightBlue
                }
            },
            State
            {
                when: !input.acceptableInput && !input.activeFocus && field.text != ""
                name:"error"
                PropertyChanges
                {
                    target: docroot
                    stateColor: Colors.warnRed
                }
            },

            State
            {
                when: mouseArea.containsMouse
                name:"hover"
                PropertyChanges
                {
                    target: docroot
                    stateColor: docroot.hideLine ? Colors.lightGrey :  Colors.white
                }
            },

            State
            {
                when: !docroot.enabled
                name:"disabled"

                PropertyChanges
                {
                    target: docroot
                    opacity: .3
                }
            }
        ]

        transitions:
        [
            Transition
            {
                from: "hover, focus"

                ColorAnimation
                {
                    id: transitionAnimation
                    target: docroot
                    property:"stateColor"
                }
            }
        ]
    }
}
