import os

os.environ["PACKAGE"] = 'documentation-develop-kde-org'
os.system('git clone https://invent.kde.org/websites/hugo-i18n && pip3 install ./hugo-i18n')
os.system('hugoi18n compile po')  # compile translations in folder "po"
os.system('hugoi18n generate')

os.system('python3 scripts/extract-plasma-applet-config-keys.py')
