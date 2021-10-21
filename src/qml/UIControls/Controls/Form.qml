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
import UIControls 1.0
import QtQml.Models 2.11

Item
{
    id: docroot
    property variant items: objModel.children
    default property alias content: objModel.children
    height: objModel.count * 40
    property bool edited
    property bool finished: false



    ObjectModel
    {
        id: objModel
    }

    function checkDirty()
    {
        for(var i = 0; i < objModel.count; i++)
        {
            if(objModel.get(i).dirty)
            {
                docroot.edited = true;
                return
            }
        }
        docroot.edited = false;
    }

    function checkValid()
    {
        for(var i = 0; i < objModel.count; i++)
        {
            var item = controlRepeater.itemAt(i).item
            if(!item.check())
            {
                item.forceActiveFocus()
                return false;
            }
        }
        return true;
    }

    GridLayout
    {
        id: layout
        anchors.fill: parent
        columns: 2
        columnSpacing: 10
        rowSpacing:0

        Repeater
        {
            model :objModel.count
            TextLabel
            {
                id: textLabel
                text: objModel.get(index).label
                Layout.column: 0
                Layout.row: index
                color: Colors.grey
                fontSize: Fonts.controlFontSize
                opacity: .5
                Layout.alignment: Qt.AlignRight
            }
        }

        Repeater
        {
            id: controlRepeater
            model: objModel.count
            Component.onCompleted:
            {
                for(var i= 1; i < controlRepeater.count; i++)
                {
                    switch(objModel.get(i).type)
                    {
                        case 0: controlRepeater.itemAt(i-1).item.nextOnTab = controlRepeater.itemAt(i).item.field; break;
                        case 1: controlRepeater.itemAt(i-1).item.nextOnTab = controlRepeater.itemAt(i).item; break;
                        case 3: controlRepeater.itemAt(i-1).item.nextOnTab = controlRepeater.itemAt(i).item.field; break;
                    }

                }
            }
            delegate:
            Item
            {
                id: delegateItem
                property alias item: loader.item
                Layout.column: 1
                Layout.row: index
                Layout.fillWidth: true
                height: 40
                Loader
                {
                    id: loader
                    property int itemIndex: index

                    anchors.fill: parent
                    sourceComponent:  switch(objModel.get(index).type)
                    {
                        case 0: return textComp
                        case 1: return dropdown
                        case 2: return checkComp
                        case 3: return comboBox
                    }
                }
            }
        }
    }

    Component
    {
        id: textComp
        TextField
        {
            id: textField
            property int itemIndex: parent.itemIndex
            property FormTextItem item: objModel.get(itemIndex)
            width: parent.width
            anchors.verticalCenter:  parent.verticalCenter
            anchors.verticalCenterOffset:  2
            field.validator: item.validator !== undefined ? item.validator : null
            mandatory: item.mandatory
            text: item.text
            enabled: item.enabled
            field.horizontalAlignment: item.alignment
            Connections
            {
                target: item
                function onTextChanged()
                {
                    item.dirty = ( textField.text !== item.text )
                    checkDirty()
                }
            }
            onCurrentTextChanged:
            {
                item.dirty = ( textField.currentText != item.text )
                checkDirty()
                item.editedText = currentText
            }

            onAccepted: item.accepted()

        }
    }


    Component
    {
        id: checkComp
        Item
        {
            property FormCheckboxItem item: objModel.get(parent.itemIndex)

            function check()
            {
                return true;
            }

            CheckBox
            {
                id: checkBox
                checked: item.checked
                Component.onCompleted: item.dirty = false
                onCheckedChanged:
                {
                    item.dirty = (checkBox.checked !== item.checked)
                    checkDirty()
                    item.editedChecked = checkBox.checked
                }
                anchors.verticalCenter: parent.verticalCenter

                Connections
                {
                    target: item
                    onCheckedChanged:
                    {
                        item.dirty = (checkBox.checked !== item.checked)
                        checkDirty()
                    }
                }
            }
        }
    }
    Component
    {
        id: dropdown
        DropDown
        {
            id:dropDown
            property FormDropDownItem item: objModel.get(parent.itemIndex)
            width: parent.width
            anchors.verticalCenter:  parent.verticalCenter
            anchors.verticalCenterOffset:  2
            Layout.bottomMargin: -3
            selectedIndex: item.selectedIndex
            options: item.options
            enabled: item.enabled
            mandatory: item.mandatory
            placeholderText: item.placeholder
            Component.onCompleted: item.dirty = false
            Connections
            {
                target: item
                function onSelectedIndexChanged()
                {
                    item.dirty = ( selectedIndex !== item.selectedIndex )
                    checkDirty()
                }
            }

            onSelectedIndexChanged:
            {
                item.dirty = ( selectedIndex != item.selectedIndex )
                checkDirty()
                item.editedSelectedIndex = selectedIndex
            }
        }
    }

    Component
    {
        id: comboBox
        ComboBox
        {
            id:dropDown
            property FormComboItem item: objModel.get(parent.itemIndex)
            width: parent.width
            anchors.verticalCenter:  parent.verticalCenter
            anchors.verticalCenterOffset:  2
            Layout.bottomMargin: -3
            selectedIndex: item.selectedIndex
            options: item.options
            enabled: item.enabled
            mandatory: item.mandatory
            placeholderText: item.placeholder
            text: item.text
            onEditedTextChanged: item.inputText = editedText
            Component.onCompleted: item.dirty = false
            Connections
            {
                target: item
                onSelectedIndexChanged:
                {
                    item.dirty = ( selectedIndex !== item.selectedIndex )
                    checkDirty()
                }
            }

            Connections
            {
                target: item
                onTextChanged:
                {
                    item.dirty = ( text !== item.inputText )
                    checkDirty()
                }
            }
            onInputCompleted:
            {
                item.inputText = input
                item.finished()
            }

            onSelectedIndexChanged:
            {
                item.dirty = ( selectedIndex != item.selectedIndex )
                checkDirty()
                item.editedSelectedIndex = selectedIndex
            }
        }
    }
}
