#include <QObject>

class Background : QObject
{
    Q_OBJECT

    public:
        Background(QObject* parent);

        void doNotExportToDBus();
        
        void refreshBackground();
        QString currentBackground();

    Q_SIGNALS:
        void doNotExportThisSignal();
        void backgroundChanged();

    public Q_SLOTS:
        bool setBackground(QString name);

    protected Q_SLOTS:
        void dbusCanNotSeeMe();
};
