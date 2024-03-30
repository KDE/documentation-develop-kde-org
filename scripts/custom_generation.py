import os
from pathlib import Path

os.environ["PACKAGE"] = 'documentation-develop-kde-org'
os.system('git clone https://invent.kde.org/websites/hugo-i18n && pip3 install ./hugo-i18n')
os.system('hugoi18n compile po')  # compile translations in folder "po"
os.system('hugoi18n generate')

os.system('python3 scripts/extract-plasma-applet-config-keys.py')

scriptpath = Path(__file__).parent

if not os.path.exists(scriptpath / "ciutilities"):
    if not os.path.exists(scriptpath / "../ci-utilities"):
        os.system(f'git clone https://invent.kde.org/sysadmin/ci-utilities.git {scriptpath.parent.absolute()}/ci-utilities')

    os.symlink(scriptpath / '../ci-utilities', scriptpath / 'ciutilities')

os.system('python3 scripts/icon_extractor.py')
