

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
import CloudAccess 1.0
import QtQuick.Controls 2.5
import UIControls 1.0

Popup {
    id: addPopup
    width: flyoutLayout.width + 24
    height: flyoutLayout.height + 24
    default property alias content: row.children
    property alias triangleSide: helper.triangleSide
    property alias fillColor: helper.fillColor
    property alias borderColor: helper.borderColor
    property alias triangleDelta: helper.triangleDelta
    property alias triangleHeight: helper.triangleHeight
    property int verticalOffset: 4
    padding: 0
    x: parent.width / 2 - width / 2
    y: parent.height + helper.triangleHeight - 4

    property bool waiting: false
    contentItem: FlyoutHelper {
        id: helper
        triangleHeight: 12
        triangleDelta: width / 2 - triangleHeight
        triangleSide: Qt.TopEdge
        fillColor: Qt.darker(Colors.darkBlue, 1.2)
        borderColor: Colors.greyBlue
        borderWidth: 1
        shadowOpacity: 0.1
        shadowSizeVar: 8
        anchors.fill: parent

        Column {
            id: flyoutLayout
            anchors.centerIn: parent
            anchors.verticalCenterOffset: addPopup.verticalOffset
            spacing: 10

            Row {
                spacing: 10
                id: row
            }
        }
    }
}
