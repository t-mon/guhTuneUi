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

class Core : public QObject
{
    Q_OBJECT
public:
    explicit Core(QObject *parent = 0);

private:
    QQuickView *m_view;

signals:

public slots:

};

#endif // CORE_H
