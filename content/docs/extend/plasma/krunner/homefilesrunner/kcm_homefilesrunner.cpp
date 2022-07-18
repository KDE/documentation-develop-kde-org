#include "kcm_homefilesrunner.h"

#include <KPluginFactory>

HomeFilesRunnerConfig::HomeFilesRunnerConfig(QWidget *parent, const QVariantList &args)
    : KCModule(parent, args)
{
}

K_PLUGIN_CLASS(HomeFilesRunnerConfig)

#include "kcm_homefilesrunner.moc"
