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

#ifndef GUHCLIENT_H
#define GUHCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QHostAddress>

class GuhClient : public QTcpSocket
{
    Q_OBJECT
public:
    explicit GuhClient(QObject *parent = 0);

private slots:
    void slotConnected();
    void slotDisconnected();
    void readData();

signals:
    void navigateLeft();
    void navigateRight();
    void tickLeft();
    void tickRight();
    void buttonPressed();
    void buttonReleased();
    void buttonLongPressed();
    void handDetected();
    void handDisappeard();

    void itemChangedPowerState(const int &item, const bool & powerState);

public slots:
    bool sendData(const QByteArray &data);
};

#endif // GUHCLIENT_H
