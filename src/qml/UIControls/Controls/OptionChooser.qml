

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
import "../Helper"

FlyoutBox {
    id: docroot
    property var options
    property string label
    property alias selectedIndex: chooser.selectedIndex
    property alias chooserWidth: chooser.width
    signal indexClicked(int index)

    width: column.width + 4
    fillColor: docroot.label != "" ? Colors.greyBlue : Qt.darker(
                                         Colors.darkBlue, 1.2)
    height: column.height + 10

    Rectangle {
        width: docroot.width - 4
        height: column.height
        color: Qt.darker(Colors.darkBlue, 1.2)

        Column {
            id: column
            spacing: 0
            y: -8

            Rectangle {
                width: parent.width
                height: 26
                color: Colors.greyBlue
                visible: docroot.label !== ""

                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    x: 10
                    text: docroot.label
                }

                Rectangle {
                    height: 1
                    anchors.bottom: parent.bottom
                    width: parent.width
                    color: Colors.greyBlue
                }
            }

            DropDownChooser {
                id: chooser
                padding: 10
                model: docroot.options
                width: 200
                height: contentHeight - 8
            }
        }
    }
}
