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

Item
{
   id: docroot

   signal clicked()

   property alias iconColor: icon.iconColor
   property alias icon: icon.icon
   property alias iconSize: icon.iconSize
   property alias iconOpacity: icon.opacity
   property bool selected: false
  // property bool containsMouse: area.containsMouse
   property alias area: area
   property string toolTipText
   property int toolTipDelay: 1000


   width: 40
   height: 40

   Icon
   {
        id: icon
        anchors.centerIn: parent
   }


   Rectangle
   {
       id: background
       anchors.fill: parent
       color: Colors.white
       opacity: 0
   }

   MouseArea
   {
        id: area
        hoverEnabled: true
        anchors.fill: parent
        onClicked: docroot.clicked()
   }

   Loader
   {
       anchors.fill: parent
       active: docroot.toolTipText !== ""

       sourceComponent:
       TooltipFlyout
       {
           isHovered: area.containsMouse
           text: docroot.toolTipText
           delay: docroot.toolTipDelay
       }
   }

   states:
   [
       State
       {
           when: docroot.selected
           name:"checked"
           PropertyChanges
           {
               target: background
               opacity: .1
           }
       },
       State
       {
           name:"hover"
           when: area.containsMouse

           PropertyChanges
           {
               target: background
                  opacity: .05
           }
       }
   ]
}
