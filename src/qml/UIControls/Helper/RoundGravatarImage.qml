

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
import QtGraphicalEffects 1.0
import UIControls 1.0

Item {
    id: docroot

    width: 50
    height: 50

    property string source: getGravatarURL(eMail, size)
    property bool valid: imageItem.status == Image.Ready
    property string eMail
    property int size: 80
    property int radius: width / 2

    function getGravatarURL(eMail, size) {
        if (eMail === "")
            return ""

        var imageSize
        if (size === undefined)
            imageSize = 80
        else
            imageSize = size

        return "https://www.gravatar.com/avatar/" + Qt.md5(
                    eMail) + "?s=" + imageSize + "&d=robohash"
    }

    Rectangle {
        visible: !docroot.valid
        radius: docroot.radius
        color: Colors.darkBlue
        anchors.fill: parent

        Icon {
            width: parent.width
            iconSize: 22
            opacity: .4
            height: parent.height
            iconColor: "white"
            anchors.centerIn: parent
            anchors.fill: parent
            icon: Icons.user
        }
    }

    Rectangle {
        id: imageFrame
        anchors.fill: parent
        visible: imageItem.status == Image.Ready
        radius: docroot.radius
        color: Colors.black_op25

        Image {
            id: imageItem
            anchors.fill: parent
            anchors.centerIn: parent
            source: docroot.source
            visible: false

            Component.onDestruction: {
                if (imageItem.status === Image.Loading) {
                    imageItem.source = ""
                }
            }
        }

        OpacityMask {
            anchors.fill: imageItem
            source: imageItem
            maskSource: Rectangle {
                width: docroot.width
                height: docroot.height
                radius: imageFrame.radius
                visible: false
            }
        }
    }
}
