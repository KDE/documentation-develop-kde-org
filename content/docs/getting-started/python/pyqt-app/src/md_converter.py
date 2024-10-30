from markdown import markdown
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot, pyqtProperty

class MdConverter(QObject):
    """A simple markdown converter"""

    sourceTextChanged = pyqtSignal()

    def __init__(self, _source_text):
        super().__init__()
        self._source_text = ""

    def readSourceText(self):
        return self._source_text

    def setSourceText(self, val):
        self._source_text = val
        self.sourceTextChanged.emit()

    sourceText = pyqtProperty(
        str, readSourceText, setSourceText, notify=sourceTextChanged
    )

    @pyqtSlot(result=str)
    def mdFormat(self):
        return markdown(self._source_text)
