#pragma once
#include "QQuickView"
#include <QVariant>
#include <QJsonArray>
#include <QJsonObject>

class QtGuiApplication1 : public QQuickView
{
public:
    Q_OBJECT
    Q_PROPERTY(QJsonArray listData MEMBER m_listData NOTIFY listDataChanged)

public:
    QtGuiApplication1(QWidget *parent = Q_NULLPTR);

signals:
    void listDataChanged();

public slots:
    void onBtn1Clicked();
    void onEdit1TextChanged(QVariant strText);

private:
    QJsonObject ConvertToJsonObj(const QString& name, const QString& value, const QString& unit);

private:
    QJsonArray m_listData;
};
