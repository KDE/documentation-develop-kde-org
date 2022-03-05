import os

os.system('git clone https://invent.kde.org/websites/hugo-i18n && pip3 install ./hugo-i18n')
os.system('hugoi18n generate')
