

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
import QtQml 2.0


/*
import UIControls 1.0
import QtQuick.Controls 1
import QtQuick.Controls.Styles 1.4
*/
Item {}
/*
Calendar {
    id: docroot
    property bool noframe: true
    opacity: enabled ? 1 : .2
    x: 10
    y: 10
    frameVisible: false
    style: CalendarStyle {
        gridVisible: true
        gridColor: Colors.greyBlue
        background: Rectangle {

            implicitWidth: 250
            implicitHeight: 250
            color: noframe ? "transparent" : Colors.white
            opacity: .2

            Rectangle {
                color: "transparent"
                visible: !docroot.noframe
                anchors.fill: parent
                anchors.margins: -1
                border.color: Colors.white
                border.width: 1
            }
        }

        dayDelegate: Rectangle {
            property bool valid: styleData.valid
            color: noframe ? "transparent" : Colors.darkBlue

            Rectangle {
                anchors.fill: parent
                opacity: styleData.selected ? .03 : .05
                visible: styleData.hovered || styleData.selected
            }

            TextLabel {
                text: styleData.date.getDate()
                anchors.centerIn: parent
                opacity: styleData.visibleMonth && styleData.valid ? 1 : .3
                color: styleData.selected ? Colors.highlightBlue : Colors.white
                font.styleName: "Regular"
            }
        }

        navigationBar: Rectangle {
            color: noframe ? "transparent" : Colors.greyBlue
            height: 30

            TextLabel {
                anchors.centerIn: parent
                text: styleData.title
                fontSize: 16
            }

            Icon {
                anchors.verticalCenter: parent.verticalCenter
                icon: Icons.rightAngle
                anchors.right: parent.right
                iconColor: Colors.white
                anchors.margins: 10
                MouseArea {
                    anchors.fill: parent
                    onClicked: docroot.showNextMonth()
                }
            }

            Icon {
                anchors.verticalCenter: parent.verticalCenter
                icon: Icons.leftAngle
                anchors.left: parent.left
                iconColor: Colors.white
                anchors.margins: 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: docroot.showPreviousMonth()
                }
            }
        }

        dayOfWeekDelegate: Rectangle {
            height: 40
            color: noframe ? "transparent" : Colors.darkBlue

            TextLabel {
                anchors.centerIn: parent
                text: Qt.locale().dayName(styleData.dayOfWeek,
                                          Locale.ShortFormat)

                font.styleName: "Bold"
            }
        }
    }
}
*/
