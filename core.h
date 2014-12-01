/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                                                                         *
 *  This file is part of guh.                                              *
 *                                                                         *
 *  Guh is free software: you can redistribute it and/or modify            *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation, version 2 of the License.                *
 *                                                                         *
 *  Guh is distributed in the hope that it will be useful,                 *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with guh. If not, see <http://www.gnu.org/licenses/>.            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQml>
#include <QDebug>
#include <QQuickView>
#include <QHostAddress>

#include "guhclient.h"

class Core : public QObject
{
    Q_OBJECT
    Q_ENUMS(Rotation)
public:
    enum Rotation {
        RotationLeft,
        RotationRight
    };
    explicit Core(QObject *parent = 0);

private:
    QQuickView *m_view;
    GuhClient *m_client;

private slots:
    void connectToGuh(const QString &host);

    void itemPressed(const int &itemNumber);
    void itemValueChanged(const int &itemNumber, const int &value);

    void onNavigationLeft();
    void onNavigationRight();
    void onTickLeft();
    void onTickRight();

    void onOffChanged(const int &index, const bool &powerState);

signals:
    void navigateLeft();
    void navigateRight();
    void tickLeft();
    void tickRight();
    void buttonPressed();
    void buttonReleased();
    void buttonLongPressed();
    void handDetected();
    void handDisappeared();

    void smallStep(Rotation rotation);
    void bigStep(Rotation rotation);
    void wakeup();

public slots:
    void toggle(int index);
    void setValue(int index, int value);



};

#endif // CORE_H
