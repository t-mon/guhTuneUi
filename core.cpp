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
