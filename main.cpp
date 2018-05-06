#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	auto engine = new QQmlApplicationEngine();
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
	auto result = app.exec();

	delete engine;
	return result;
}
