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

#include "core.h"
#include <QJsonDocument>


Core::Core(QObject *parent) :
    QObject(parent)
{
    qmlRegisterUncreatableType<Core>("core", 1, 0, "Core", "can't create one. use \"controller\".");
    m_view = new QQuickView();
    m_view->engine()->addImportPath(QLatin1String("modules"));
    m_view->engine()->rootContext()->setContextProperty("controller", this);
    m_view->setSource(QUrl(QLatin1String("qrc:///guhtune-ui/main.qml")));
    m_view->setResizeMode(QQuickView::SizeRootObjectToView);
    m_view->showFullScreen();

    m_client = new GuhClient(this);
    connect(m_client, SIGNAL(buttonPressed()), this, SIGNAL(buttonPressed()));
    connect(m_client, SIGNAL(buttonReleased()), this, SIGNAL(buttonReleased()));
    connect(m_client, SIGNAL(buttonLongPressed()), this, SIGNAL(buttonLongPressed()));
    connect(m_client, SIGNAL(tickLeft()), this, SLOT(onTickLeft()));
    connect(m_client, SIGNAL(tickRight()), this, SLOT(onTickRight()));
    connect(m_client, SIGNAL(navigateLeft()), this, SLOT(onNavigationLeft()));
    connect(m_client, SIGNAL(navigateRight()), this, SLOT(onNavigationRight()));
    connect(m_client, SIGNAL(handDetected()), this, SIGNAL(handDetected()));
    connect(m_client, SIGNAL(handDisappeard()), this, SIGNAL(handDisappeard()));
    connect(m_client, SIGNAL(itemChangedPowerState(int,bool)), this, SLOT(onOffChanged(int,bool)));

    connectToGuh("10.10.10.53");

    QVariantMap map;
    map.insert("0", false); // light
    map.insert("1", false); // coutch
    map.insert("2", false); // tisch
    map.insert("3", false); // radiator
    m_view->engine()->rootContext()->setContextProperty("onOffStates", map);

}

void Core::connectToGuh(const QString &host)
{
    m_client->connectToHost(QHostAddress(host), 9876);
}

void Core::itemPressed(const int &itemNumber)
{
    m_client->sendData(QByteArray::number(itemNumber) + ":toggle");
}

void Core::itemValueChanged(const int &itemNumber, const int &value)
{
    m_client->sendData(QByteArray::number(itemNumber) + ":" + QByteArray::number(value));
}

void Core::toggle(int index)
{
    itemPressed(index+1);
}

void Core::setValue(int index, int value)
{
    itemValueChanged(index+1,value);
}

void Core::onNavigationLeft()
{
    emit bigStep(RotationLeft);
}

void Core::onNavigationRight()
{
    emit bigStep(RotationRight);
}

void Core::onTickLeft()
{
    emit smallStep(RotationLeft);
}

void Core::onTickRight()
{
    emit smallStep(RotationRight);
}

void Core::onOffChanged(const int &index, const bool &powerState)
{
    QVariantMap map = m_view->engine()->rootContext()->contextProperty("onOffStates").toMap();
    map[QString::number(index)] = powerState;
    m_view->engine()->rootContext()->setContextProperty("onOffStates", map);
}
