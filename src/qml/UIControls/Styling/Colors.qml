
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
pragma Singleton

import QtQuick 2.5

Item {
    readonly property color greyBlue: "#485058"
    readonly property color darkBlue: "#182129"
    readonly property color backgroundDarkBlue: "#202428"
    readonly property color warnRed: "#e6605e"
    readonly property color deleteRed: "#c4381f"
    readonly property color black: "#000"
    readonly property color okGreen: "#3bad03"
    readonly property color white: "#ffffff"
    readonly property color highlightBlue: "#00cdff"
    readonly property color grey: "#d8dbdf"
    readonly property color warnYellow: "yellow"
    readonly property color okayGreen: "#43d476"

    readonly property color lightGrey: transparentColor(grey, 50)

    readonly property color brighterDarkBlue: "#35393f"
    readonly property color brighterDarkBlue_controls: "#414851"

    readonly property color grey_op75: transparentColor(grey, 75)
    readonly property color white_op50: transparentColor(white, 50)
    readonly property color white_op30: transparentColor(white, 30)
    readonly property color white_op40: transparentColor(white, 40)
    readonly property color white_op75: transparentColor(white, 75)
    readonly property color white_op5: transparentColor(white, 7)
    readonly property color white_op10: transparentColor(white, 10)
    readonly property color black_op10: "#0f000000"
    readonly property color black_op25: transparentColor("#000000", 25)
    readonly property color black_op50: transparentColor("#000000", 50)
    readonly property color black_op80: transparentColor("#000000", 80)

    readonly property color red: "#ff6b64"

    function transparentColor(color, opacity) {
        var number = Math.round((opacity / 100) * 255)
        number = number.toString(16)
        var result = "#" + number + color.toString(16).slice(1)

        return result
    }
}
