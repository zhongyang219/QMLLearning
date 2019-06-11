#include "QtGuiApplication1.h"
#include <QMessageBox>
#include <QQmlEngine>
#include <QQmlContext>


QtGuiApplication1::QtGuiApplication1(QWidget *parent)
{
    setSource(QUrl("qrc:/QtGuiApplication1/Resources/ui.qml"));
    this->rootContext()->setContextProperty("dataSource", this);

    QObject::connect((QObject*)rootObject(), SIGNAL(btn1Clicked()), this, SLOT(onBtn1Clicked()));
    QObject::connect((QObject*)rootObject(), SIGNAL(edit1TextChanged(QVariant)), this, SLOT(onEdit1TextChanged(QVariant)));

    //生成列表数据
    m_listData = QJsonArray();
    for (int i = 0; i < 30; i++)
    {
        QString num = QString::number(i);
        m_listData.append(ConvertToJsonObj(u8"第" + num + u8"个", num, u8"~"));
    }
    emit listDataChanged();
}

void QtGuiApplication1::onBtn1Clicked()
{
    QMessageBox::information(nullptr, nullptr, u8"按钮被点击");

}

Q_INVOKABLE void QtGuiApplication1::onListItemClicked(int index)
{
    int a = 0;
}

void QtGuiApplication1::onEdit1TextChanged(QVariant strText)
{
    QString str = strText.toString();
    int a = 0;
}

QJsonObject QtGuiApplication1::ConvertToJsonObj(const QString& name, const QString& value, const QString& unit)
{
    QJsonObject itemObj;
    itemObj[u8"name"] = name;
    itemObj[u8"value"] = value;
    itemObj[u8"unit"] = unit;
    return itemObj;
}
