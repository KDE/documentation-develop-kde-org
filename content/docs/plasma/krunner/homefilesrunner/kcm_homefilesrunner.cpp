#include "kcm_homefilesrunner.h"

#include <KConfigGroup>
#include <KPluginFactory>
#include <KSharedConfig>
#include <QDir>
#include <QLabel>

HomeFilesRunnerConfig::HomeFilesRunnerConfig(QWidget *parent, const QVariantList &args)
    : KCModule(parent, args)
{
    KSharedConfigPtr krunnerConfig = KSharedConfig::openConfig(QStringLiteral("krunnerrc"));
    KConfigGroup pluginConfig = krunnerConfig->group("Runners").group("runner_example_homefiles");

    const QString triggerWord = pluginConfig.readEntry("trigger");
    const QString path = pluginConfig.readEntry("path", QDir::homePath());

    new QLabel(QLatin1String("The keyword is %1 and the path is %2").arg(triggerWord, path), this);

    // To allow editing the values, override KCModule::load KCModule::save and KCModule::defaults
}

K_PLUGIN_CLASS(HomeFilesRunnerConfig)

#include "kcm_homefilesrunner.moc"
