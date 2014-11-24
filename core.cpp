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

Core::Core(QObject *parent) :
    QObject(parent)
{
    qmlRegisterUncreatableType<Core>("guhtune", 1, 0, "GuhTuneUi", "can't create one. use \"controller\".");
    m_view = new QQuickView();
    m_view->engine()->addImportPath(QLatin1String("modules"));
    m_view->engine()->rootContext()->setContextProperty("controller", this);
    m_view->setSource(QUrl(QLatin1String("qrc:///guhtune-ui/main.qml")));
    m_view->setResizeMode(QQuickView::SizeRootObjectToView);
    m_view->showFullScreen();
}
