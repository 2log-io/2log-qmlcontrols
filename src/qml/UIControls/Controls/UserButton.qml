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
import QtQuick.Layouts 1.3
import CloudAccess 1.0


Item
{
    id: docroot

    property bool checked
    property bool displayInititals
    signal clicked()

    width: btnRow.width + 30
    height: parent.height


    Rectangle
    {
        id: background
        anchors.fill: parent
        color:"transparent"
        opacity: .05
    }

    Row
    {
        id: btnRow
        x:15
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        spacing:10
        RoundGravatarImage
        {
            eMail: UserLogin.currentUser.userData === undefined ? "" : UserLogin.currentUser.eMail
            width: 35
            height: 35
        }
        TextLabel
        {
            id: text
            opacity: .6
            fontSize: Fonts.subHeaderFontSize
            anchors.verticalCenter: parent.verticalCenter
            text:
            {
                var name = UserLogin.currentUser.userName
                if( name === "")
                    name =  UserLogin.currentUser.userID
                return name ? name : ""
            }
        }

    }

    MouseArea
    {
        id: area
        hoverEnabled: true
        anchors.fill: parent
        onClicked: docroot.clicked()
    }

    states:
    [
        State
        {
            name: "selected"
            when: docroot.checked
            PropertyChanges
            {
                target: background
                color: Colors.black
                opacity: .1
            }

            PropertyChanges
            {
                target: text
                opacity: 1
            }
        },

        State
        {
            when: area.containsMouse
            PropertyChanges
            {
                target: background
                color: Colors.white
            }
        }
    ]
}
