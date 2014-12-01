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
    //write(QByteArray::number(1) + ":50\n");
}

void GuhClient::slotDisconnected()
{
    qDebug() << "disconnected from server " << peerAddress() << peerPort();
}

void GuhClient::readData()
{
    while(canReadLine()){
        QByteArray data = readLine();
        qDebug() << data;
        if(data.endsWith('\n')){
            if (data == "NL\n") {
                qDebug() << "navigation left";
                emit navigateLeft();
            } else if (data == "NR\n") {
                qDebug() << "navigation right";
                emit navigateRight();
            } else if (data == "L\n") {
                qDebug() << "tick left";
                emit tickLeft();
            } else if (data == "R\n") {
                qDebug() << "tick right";
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
                emit handDisappeared();
            } else if (data.left(2) == "1:"){
                if(data.right(2) == "0\n"){
                    qDebug() << "item 1 -> OFF";
                    emit itemChangedPowerState(1,false);
                }
                if(data.right(2) == "1\n"){
                    qDebug() << "item 1 -> ON";
                    emit itemChangedPowerState(1,true);
                }
            } else if (data.left(2) == "2:"){
                if(data.right(2) == "0\n"){
                    qDebug() << "item 2 -> OFF";
                    emit itemChangedPowerState(2,false);
                }
                if(data.right(2) == "1\n"){
                    qDebug() << "item 2 -> ON";
                    emit itemChangedPowerState(2,true);
                }
            } else if (data.left(2) == "3:"){
                if(data.right(2) == "0\n"){
                    qDebug() << "item 3 -> OFF";
                    emit itemChangedPowerState(3,false);
                }
                if(data.right(2) == "1\n"){
                    qDebug() << "item 3 -> ON";
                    emit itemChangedPowerState(3,true);
                }
            } else {
                qDebug() << "ERROR: could nor parse message:" << data;
            }
        }
    }
}

bool GuhClient::sendData(const QByteArray &data)
{
    if (state() != QTcpSocket::ConnectedState) {
        qWarning() << "ERROR: could not send data. Socket not connected.";
        return false;
    }

    write(data + "\n");
    return true;
}
