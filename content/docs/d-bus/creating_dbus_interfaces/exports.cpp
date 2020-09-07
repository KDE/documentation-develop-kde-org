#include <QObject>
class Background : QObject
{
    Q_OBJECT

    public:
        Background(QObject* parent);

        void doNotExportToDBus();

    Q_SIGNALS:
        void doNotExportThisSignal();
        Q_SCRIPTABLE void backgroundChanged();

    public Q_SLOTS:
        void refreshBackground();
        QString currentBackground();
        bool setBackground(QString name);

    protected Q_SLOTS:
        void dbusCanNotSeeMe();
};
