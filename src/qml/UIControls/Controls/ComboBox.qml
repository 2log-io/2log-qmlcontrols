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


import QtQuick 2.13
import UIControls 1.0
import QtQuick.Controls 2.0
import "../Helper"

Item
{
    id: docroot

    height: 40
    width: 200
    clip: true

    property bool hideLine: false
    property Item nextOnTab
    property alias field: input
    property string placeholderText: ""
    property string text
    onTextChanged: input.text = text
    property alias icon: icon.icon
    property int iconSpacing: 6
    property alias fontSize: input.font.pixelSize
    property var options:[]
    property bool mandatory
    property bool acceptableInput: !(mandatory && selectedIndex < 0)
    property alias selectedIndex: optionsView.selectedIndex
    property color stateColor: lineOnHover ? "transparent" : Colors.lightGrey
    property bool lineOnHover: false
    property bool containsMouse: mouseArea.containsMouse
    property bool open: popup.visible
    property string editedText

    signal inputCompleted(string input)
    onActiveFocusChanged: if(activeFocus) input.forceActiveFocus()
    signal indexClicked(int index)
    signal accepted()

    function reset()
    {
        optionsView.model = docroot.options
        docroot.editedText = ""
        input.text = ""
        docroot.text = ""
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

    KeyNavigation.tab: docroot.nextOnTab
    Keys.onPressed:
    {
        var index = docroot.selectedIndex
        switch(event.key)
        {
            case Qt.Key_Return:
                if(dummy.activeFocus)
                {
                    docroot.inputCompleted(optionsView.model[docroot.selectedIndex])
                    input.text = optionsView.model[docroot.selectedIndex]
                }
                popup.close()
                dummy.forceActiveFocus()
                return;

            case Qt.Key_Tab:
                popup.close()
                event.accepted = false
                return

            case Qt.Key_Backtab:
                popup.close()
                event.accepted = false
                return
            case Qt.Key_Up:
                index--
                break;
            case Qt.Key_Down:
            {
                index++
                if(optionsView.model.length === 0)
                    optionsView.model = docroot.options
                popup.open()
            }
        }


        if(index === optionsView.model.length)
        {
            docroot.selectedIndex = -1
            input.forceActiveFocus()
        }
        else if(index === -1)
        {
            docroot.selectedIndex = index
            input.forceActiveFocus()
        }
        else if(index === -2)
        {
            docroot.selectedIndex = optionsView.model.length-1
            dummy.forceActiveFocus()
        }
        else
        {
            docroot.selectedIndex = index
            dummy.forceActiveFocus()
        }

    }

    TextInput{id: dummy; visible: false}

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
        onClicked:
        {
            if(!popup.opened)
                 optionsView.model = docroot.options
            popup.open()
            docroot.forceActiveFocus()

        }
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
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.leftMargin:  icon.icon !== "" ? font.pixelSize + docroot.iconSpacing : 0
            font.pixelSize: Fonts.controlFontSize
            font.family: Fonts.simplonNorm_Medium
            color: Colors.white

            onAccepted: docroot.inputCompleted(text)
            onActiveFocusChanged: if(activeFocus) {popup.open(); docroot.selectedIndex = -1}
            onTextEdited: popup.sort();
            onTextChanged:{ docroot.editedText = text; }

            TextLabel
            {
                visible: input.text === ""
                anchors.fill: input
                text: docroot.placeholderText
                font.pixelSize: parent.font.pixelSize
                font.family: Fonts.simplonNorm_Medium
                color: Colors.lightGrey
            }
        }

        Rectangle
        {
            id: line
            height: 1
            width: parent.width
            anchors.bottom: input.bottom
            anchors.bottomMargin: -5
            color: docroot.hideLine ? "transparent" : docroot.stateColor
        }

        Icon
        {
            id: arrowIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            icon: Icons.downArrow
            iconColor: Colors.lightGrey
            iconSize: Fonts.controlFontSize
            visible: !docroot.lineOnHover
        }

        states:
        [
            State
            {
                when:!docroot.enabled
                name:"disabled"

                PropertyChanges
                {

                    target: docroot
                    opacity: .3
                }
            },
            State
            {
                when: input.activeFocus
                name:"textselected"
                PropertyChanges
                {
                    target: docroot
                    stateColor: Colors.highlightBlue
                    opacity: 1
                }
                PropertyChanges
                {
                    target: arrowIcon
                    iconColor: Colors.white
                    visible: true
                }
            },
            State
            {
                when: popup.opened
                name:"focus"
                PropertyChanges
                {
                    target: docroot
                    stateColor: Colors.white
                }

                PropertyChanges
                {
                    target: arrowIcon
                    iconColor: Colors.white
                    visible: true
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

                PropertyChanges
                {
                    target: arrowIcon
                    iconColor:   Colors.white
                    visible: true
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
                    targets:[ docroot, arrowIcon]
                }
            }
        ]
    }

    Popup
    {
        id: popup
        padding: 0
        width: parent.width
        background: Item{}
        height: optionsView.contentHeight + 0
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        y: line.y + 1

        Rectangle
        {
            anchors.fill: parent
            color: Colors.darkBlue
            Rectangle
            {
                anchors.fill:  parent
                color:"black"
                opacity: .1
            }

            Shadow
            {
                shadowSize: 4
                opacity: 0.2
                shadowTop: false
            }
        }

        function sort()
        {
            var sorted = []
            docroot.options.forEach(function f(item,index)
                                    {
                                        if(item.toLowerCase().startsWith(input.text.toLowerCase()))
                                            sorted.push(item)
                                    })

            optionsView.model = sorted
        }

        DropDownChooser
        {
            id: optionsView
            anchors.fill: parent
            model: docroot.options
            fontSize:  input.font.pixelSize
            onClicked:
            {
                popup.close()
                dummy.forceActiveFocus()
                docroot.indexClicked(index)
                docroot.inputCompleted(text)
                input.text = text
            }
        }
    }
}
