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


#ifndef FLYOUTPAINTER_H
#define FLYOUTPAINTER_H

#include <QObject>
#include <QQuickPaintedItem>

class FlyoutPainter : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(int borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(int triangleHeight READ triangleHeight WRITE setTriangleHeight NOTIFY triangleHeightChanged)
    Q_PROPERTY(int triangleDelta READ triangleDelta WRITE setTriangleDelta NOTIFY triangleDeltaChanged)
    Q_PROPERTY(Qt::Edge triangleSide READ triangleSide WRITE setTriangleSide NOTIFY triangleSideChanged)
    Q_PROPERTY(QColor borderColor READ borderColor WRITE setBorderColor NOTIFY borderColorChanged)
    Q_PROPERTY(QColor fillColor READ fillColor WRITE setFillColor NOTIFY fillColorChanged)

public:
    explicit FlyoutPainter(QQuickItem *parent = nullptr);
    void paint(QPainter *painter);

    int borderWidth() const;
    void setBorderWidth(int borderWidth);

    int triangleHeight() const;
    void setTriangleHeight(int triangleHeight);

    int triangleDelta() const;
    void setTriangleDelta(int triangleDelta);

    Qt::Edge triangleSide() const;
    void setTriangleSide(const Qt::Edge &triangleSide);

    QColor borderColor() const;
    void setBorderColor(const QColor &borderColor);

    QColor fillColor() const;
    void setFillColor(const QColor &fillColor);

private:
    int _borderWidth;
    int _triangleHeight;
    int _triangleDelta;

    Qt::Edge _triangleSide = Qt::TopEdge;
    QColor _borderColor;
    QColor _fillColor;

signals:
    void borderWidthChanged();
    void triangleHeightChanged();
    void triangleDeltaChanged();
    void triangleSideChanged();
    void borderColorChanged();
    void fillColorChanged();

signals:

};

#endif // FLYOUTPAINTER_H
