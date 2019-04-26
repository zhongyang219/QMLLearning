#include "QtGuiApplication1.h"
#include <QMessageBox>

QtGuiApplication1::QtGuiApplication1(QWidget *parent)
{
	setSource(QUrl("qrc:/QtGuiApplication1/Resources/ui.qml"));

	QObject::connect((QObject*)rootObject(), SIGNAL(btn1Clicked()), this, SLOT(onBtn1Clicked()));
	QObject::connect((QObject*)rootObject(), SIGNAL(edit1TextChanged(QVariant)), this, SLOT(onEdit1TextChanged(QVariant)));
}

void QtGuiApplication1::onBtn1Clicked()
{
	QMessageBox::information(nullptr, nullptr, u8"°´Å¥±»µã»÷");

}

void QtGuiApplication1::onEdit1TextChanged(QVariant strText)
{
	QString str = strText.toString();
	int a = 0;
}
