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


#ifndef ARC_H
#define ARC_H

#include <QQuickItem>
#include <QtCore/qmath.h>
#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>
#include <QMutex>
#include <QMutexLocker>

/*!
 * \brief The Arc class represents a graphical qt quick arc, describes by an start- and endangle.
 */
class RoundArc : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(double startAngle READ startAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(double endAngle READ endAngle WRITE setEndAngle NOTIFY endAngleChanged)
    Q_PROPERTY(double thickness READ thickness WRITE setThickness NOTIFY thicknessChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)

public:
    explicit RoundArc(QQuickItem *parent = nullptr);
    virtual ~RoundArc();
    virtual double startAngle() const;
    virtual void setStartAngle(double startAngle);
    virtual double endAngle() const;
    virtual void setEndAngle(double endAngle);
    virtual QColor color() const;
    virtual void setColor(const QColor &color);
    virtual double thickness() const;
    virtual void setThickness(double thickness);
    virtual QSGNode* updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *);
    Q_INVOKABLE bool isIn(float x, float y);

signals:
    void endAngleChanged(double endAngle);
    void startAngleChanged(double startAngle);
    void colorChanged(const QColor &color);
    void thicknessChanged(double thickness);

public slots:

private:
    double _startAngle;
    double _endAngle;
    QSGFlatColorMaterial* _color;
    double _thickness;
    QSGGeometryNode* _arcNode;
    QSGGeometry* _arcGeometry;
    QMutex _mutex;
    int _segmentCount;

    void calcSegementCount();
    void drawArc(QSGGeometry *geometry, qreal &rTheta, qreal rInterval, int pointsCount);
};

#endif // ARC_H
