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


#include "flyoutpainter.h"
#include <QPainterPath>
#include <QPen>
#include <QPainter>
FlyoutPainter::FlyoutPainter(QQuickItem *parent) : QQuickPaintedItem(parent)
{

}

void FlyoutPainter::paint(QPainter *painter)
{
    QPen pen;
    pen.setColor(_borderColor);
    pen.setWidth(_borderWidth);
    pen.setJoinStyle(Qt::MiterJoin);
    QBrush brush(_fillColor);
    painter->setBrush(brush);
    painter->setPen(pen);

    float delta = (float) _borderWidth/2;// / 2;
    QPainterPath path;
    if(_triangleSide == Qt::TopEdge)
    {
        path.moveTo(delta ,_triangleHeight+delta);
        path.lineTo(_triangleDelta, _triangleHeight+delta);   //  _
        path.lineTo(_triangleDelta+_triangleHeight, delta);      //    /
        path.lineTo(_triangleDelta+2*_triangleHeight, _triangleHeight+delta); //
        path.lineTo(this->width() - delta, _triangleHeight+delta); // _
        path.lineTo(this->width() - delta, this->height()-delta);
        path.lineTo(delta, this->height()-delta);
        path.lineTo(delta, _triangleHeight+delta);
    }

    if(_triangleSide == Qt::BottomEdge)
    {
        path.moveTo(delta, delta);
        path.lineTo(this->width() -delta, delta);
        path.lineTo(this->width() -delta, this->height()-delta-_triangleHeight);
        path.lineTo(_triangleDelta+_triangleHeight, this->height()-delta-triangleHeight());
        path.lineTo(_triangleDelta, this->height()-delta);
        path.lineTo(_triangleDelta-_triangleHeight, this->height()-delta-triangleHeight());
        path.lineTo(delta, this->height()-delta-triangleHeight());
        path.lineTo(delta,delta);
    }
    path.closeSubpath();
    painter->drawPath(path);
}

int FlyoutPainter::borderWidth() const
{
    return _borderWidth;
}

void FlyoutPainter::setBorderWidth(int borderWidth)
{
    _borderWidth = borderWidth;
    Q_EMIT borderWidthChanged();
    update();
}

int FlyoutPainter::triangleHeight() const
{
    return _triangleHeight;
}

void FlyoutPainter::setTriangleHeight(int triangleHeight)
{
    _triangleHeight = triangleHeight;
    Q_EMIT triangleHeightChanged();
    update();
}

int FlyoutPainter::triangleDelta() const
{
    return _triangleDelta;
}

void FlyoutPainter::setTriangleDelta(int triangleDelta)
{
    _triangleDelta = triangleDelta;
    Q_EMIT triangleDeltaChanged();
    update();
}

Qt::Edge FlyoutPainter::triangleSide() const
{
    return _triangleSide;
}

void FlyoutPainter::setTriangleSide(const Qt::Edge &triangleSide)
{
    _triangleSide = triangleSide;
    Q_EMIT triangleSideChanged();
    update();
}

QColor FlyoutPainter::borderColor() const
{
    return _borderColor;
}

void FlyoutPainter::setBorderColor(const QColor &borderColor)
{
    _borderColor = borderColor;
    Q_EMIT borderColorChanged();
    update();
}

QColor FlyoutPainter::fillColor() const
{
    return _fillColor;
}

void FlyoutPainter::setFillColor(const QColor &fillColor)
{
    _fillColor = fillColor;
    Q_EMIT fillColorChanged();
    update();
}
