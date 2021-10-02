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
import QtGraphicalEffects 1.0
import UIControls 1.0

Rectangle
{
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
//    onTriangleDeltaChanged:  canvas.requestPaint()
//    onTriangleSideChanged: canvas.requestPaint()
//    onTriangleHeightChanged: canvas.requestPaint()
//    onWidthChanged: canvas.requestPaint()
//    onHeightChanged: canvas.requestPaint()

    Shadow{
        id: shadow
        shadowSize: shadowSizeVar
    }

    FlyoutPainter
    {
        id: canvas
        width: parent.width + ((triangleSide == Qt.RightEdge || triangleSide == Qt.LeftEdge) ? triangleHeight : 0)
        height: parent.height + ((triangleSide == Qt.TopEdge || triangleSide == Qt.BottomEdge) ? triangleHeight : 0)
        triangleDelta: docroot.triangleDelta
        triangleHeight: docroot.triangleHeight
        borderColor: docroot.borderColor
        borderWidth: docroot.borderWidth
        fillColor: docroot.fillColor
        triangleSide: docroot.triangleSide

        y:
        {
         if(triangleSide == Qt.TopEdge)
             return -triangleHeight;
         return 0
        }

        x:
        {
        if(triangleSide == Qt.LeftEdge)
            return -triangleHeight;
        return 0
        }

//        onPaint:
//        {
//            var ctx = canvas.getContext('2d')
//            ctx.save()
//            ctx.clearRect(0, 0, canvas.width+1, canvas.height+1);
//            ctx.beginPath()

//            if(docroot.triangleSide == Qt.TopEdge)
//            {
//                ctx.moveTo(-1.0 ,triangleHeight-1.0);
//                ctx.lineTo(triangleDelta, triangleHeight-1.0);   //  _
//                ctx.lineTo(triangleDelta+triangleHeight, 1.0)      //    /
//                ctx.lineTo(triangleDelta+2*triangleHeight, triangleHeight-1.0) // \
//                ctx.lineTo(docroot.width-1.0, triangleHeight-1.0) // _
//                ctx.lineTo(docroot.width-1.0, triangleHeight+docroot.height-1.0)
//                ctx.lineTo(1.0, triangleHeight+docroot.height-1.0)
//                ctx.lineTo(1.0, triangleHeight)
//            }

//            else if (docroot.triangleSide == Qt.LeftEdge)
//            {
//                ctx.moveTo(triangleHeight-1, 1);
//                ctx.lineTo(triangleHeight-1+docroot.width, 1);   //  _
//                ctx.lineTo(triangleHeight-1+docroot.width, docroot.height-1)      //    /
//                ctx.lineTo(triangleHeight-1, docroot.height-1);
//                ctx.lineTo(triangleHeight-1, triangleDelta + triangleHeight);
//                ctx.lineTo(1,triangleDelta);
//                ctx.lineTo(triangleHeight-1, triangleDelta - triangleHeight);
//                ctx.lineTo(triangleHeight-1, 1);
//            }

//            else if(docroot.triangleSide == Qt.BottomEdge)
//            {
//                ctx.moveTo(1, 1);
//                ctx.lineTo(docroot.width -1, 1);
//                ctx.lineTo(docroot.width -1, docroot.height-1);
//                ctx.lineTo(docroot.triangleDelta+triangleHeight, docroot.height-1)
//                ctx.lineTo(docroot.triangleDelta, docroot.height-1+triangleHeight)
//                ctx.lineTo(docroot.triangleDelta-triangleHeight, docroot.height-1)
//                ctx.lineTo(1, docroot.height-1)
//                ctx.lineTo(1,1)
//            }

//            else if(docroot.triangleSide == Qt.RightEdge)
//            {
//                ctx.moveTo(1, 1);
//                ctx.lineTo(docroot.width -1, 1);
//                ctx.lineTo(docroot.width -1, triangleDelta-triangleHeight);
//                ctx.lineTo(docroot.width -1 + triangleHeight, triangleDelta);
//                ctx.lineTo(docroot.width -1, triangleDelta+triangleHeight);
//                ctx.lineTo(docroot.width -1, docroot.height-1);
//                ctx.lineTo(1, docroot.height-1)
//                ctx.lineTo(1,1)
//            }

//            ctx.closePath()

//            ctx.fillStyle = docroot.fillColor
//            ctx.lineWidth = borderWidth
//            ctx.strokeStyle = docroot.borderColor

//            ctx.fill();
//            ctx.stroke();
//        }
    }
}
