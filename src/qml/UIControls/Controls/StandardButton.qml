

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

Rectangle {
    id: docroot

    signal clicked
    property bool checkable: false
    property string toolTipText
    property bool loading: false
    property int iconAlignment: Qt.AlignLeft
    property string icon: ""
    property alias text: text.text
    property alias fontColor: text.color
    property bool transparent: false
    property bool hasBorder: false
    property int fontSize: Fonts.controlFontSize
    property color iconColor: Colors.white
    property bool checked: false

    width: layout.width + 20 < 35 ? 35 : layout.width + 20
    height: 35
    color: transparent ? "transparent" : Colors.brighterDarkBlue_controls
    radius: 2

    border.color: Colors.white_op40
    border.width: hasBorder ? 1 : 0
    Row {
        id: layout
        height: parent.height
        anchors.centerIn: parent
        spacing: 10
        opacity: .75

        Icon {
            id: icon
            iconColor: docroot.iconColor
            anchors.verticalCenter: parent.verticalCenter
            width: 16
            height: 16
            icon: docroot.icon
            visible: docroot.icon !== "" && iconAlignment == Qt.AlignLeft
            iconSize: docroot.fontSize
        }

        TextLabel {
            id: text
            color: Colors.white
            text: docroot.text
            font.pixelSize: docroot.fontSize
            anchors.verticalCenter: parent.verticalCenter
            font.family: Fonts.simplonNorm_Medium
        }

        Icon {
            id: iconR
            iconColor: docroot.iconColor
            icon: docroot.icon
            anchors.verticalCenter: parent.verticalCenter
            width: 16
            height: 16
            visible: docroot.icon !== "" && iconAlignment == Qt.AlignRight
            iconSize: docroot.fontSize
        }
    }

    Loader {
        id: loader
        active: docroot.loading
        anchors.fill: parent
        sourceComponent: Rectangle {
            id: loadingIndicator
            visible: false
            opacity: 0
            color: docroot.color

            LoadingIndicator {
                baseSize: 8
                baseColor: Colors.white_op50
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: docroot.clicked()
        hoverEnabled: true
    }

    Loader {
        active: docroot.toolTipText !== ""
        sourceComponent: TooltipFlyout {
            id: toolTip
            text: docroot.toolTipText
            isHovered: mouseArea.containsMouse
        }
    }

    states: [
        State {
            name: "loading"
            when: docroot.loading

            PropertyChanges {
                target: loader.item
                opacity: 1
                visible: true
            }

            PropertyChanges {
                target: mouseArea
                enabled: false
            }
        },

        State {
            name: "disabled"
            when: !docroot.enabled
            PropertyChanges {
                target: docroot
                opacity: .3
            }
        },
        State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                target: docroot
                color: docroot.transparent ? "transparent" : Colors.darkBlue
            }
            PropertyChanges {
                target: layout
                opacity: 1
            }
        },
        State {
            name: "hover"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: layout
                opacity: 1
            }
        },
        State {
            name: "checked"
            when: docroot.checkable && docroot.checked
            PropertyChanges {
                target: layout
                opacity: 1
            }
        }
    ]

    transitions: [

        Transition {
            to: "loading"
            reversible: true
            PropertyAction {
                property: "active"
                target: loader
            }

            PropertyAction {
                property: "visible"
                target: loader.item
            }
            SequentialAnimation {
                NumberAnimation {
                    property: "opacity"
                    target: loader.item
                }
            }
        },

        Transition {
            from: "pressed"
            to: "hover"

            NumberAnimation {
                property: "opacity"
            }

            ColorAnimation {
                target: docroot
                duration: 200
            }
        },

        Transition {
            from: "hover"
            to: ""

            NumberAnimation {
                property: "opacity"
            }

            ColorAnimation {
                target: docroot
                duration: 200
            }
        }
    ]
}
