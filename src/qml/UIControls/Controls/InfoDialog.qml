

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
import QtQuick.Controls 2.4
import UIControls 1.0
import QtQuick.Layouts 1.3

Popup {

    id: docroot

    default property alias content: row.children
    property string text
    property string headline
    property string icon
    property alias iconColor: icon.iconColor

    Overlay.modal: Rectangle {

        color: Colors.black_op50
    }

    enter: Transition {
        PropertyAnimation {
            property: "opacity"
            from: .3
            to: 1
            duration: 350
            easing.type: Easing.OutQuad
        }
    }

    modal: true
    focus: true
    padding: 20

    background: Rectangle {
        color: Colors.darkBlue
        Shadow {}
    }

    ColumnLayout {
        id: columnLayout
        spacing: 20

        TextLabel {
            visible: text !== ""
            text: docroot.headline
            fontSize: Fonts.headerFontSze
            font.styleName: "Bold"
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20

            Icon {
                id: icon
                icon: docroot.icon
                iconSize: 40
                Layout.alignment: Qt.AlignVCenter
            }

            TextLabel {
                wrapMode: Text.Wrap
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: root.width > 800 ? root.width * 0.4 : root.width - 110
                text: docroot.text
            }
        }

        Row {
            id: row
            spacing: 20
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
