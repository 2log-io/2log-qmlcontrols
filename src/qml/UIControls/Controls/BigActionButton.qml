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


import QtQuick 2.0
import QtQuick.Controls 2.12
import UIControls 1.0

AbstractButton
{
    id: docroot
    Rectangle
    {
        id: background
        anchors.fill: parent
        color:Colors.white_op5
    //   radius: 5
   //     border.color: Colors.white_op30
    }

    states:
    [
        State
        {
            name:"pressed"
            when: docroot.pressed
            PropertyChanges
            {
                target:background
                color: Colors.white_op30
            }
        }
    ]

    transitions:
    Transition
    {
        from:"pressed"
        ColorAnimation
        {

        }
    }
}
