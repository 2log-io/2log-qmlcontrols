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


#include "arc.h"
#include <QtMath>
#include <cmath>

/*!
    \brief Arc::Arc constructs the arc.
*/
RoundArc::RoundArc(QQuickItem *parent) :
    QQuickItem(parent),
    _startAngle(0.0),
    _endAngle(0.0),
    _color(nullptr),
    _thickness(0.0),
    _arcNode(nullptr),
    _arcGeometry(nullptr),
    _segmentCount(0)
{
    _color = new QSGFlatColorMaterial;

    connect(this, &QQuickItem::widthChanged, this, &RoundArc::update);
    connect(this, &QQuickItem::heightChanged, this, &RoundArc::update);
    setFlag(ItemHasContents, true);
}

/*!
    \brief Arc::~Arc destruts the arc.
*/
RoundArc::~RoundArc()
{
    _mutex.lock();
    _mutex.unlock();
}

/*!
    \brief RoundArc::startAngle gets the startAngle property.
*/
double RoundArc::startAngle() const
{
    return this->_startAngle;
}

/*!
    \brief RoundArc::setStartAngle sets the startAngle property.
*/
void RoundArc::setStartAngle(double startAngle)
{
    if(this->_startAngle == startAngle)
    {
        return;
    }

    _mutex.lock();
    this->_startAngle = startAngle;
    _mutex.unlock();

    emit startAngleChanged(startAngle);
    update();
}

/*!
    \brief RoundArc::endAngle gets the endAngle property.
*/
double RoundArc::endAngle() const
{
    return this->_endAngle;
}

/*!
    \brief RoundArc::setEndAngle sets the endAngle property.
*/
void RoundArc::setEndAngle(double endAngle)
{
    if(this->_endAngle == endAngle)
    {
        return;
    }

    _mutex.lock();
    this->_endAngle = endAngle;
    _mutex.unlock();

    emit endAngleChanged(endAngle);
    update();
}

/*!
    \brief RoundArc::thickness gets the thickness property.
*/
double RoundArc::thickness() const
{
    return this->_thickness;
}

/*!
    \brief RoundArc::setThickness sets the thickness property.
*/
void RoundArc::setThickness(double thickness)
{
    if(this->_thickness == thickness)
    {
        return;
    }

    _mutex.lock();
    this->_thickness = thickness;
    _mutex.unlock();

    emit thicknessChanged(thickness);
    update();
}

/*!
    \brief RoundArc::color gets the color property.
*/
QColor RoundArc::color() const
{
    return this->_color->color();
}

/*!
    \brief RoundArc::setColor sets the color property.
*/
void RoundArc::setColor(const QColor &color)
{
    if(_color->color() == color)
    {
        return;
    }

    _mutex.lock();
    _color->setColor(color);
    _mutex.unlock();
    emit colorChanged(color);
    update();
}

/*!
    \brief RoundArc::updatePaintNode overrides the update paint node method of QQuickItem.
*/
QSGNode *RoundArc::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    if(width() <= 0 || height() <= 0) {
        return nullptr;
    }

    _mutex.lock();

    _arcNode = 0;
    _arcGeometry = 0;

    double segmentCount = (2 * M_PI * (width() / 2.0 - _thickness / 2.0) * qFabs(_endAngle - _startAngle) / 360) / 2;
    int arcPointsCount = (2 * segmentCount) + 2;

    // get next even number to get an smooth edge
    arcPointsCount = (arcPointsCount + 1) & ~1;

    if (!oldNode)
    {
        // generete arc node
        _arcNode = new QSGGeometryNode;

        _arcGeometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), arcPointsCount);
        _arcGeometry->setDrawingMode(QSGGeometry::DrawTriangleStrip);
        _arcNode->setGeometry(_arcGeometry);
        _arcNode->setFlag(QSGNode::OwnsGeometry);

        _arcNode->setMaterial(_color);
        _arcNode->setFlag(QSGNode::OwnsMaterial);
    }
    else
    {
        _arcNode = static_cast<QSGGeometryNode *>(oldNode);
        _arcGeometry = _arcNode->geometry();
        _arcGeometry->allocate(arcPointsCount);
    }

    // draw the arc
    qreal startAngle = qDegreesToRadians(_startAngle);
    qreal endAngle = qDegreesToRadians(_endAngle);
    qreal interval = qFabs(endAngle - startAngle) / segmentCount;

    // use -90 to start the arc on the top
    qreal start = qDegreesToRadians(_startAngle - 90);

    drawArc(_arcGeometry, start, interval, arcPointsCount);

    _arcNode->markDirty(QSGNode::DirtyGeometry);
    _arcNode->markDirty(QSGNode::DirtyMaterial);

    _mutex.unlock();

    return _arcNode;
}

bool RoundArc::isIn(float x, float y)
{
    float r = this->width() / 2;
    float deltaX = x - r;
    float deltaY = y - r;
    float angleRad = qAtan2(deltaY, deltaX);
    float angleDeg= angleRad * (180 / M_PI);
    angleDeg =  fmod(angleDeg + 180 + 270, 360);
    float distance = sqrt(pow(deltaX, 2) + pow(deltaY, 2));
    return (distance < r && distance > (r - this->thickness()) && angleDeg > this->startAngle() && angleDeg < this->endAngle());
    return true;
}

/*!
    \brief RoundA::drawArc draws an arc.
*/
void RoundArc::drawArc(QSGGeometry *geometry, qreal &startAngle, qreal interval, int pointsCount)
{
    if(!geometry || width() <= 0 || height() <= 0)
    {
        return;
    }

    QSGGeometry::Point2D *vertices = geometry->vertexDataAsPoint2D();

    float halfTickness = _thickness / 2;
    float radius = width() / 2.0 - _thickness / 2.0;

    for(int i = 0; i < pointsCount; i += 2) {

        vertices[i].x = (radius - halfTickness) * qCos(startAngle) + width() / 2;
        vertices[i].y = (radius - halfTickness) * qSin(startAngle) + height() / 2;
        vertices[i + 1].x = (radius + halfTickness) * qCos(startAngle) + width() / 2;
        vertices[i + 1].y = (radius + halfTickness) * qSin(startAngle) + height() / 2;

        startAngle += interval;
    }
}
