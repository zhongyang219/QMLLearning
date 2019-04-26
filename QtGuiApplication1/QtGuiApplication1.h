#pragma once
#include "QQuickView"
#include <QVariant>

class QtGuiApplication1 : public QQuickView
{
	Q_OBJECT

public:
	QtGuiApplication1(QWidget *parent = Q_NULLPTR);

public slots:
	void onBtn1Clicked();
	void onEdit1TextChanged(QVariant strText);

private:
};
