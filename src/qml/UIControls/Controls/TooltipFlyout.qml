

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
import QtQuick.Layouts 1.3
import QtQuick 2.5
import QtQuick.Controls 2.5
import UIControls 1.0

Popup {
    id: docroot
    property string text
    width: Math.round(text.width + 10)
    height: Math.round(text.height + 10)
    property int flyoutWidth
    onFlyoutWidthChanged: text.width = flyoutWidth
    property alias fillColor: helper.fillColor
    property int verticalOffset: 4
    padding: 0
    x: Math.round(parent.width / 2 - width / 2)
    y: Math.round(parent.height + helper.triangleHeight - verticalOffset)
    property int fontSize: Fonts.verySmallControlFontSize
    property alias triangleDelta: helper.triangleDelta
    property bool waiting: false
    property bool isHovered
    property int delay: 1000

    Overlay.modal: Rectangle {
        color: Colors.black_op25
    }

    onIsHoveredChanged: {
        if (isHovered) {
            toolTipTimer.start()
        } else {
            docroot.close()
            toolTipTimer.stop()
        }
    }

    Timer {
        id: toolTipTimer
        interval: docroot.delay
        onTriggered: docroot.open()
    }

    contentItem: FlyoutHelper {
        id: helper
        triangleHeight: 8
        triangleDelta: width / 2 - triangleHeight
        triangleSide: Qt.TopEdge
        fillColor: Qt.darker(Colors.darkBlue, 1.8)
        borderColor: fillColor
        borderWidth: 1
        shadowOpacity: 0.1
        shadowSizeVar: 8
        anchors.fill: parent

        TextLabel {
            id: text
            fontSize: docroot.fontSize
            anchors.centerIn: parent
            elide: Text.ElideNone
            text: docroot.text
            wrapMode: Text.Wrap
        }
    }
}
