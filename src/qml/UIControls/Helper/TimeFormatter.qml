

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

Item {
    id: docroot
    property string timeString
    property string time
    width: row.width
    height: row.height
    onTimeChanged: setTime()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: setTime()
    }

    function parseISOLocal(s) {
        var b = s.split(/\D/)
        return new Date(b[0], b[1] - 1, b[2], b[3], b[4], b[5])
    }

    function setTime() {
        reset()
        var now = new Date()
        var was = parseISOLocal(docroot.time)
        var delta = now.getTime() - was.getTime()

        if (delta < 60 * 1000) {
            labelD.text = "gerade eben" //"vor "+Math.round(delta/1000)+" sek";
            return
        }

        if (delta < 60 * 60 * 1000) {
            labelC.text = "VOR"
            labelD.text = Math.round(delta / 60 / 1000) + "m"
            return
        }

        if (delta < 3 * 60 * 60 * 1000) {
            labelC.text = "VOR"
            var hrs = parseInt(delta / 3600000)
            var min = Math.round((delta % (hrs * 3600000)) / 60000)
            labelD.text = hrs + "h " + min + "m"
            return
        } else if (now.getDate() === was.getDate()) {
            labelC.text = "UM"
            labelD.text = Qt.formatDateTime(docroot.time, "hh:mm")
        }

        now.setHours(0)
        now.setMilliseconds(0)
        now.setSeconds(0)
        now.setMinutes(0)

        var a = was
        a.setMilliseconds(0)
        a.setSeconds(0)
        a.setMinutes(0)
        a.setHours(0)

        var dayDelta = now.getTime() - a.getTime()
        var dayDifference = dayDelta / (24 * 60 * 60 * 1000)

        if (dayDifference > 0) {
            if (dayDifference == 1) {
                labelB.text = "gestern"
            } else {
                labelB.text = Qt.formatDateTime(docroot.time, "dd.MM.yy")
            }

            labelC.text = "UM"
            labelD.text = Qt.formatDateTime(docroot.time, "hh:mm")
            return
        }
    }

    function reset() {
        labelA.text = ""
        labelB.text = ""
        labelC.text = ""
        labelD.text = ""
    }

    Row {
        id: row
        spacing: 5

        TextLabel {
            id: labelA
            fontSize: Fonts.verySmallControlFontSize
            color: Colors.lightGrey
            anchors.verticalCenter: parent.verticalCenter
        }

        TextLabel {
            anchors.verticalCenter: parent.verticalCenter
            fontSize: Fonts.contentFontSize
            id: labelB
        }

        TextLabel {
            anchors.verticalCenter: parent.verticalCenter
            id: labelC
            fontSize: Fonts.verySmallControlFontSize
            color: Colors.lightGrey
        }
        TextLabel {
            anchors.verticalCenter: parent.verticalCenter
            fontSize: Fonts.contentFontSize
            id: labelD
        }
    }
}
