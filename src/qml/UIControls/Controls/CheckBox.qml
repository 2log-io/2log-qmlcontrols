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
import QtQuick.Layouts 1.2

Rectangle
{
   id: docroot

   width: 28
   height: 28
   Layout.minimumWidth: width
   Layout.minimumHeight:height
   Layout.maximumHeight: height
   Layout.maximumWidth: width
   border.color: Colors.lightGrey
   border.width: 1
   color: Colors.darkBlue

   property bool checked: false

   Icon
   {
       visible: docroot.checked
       anchors.centerIn: parent
       icon: Icons.check
       iconSize: 14
   }

   MouseArea
   {
       id: mouse
       hoverEnabled: true
       anchors.fill: parent
       onClicked: docroot.checked = !docroot.checked
   }


   states:
   [
       State
       {
           name:"hover"
            when: mouse.containsMouse
            PropertyChanges
            {
                target: docroot.border
                color: Colors.white
            }
       }
   ]

   transitions:
   [
       Transition
       {
           from: "hover, focus"

           ColorAnimation
           {
               target: docroot.border
           }
       }
   ]
}
