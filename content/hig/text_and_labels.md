---
title: "Text and labels"
weight: 9
aliases:
- /hig/style/writing/
- /hig/style/typography/
---

<!-- TODO: Add anything relevant from https://developer.apple.com/design/human-interface-guidelines/typography -->

Whenever writing text, start by following these guidelines:

- Make it as short as possible without losing meaning or precision.
- Keep it actionable.
- Front-load the most important information in longer text.
- Use plain language and minimize technical jargon. For example, prefer “folder” over “directory.”
- Adhere to common wording conventions.
- Use a neutral, informative tone: not informal, boring, exciting, or harsh.
- Use the word “Delete” for actions that remove files on disk.
- Don't overuse bold text and pull the user's attention in multiple directions at once.

And then keep in mind these implementation details:

- Use [QtQuick.Controls.Label](https://doc.qt.io/qt-6/qml-qtquick-controls2-label.html) for normal-sized text, and [Kirigami.Heading](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1Heading.html) (with a `level` suitable for the context) for larger header text. See [more information here](https://develop.kde.org/docs/getting-started/kirigami/style-typography/).
- Don't use [QtQuick.Text](https://doc.qt.io/qt-5/qml-qtquick-text.html) directly, as it doesn't respect the system's font settings.
- Manually assign [accelerator keys](https://doc.qt.io/qt-6.2/accelerators.html) only for text in buttons, radio buttons, checkboxes, and switches (in other places, they are auto-generated).
- Assign text for icons-only buttons anyway, so it can be read by screen readers. Hide the text by setting the [display](https://doc.qt.io/qt-5/qml-qtquick-controls2-abstractbutton.html#display-prop) property to `IconOnly` and then manually add a [tooltip](https://doc.qt.io/Qt-6/qml-qtquick-controls-tooltip.html) for the benefit of mouse and touch users.
- For standard actions, use [KStandardAction](https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html) so that it gets standard text automatically.


## Capitalization and punctuation
All user interface text is written in either [sentence case](https://apastyle.apa.org/style-grammar-guidelines/capitalization/sentence-case) or [title case](https://apastyle.apa.org/style-grammar-guidelines/capitalization/title-case). Use sentence case when:

- The text ends with a period or colon.
- The text is clearly a sentence.
- The text is a subtitle, tooltip, transient status message, or placeholder label.
- The text is used as a label for a radio button or checkbox.

Otherwise, use title case.

Also use title case for specialized proper nouns such as “the Internet” or “Plasma Widgets”.

Use a [serial comma/Oxford comma](https://apastyle.apa.org/style-grammar-guidelines/punctuation/serial-comma) when mentioning three or more list items in a sentence.

Put spaces around [em-dashes](https://www.merriam-webster.com/grammar/em-dash-en-dash-how-to-use).


## Acronyms
Avoid the use of acronyms, as many users will not know what they mean. Only use an acronym when you have to use the same term multiple times and can expand its acronym form once.

This guideline does not apply to highly technical software where the user is expected to be familiar with common terminology, but this is an exception, not the rule.

When you do use an acronym, capitalize all the letters (e.g. “URL”).


## Mood
Use the imperative mood when providing instructions of suggestions to the user.

**Good**: Save the file.

**Bad:** You should save the file.


## Buttons and menu items
Write labels for buttons and menu items to represent *actions* or *locations*:

- **An action makes something happen,** and begins with a verb in the imperative mood appropriate to describe the action. If the action is complex and requires additional user input before it completes (most commonly because it opens a dialog that prompts the user to make a further decision), end its label with an ellipsis. Use the real “…” ellipsis character (`U+2026` in Unicode), not three periods.
- **A location is another page, window, or sub-menu** that opens when the user triggers the button or menu item. Match the title of the new page or window in the button or menu item label.

Prefer the “action” form where the label's UI element may not otherwise look interactive—such as a toolbar with only one or two ToolButtons. In this case, the action verb helps to signal interactivity.

Buttons in dialogs also follow these rules. “OK” and “Yes” are never acceptable button labels!

**Good:** Open…

**Good:** Show More

**Good:** About \[app name\]

**Bad:** Yes (unclear what it refers to)

**Bad:** Print (always requires additional input)

**Bad:** Properties… (this is a location, not an action)


## Window titles
Give every window a distinctive title briefly describing its visible content. This text is shown in multiple parts of the UI where space may be limited, so keep it as short as possible while retaining distinctiveness. Don't include the app's vendor or version number.

**Good:** Inbox - konqi@kde.org

**Good:** Stairway To Heaven, by Led Zeppelin

**Bad:** AppName 5.3.9 Professional Edition, by SquidSoft™

**Bad:** Main Window

Avoid showing file paths, which can be long and hard to parse. In a tab-based app that can have multiple files open, disambiguate identically-named files only by their parent folder names, like this:

```
CMakeLists.txt - library
CMakeLists.txt - app
```

For dialog titles, describe the action being performed starting with an imperative mood verb, just like button and menu item labels. If the dialog was opened from a button or menu item, echo its label in the dialog title.

**Good:** Save… -> Save File

**Good:** Properties -> Properties for \[file name\]

**Bad:** Load… -> Open File

**Bad:** About \[app name\]-> Details


## Line length
For multi-sentence text, try to limit line length to 85 characters or less, which improves readability. This generally works out to about 450px. However if this would cause excessive whitespace in wide windows, consider changing the UI to lay out additional elements to the right of the text area, or even move the long text into a [Kirigami.ContextualHelpButton](https://api.kde.org/frameworks/kirigami/html/classContextualHelpButton.html) or [KWidgetsAddons::KContextualHelpButton](https://api.kde.org/frameworks/kwidgetsaddons/html/classKContextualHelpButton.html), which enforces this length internally.


## Placeholders
Placeholder text is used in empty text fields and empty views. Both share a common purpose: to tell users how to get content into it.

For placeholder messages in empty views, use [Kirigami.PlaceholderMessage](https://develop.kde.org/docs/getting-started/kirigami/components-scrollablepages_listviews/#placeholdermessage).

In empty text fields, use the following rules:

- If the text field has an explanatory label to the left of it, write the placeholder text as an example of the sort of text the user is expected to type into it. Placeholder text can be omitted if this is not relevant.
- Otherwise, write the placeholder text as a very short sentence starting with an imperative mood verb that describes what the user should do: “Search”, “Enter file name”, etc.
- Don't end with an ellipsis character, as it would contradict the meaning of the character in the context of buttons and menu items.

For search fields, use [Kirigami.SearchField](https://api.kde.org/frameworks/kirigami/html/classSearchField.html) which includes standard placeholder text.


## Translation
Many or even most users won't be using your software in English, so keep translatability in mind:

- Don't use internet memes or culture-specific colloquialisms, expressions, and references.
- Respect system-wide locale settings for units, date and time formats, etc.
- Leave enough room in your UI for strings to become 50% longer or more when translated into languages with longer text than English.
- Use the [i18nc()](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#good_ctxt) function to provide translation context to your strings, and use [KUIT markup](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#kuit_tags) instead of HTML.
- Use the [i18ncp()](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#gen_usage) function for any text that refers to a number, as plurals are handled differently in different languages.
- Test your app in right-to-left mode by running it in Arabic with `LANGUAGE=ar_AR [app_executable]`. Even if you can't read the words, make sure everything has reversed properly and there's enough room for the text.


## Brand names
Each app's name is automatically a brand name; Craft it carefully!

- Choose something catchy, easy to remember, and fun-sounding. Avoid negative language.
- Use only a single word, preferably one related to the app's purpose—even just tangentially.
- Don't simply add a “K” onto the beginning of an existing word. It's acceptable to choose a brand name with a K inside it, or even replace a “C” with a “K” (e.g. Falkon, DigiKam), but don't force it. Not all KDE brand names need to include a K (e.g. Dolphin, Plasma, NeoChat).
- Don't use common words like “Files” or “Photos.” If your brand name is too generic, its identity will be diluted and users will have a hard time finding it in web searches or describing it to others. It will also be difficult to distinguish from GNOME apps also installed on the system that have similar generic names.


## Symbols
Use appropriate Unicode symbols rather than handmade approximations. This makes the text of your app look nicer and more professional, easier to translate, and more comprehensible when read by a screen reader. For example:

- `…` (`U+2026`) instead of `...` anywhere ellipses are used
- `→` (`U+2192`) instead of `->`
- `÷` (`U+00F7`) and `×` (`U+00D7`) instead of `/` and `x` in mathematical expressions
- `“` (`U+201C`) and `”` (`U+201D`) instead of `"` for quotations
- `’` (`U+2019`) instead of `'` for apostrophes
- ` — ` (`U+2014`) instead of `-`, ` - `, or `--` for [interjections](https://www.merriam-webster.com/grammar/em-dash-en-dash-how-to-use).
- `&` (`U+0026`) instead of the word “and” to join sets of exactly two items, e.g. “Input & Output”

KDE's [KCharSelect](https://apps.kde.org/kcharselect) app can be used to find these and other symbols.