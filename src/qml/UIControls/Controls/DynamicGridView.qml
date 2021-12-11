

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

GridView {
    id: layout

    property int maxCellWidth: 160

    moveDisplaced: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    move: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    removeDisplaced: Transition {
        SequentialAnimation {

            PauseAnimation {
                duration: 100
            }
            NumberAnimation {
                properties: "x,y"
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    remove: Transition {
        SequentialAnimation {

            NumberAnimation {
                properties: "opacity"
                duration: 100
                to: 0
            }
        }
    }

    height: {
        var columnCount = Math.floor(width / cellWidth)
        var rowCount = Math.floor(count / columnCount)
        if (count % columnCount != 0)
            rowCount++

        return cellHeight * rowCount
    }

    cellWidth: {
        var count = width / maxCellWidth
        var cellwidth = width / Math.round(count)
        return cellwidth
    }
}
