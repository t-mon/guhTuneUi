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

#include "guhclient.h"

GuhClient::GuhClient(QObject *parent) :
    QTcpSocket(parent)
{
    connect(this, SIGNAL(connected()), this, SLOT(slotConnected()));
    connect(this, SIGNAL(disconnected()), this, SLOT(slotDisconnected()));
    connect(this, SIGNAL(readyRead()), this, SLOT(readData()));
}
void GuhClient::slotConnected()
{
    qDebug() << "connected to server " << peerAddress() << peerPort();
}

void GuhClient::slotDisconnected()
{
    qDebug() << "disconnected from server " << peerAddress() << peerPort();
}

void GuhClient::readData()
{

    QByteArray data = readAll();
    if (data == "NL") {
        qDebug() << "navigation left";
        emit navigateLeft();
    } else if (data == "NR\n") {
        qDebug() << "navigation right";
        emit navigateRight();
    } else if (data == "L\n") {
        qDebug() << "tick left";
        emit tickLeft();
    } else if (data == "R\n") {
        qDebug() << "rick right";
        emit tickRight();
    } else if (data == "BP\n") {
        qDebug() << "button pressed";
        emit buttonPressed();
    } else if (data == "BR\n") {
        qDebug() << "button released";
        emit buttonReleased();
    } else if (data == "BLP\n") {
        qDebug() << "button long pressed";
        emit buttonLongPressed();
    } else if (data == "HDE\n") {
        qDebug() << "hand detected";
        emit handDetected();
    } else if (data == "HDI\n") {
        qDebug() << "hand disappeared";
        emit handDisappeard();
    } else {
        qDebug() << "ERROR: could nor parse message:" << data;
    }
}

bool GuhClient::sendData(const QByteArray &data)
{
    if (state() != QTcpSocket::ConnectedState) {
        qWarning() << "ERROR: could not send data. Socket not connected.";
        return false;
    }

    write(data);
    return true;
}
