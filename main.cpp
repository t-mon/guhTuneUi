#include <QGuiApplication>
#include "core.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Core core;

    return app.exec();
}
