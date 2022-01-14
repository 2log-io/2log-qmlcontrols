

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
import QtQuick 2.7
import UIControls 1.0

Rectangle {
    id: docroot
    property real triangleSide
    property real triangleHeight: 8
    property real triangleDelta: 20
    property bool triangleVisible: true
    property color fillColor: "red"
    property color borderColor: fillColor
    property real borderWidth: 1
    property real shadowSizeVar: 4
    property alias shadowOpacity: shadow.opacity

    Shadow {
        id: shadow
        shadowSize: shadowSizeVar
    }

    FlyoutPainter {
        id: canvas
        width: parent.width + ((triangleSide == Qt.RightEdge
                                || triangleSide == Qt.LeftEdge) ? triangleHeight : 0)
        height: parent.height + ((triangleSide == Qt.TopEdge
                                  || triangleSide == Qt.BottomEdge) ? triangleHeight : 0)
        triangleDelta: docroot.triangleDelta
        triangleHeight: docroot.triangleHeight
        borderColor: docroot.borderColor
        borderWidth: docroot.borderWidth
        fillColor: docroot.fillColor
        triangleSide: docroot.triangleSide

        y: {
            if (triangleSide == Qt.TopEdge)
                return -triangleHeight
            return 0
        }

        x: {
            if (triangleSide == Qt.LeftEdge)
                return -triangleHeight
            return 0
        }
    }
}
