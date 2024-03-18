---
title: Common programming mistakes
weight: 5
description: >
  Common programming mistakes to avoid
group: "getting-started"
---

## Abstract

This tutorial aims to combine the experience of KDE developers
regarding Qt and KDE frameworks dos and don'ts. Besides actual mistakes, it
also covers things that are not necessarily "bugs" but which make the code
either slower or less readable.

## General C++

This section guides you through some of the more dusty corners of C++ which
either tend to be misused or which people often simply get wrong.

### Anonymous namespaces vs statics

If you have a method in a class that does not access any members and therefore
does not need an object to operate, make it static. If additionally, it is a
private helper function that is not needed outside of the file, make it a
file-static function. That hides the symbol completely.

Symbols defined in a C++ anonymous namespace do not have internal linkage.
Anonymous namespaces only give a unique name for that translation unit and that
is it; they do not change the linkage of the symbol at all. Linkage is not
changed on those because the second phase of two-phase name lookup ignores
functions with internal linkages. Also, entities with internal linkage cannot
be used as template arguments. 

So for now instead of using anonymous namespaces use static if you do not want
a symbol to be exported.

### nullptr pointer issues

First and foremost: it is fine to delete a null pointer. So constructs like
this that check for null before deleting are simply redundant: 

```cpp
if (ptr) {
    delete ptr;
}
```

When you delete a pointer, make sure you also set it to 0 so that future
attempts to delete that object will not fail in a double delete. So the
complete and proper idiom is: 

```cpp
delete ptr;
ptr = nullptr;
```

You may notice that null pointers are marked variously in one of four ways: 0,
0L, NULL and nullptr. In C, NULL is defined as a null void pointer. In C++,
more type safety is possible due to stricter type checking.  Modern C++11
implementations (and all C++14 implementations) define NULL to equal the
special value nullptr. Nullptr can be automatically cast to boolean false, but
a cast to an integer type will fail.  This is useful to avoid accidentally.
Older C++ implementations before c++11 simply defined NULL to 0L or 0, which
provides no additional type safety - one could assign it to an integer
variable, which is obviously wrong. For code which does not need to support
outdated compilers the best choice is nullptr.

In pointer context, the integer constant zero means "null pointer" -
irrespective of the actual binary representation of a null pointer. Note,
however, that if you want to pass a null pointer constant to a function in a
variable argument list, you *must* explicitly cast it to a pointer - the
compiler assumes integer context by default, which might or might not match the
binary representation of a pointer.

### Member variables

You will encounter four major styles of marking class member variables in KDE,
besides unmarked members:

* *m_variable* lowercase m, underscore and the name of the variable
  starting with a lowercase letter. This is the most common style and one
  preferred for code in kdelibs.

* *mVariable* lowercase m and the name of variable starting with an
  uppercase letter

* *variable_* variable name starting with a lowercase letter and then an
  underscore

* *_variable* underscore and the name of variable starting with a lowercase
  letter. This style is actually usually frowned upon as this notation is also
  used in some code for function parameters instead.

Unmarked members are more common in the case of classes that use
[d-pointers](https://community.kde.org/Policies/Library_Code_Policy#D-Pointers).

As it often happens there is no one correct way of doing it, so remember to
always follow the syntax used by the application/library to which you are
committing. If you're creating a new file, you may want to follow the coding
style of the library or module you're adding the file to.

Note that symbols starting with undercores are reserved to the C library
(underscore followed by capital or double underscore are reserved to the
compiler), so if you can, avoid using the last type.

### Static variables

Try to limit the number of static variables used in your code, especially when
committing to a library. Construction and initialization of a large number of
static variables really hurts the startup times.

Do not use class-static variables, especially not in libraries and loadable
modules though it is even discouraged in applications. Static objects lead to
lots of problems such as hard to debug crashes due to undefined order of
construction/destruction.

Instead, use a static pointer, together with `G_GLOBAL_STATIC` which is defined
in `<QGlobalStatic>` and is used like this:

```cpp
class A { ... };

G_GLOBAL_STATIC(A, globalA)

void doSomething()
{
    A *a = globalA;
    ...
}

void doSomethingElse() {
    if (globalA.isDestroyed()) {
        return;
    }
    A *a = globalA;
    ...
}

void installPostRoutine() {
    qAddPostRoutine(globalA.destroy);
}
```

See the [API documentation](https://doc.qt.io/qt-6/qglobalstatic.html) for
`G_GLOBAL_STATIC` for more information.

### Constant data

If you need some constant data of simple data types in several
places, you do good by defining it once at a central place, to avoid a mistype
in one of the instances. If the data changes there is also only one place you
need to edit.

Even if there is only one instance you do good by defining it elsewhere, to
avoid so-called "magic numbers" in the code which are unexplained (cmp. 42).
Usually this is done at the top of a file to avoid searching for it.

Define the constant data using the language constructs of C++, not the
preprocessor instructions, like you may be used to from plain C. This way the
compiler can help you to find mistakes by doing type checking.

```cpp
// Correct!
static constexpr int AnswerToAllQuestions = 42;

// Wrong!
#define AnswerToAllQuestions 42 ```
```

If defining a constant array do not use a pointer as data type. Instead use the
data type and append the array symbol with undefined length, `[]`, behind the
name. Otherwise you also define a variable to some const data. That variable
could mistakenly be assigned a new pointer to, without the compiler complaining
about. And accessing the array would have one indirection, because first the
value of the variable needs to be read.

```cpp
// Correct!
static const char SomeString[] = "Example";

// Wrong!
static const char* SomeString = "Example";

// Wrong!
#define SomeString "Example"
```

### Forward Declarations

You will reduce compile times by forward declaring classes when possible
instead of including their respective headers. The rules for when a type can be
used without being defined are a bit subtle, but intuitively, if the only
important aspect is the name of the class, not the details of its
implementation, a forward declaration is permissible. Two examples are when
declaring pointers to the class or using the class as a function argument.  

For example: 

```cpp
#include <QWidget>     // slow
#include <QStringList> // slow
#include <QString>     // slow
#include <QIcon>       // slow

class SomeClass
{
public:
    virtual void widgetAction(QWidget *widget) = 0;
    virtual void stringAction(const QString &str) = 0;
    virtual void stringListAction(const QStringList &strList) = 0;
private:
    QIcon *icon = nullptr;
};
```  

The above should instead be written like this:

```cpp
class QWidget;     // fast
class QStringList; // fast
class QString;     // fast
class QIcon;       // fast

class SomeClass
{
public:
    virtual void widgetAction(QWidget *widget) = 0;
    virtual void stringAction(const QString &str ) = 0;
    virtual void stringListAction( const QStringList& strList ) = 0;
private:
    QIcon *icon = nullptr;
};
```

## Iterators

### Prefer const iterators and cache end()

Prefer to use `const_iterators` over normal iterators when possible.
Containers, which are being implicitly shared often detach when a call to a
non-const `begin()` or `end()` methods is made ([QList](https://doc.qt.io/qt-6/qlist.html) is an example of
such a container). When using a const_iterator also watch out that you are
really calling the const version of `begin()` and `end()`. Unless your
container is actually const itself this probably will not be the case, possibly
causing an unnecessary detach of your container. So basically whenever you use
const_iterator initialize them using `constBegin()`/`constEnd()` instead, to be
on the safe side. 

Cache the return of the `end()` (or `constEnd()`) method call before doing
iteration over large containers. For example:

```cpp
QList<SomeClass> container;

// code which inserts a large number of elements to the container

QList<SomeClass>::ConstIterator end = container.constEnd();
QList<SomeClass>::ConstIterator itr = container.constBegin();

for (; itr != end; ++itr ) {
    // use *itr (or itr.value()) here
}
```

This avoids the unnecessary creation of the temporary `end()` (or `constEnd()`)
return object on each loop iteration, largely speeding it up.

When using iterators, always use pre-increment and pre-decrement operators
(i.e., `++itr`) unless you have a specific reason not to. The use of
post-increment and post-decrement operators (i.e., `itr++`) cause the creation
of a temporary object.

### Take care when erasing elements inside a loop

When you want to erase some elements from the list, you maybe would use code
similar to this:

```cpp
QMap<int, Job *>::iterator it = m_activeTimers.begin();
QMap<int, Job *>::iterator itEnd = m_activeTimers.end();

for(; it != itEnd ; ++it) {
    if(it.value() == job) {
        // A timer for this job has been found. Let's stop it.
        killTimer(it.key());
        m_activeTimers.erase(it);
    }
}
```

This code will potentially crash because it is a dangling iterator after the
call to erase(). You have to rewrite the code this way:

```cpp
QMap<int, Job *>::iterator it = m_activeTimers.begin();
while (it != m_activeTimers.end()) {
    if(it.value() == job) {
        // A timer for this job has been found. Let's stop it.
        killTimer(it.key());
        it = m_activeTimers.erase(it);
        continue;
    }
    ++it;
}
```

This problem is also discussed in the [ Qt documentation for QMap::iterator](https://doc.qt.io/qt-5/qmap-iterator.html#details)
but applies to **all** Qt iterators

## memory leaks

A very "popular" programming mistake is to do a `new` without a `delete` like
in this program:

'''mem_gourmet.cpp'''
```cpp
class t {
public:
    t() {}
};

void pollute() {
    t* polluter = new t();
}

int main() {
    while (true) {
        pollute();
    }
}
```

You see, `pollute()` instantiates a new object `polluter` of the class
`t`. Then, the variable `polluter` is lost because it is local, but the
content (the object) stays on the heap. I could use this program to render my
computer unusable within 10 seconds.

To solve this, there are the following approaches:

* keep the variable on the stack instead of the heap:

```cpp
t* polluter = new t();
```

would become

```cpp
t polluter;
```

* delete polluter using the complementing function to new:

```cpp
delete polluter;
```

* stop the polluter in an [unique_ptr](http://en.cppreference.com/w/cpp/memory/unique_ptr)
  (which will automatically delete the polluter when returning from the method)

```cpp
std::unique_ptr<t> polluter = std::make_unique<t>();
```

There's also std::shared_ptr and QSharedPointer. This is the generally
preferred way to do it in modern C++; explicit memory management should be
avoided when possible.

Qt code involving QObject generally uses parent/child relations to free
allocated memory; when constructing a QObject (e.g. a widget) it can be given a
parent, and when the parent is deleted it deletes all its children. The parent
is also set when you add a widget to a layout, for example.

A tool to detect memory leaks like this is [Valgrind](https://community.kde.org/Guidelines_and_HOWTOs/Debugging/Valgrind).

## dynamic_cast

You can only dynamic_cast to type T from type T2 provided that:

* T is defined in a library you link to (you'd get a linker error if this isn't
  the case, since it won't find the vtable or RTTI info)

* T is "well-anchored" in that library. By "well-anchored" I mean that the
  vtable is not a COMMON symbol subject to merging at run-time by the dynamic
  linker. In other words, the first virtual member in the class definition must
  exist and not be inlined: it must be in a .cpp file.

* T and T2 are exported

For instance, we've seen some hard-to-track problems in non-KDE C++ code we're
linking with (I think NMM) because of that. It happened that:

* libphonon loads the NMM plugin

* NMM plugin links to NMM

* NMM loads its own plugins

* NMM's own plugins link to NMM

Some classes in the NMM library did not have well-anchored vtables, so
dynamic_casting failed inside the Phonon NMM plugin for objects created in the
NMM's own plugins.

## Program Design

In this section we will go over some common problems related to the design of
Qt/KDE applications.

## Delayed Initialization

{{< alert title="Important!" color="warning">}}
This part is outdated and need an helpful hand to update it.
{{< /alert >}}

Although the design of modern C++ applications can be
very complex, application windows can be loaded and displayed to the user very
quickly through the technique of [http://www.kdedevelopers.org/node/509 delayed
initialization].  This technique is relatively straightforward and useful at
all stages of an interactive program.

First, let us look at the standard way of initializing a KDE application: 

```cpp

int main(int argc, char **argv) {
    ....

    QApplication app;

    KCmdLineArgs *args = KCmdLineArgs::parsedArgs();

    auto window = new MainWindow(args);

    app.setMainWidget(window);
    window->show();

    return app.exec();
}
```

Notice that `window` is created before the `a.exec()` call that starts the
event loop. This implies that we want to avoid doing anything non-trivial in
the top-level constructor, since it runs before we can even show the window.

The solution is simple: we need to delay the construction of anything besides
the GUI until after the event loop has started. Here is how the example class
MainWindow's constructor could look to achieve this:

```cpp

MainWindow::MainWindow()
{
    initGUI();
    QTimer::singleShot(nullptr, this, &MainWindow::initObject);
}

void MainWindow::initGUI()
{
    /* Construct your widgets here.  Note that the widgets you
     * construct here shouldn't require complex initialization
     * either, or you've defeated the purpose.
     * All you want to do is create your GUI objects and
     * QObject::connect
     * the appropriate signals to their slots. */
}

void MainWindow::initObject() {
    /* This slot will be called as soon as the event loop starts.
     * Put everything else that needs to be done, including
     * restoring values, reading files, session restoring, etc here.
     * It will still take time, but at least your window will be
     * on the screen, making your app look active. */
}
```
   
Using this technique may not buy you any overall time, but it makes your app
**seem** quicker to the user who is starting it. This increased perceived
responsiveness is reassuring for the user as they get quick feedback that the
action of launching the app has succeeded.

When (and only when) the start up can not be made reasonably fast enough,
consider using a [QSplashScreen](https://doc.qt.io/qt-6/qsplashscreen.html).

## Data Structures

In this section we will go over some of our most common pet-peeves which affect
data structures very commonly seen in Qt/KDE applications.

### Passing non-POD types

Non-POD ("plain old data") types should be passed by
const reference if at all possible. This includes anything other than the basic
types such as `char` and `int`.

Take, for instance, [QString](https://doc.qt.io/qt-6/qstring.html). They should always be passed into methods
as `const [QString](https://doc.qt.io/qt-6/qstring.html)&`. Even though {{qt|QString}} is implicitly shared it
is still more efficient (and safer) to pass const references as opposed to
objects by value. 

So the canonical signature of a method taking QString arguments is:

```cpp
void myMethod(const QString &foo, const QString &bar);
```

### QObject

If you ever need to delete a QObject derived class from within one
of its own methods, do not ever delete it this way: 

```cpp
delete this;
```

This will sooner or later cause a crash because a method on that object might
be invoked from the Qt event loop via slots/signals after you deleted it.

Instead always use
[QObject::deleteLater](https://doc.qt.io/qt-6/qobject.html#deleteLater) which
tries to do the same thing as `delete this` but in a safer way.

### Empty QStrings

It is common to want to see if a [QString](https://doc.qt.io/qt-6/qstring.html)
is empty. Here are three ways of doing it, the first two of which are correct:

```cpp
// Correct
if (mystring.isEmpty()) { }

// Correct
if (mystring == {}) { }

// Wrong! ""
if (mystring == "") { }
```

While there is a distinction between "null"
[QString](https://doc.qt.io/qt-6/qstring.html)s and empty ones, this is a
purely historical artifact and new code is discouraged from making use of it.

### QString and reading files

If you are reading in a file, it is faster to convert it from the local
encoding to Unicode ([QString](https://doc.qt.io/qt-6/qstring.html)) in one go,
rather than line by line. This means that methods like
[QIODevice::readdAll](https://doc.qt.io/qt-6/qiodevice.html#readAll) are often
a good solution, followed by a single
[QString](https://doc.qt.io/qt-6/qstring.html) instantiation.

For larger files, consider reading a block of lines and then performing the
conversion. That way you get the opportunity to update your GUI. This can be
accomplished by reentering the event loop normally, along with using a timer to
read in the blocks in the background, or by creating a local event loop. 

While one can also use `qApp->processEvents()`, it is discouraged as it easily
leads to subtle yet often fatal problems.

### QString and QByteArray

While [QString](https://doc.qt.io/qt-6/qstring.html) is the tool of choice for many
string handling situations, there is one where it is particularly inefficient.
If you are pushing about and working on data in {{qt|QByteArray}}s, take care
not to pass it through methods which take [QString](https://doc.qt.io/qt-6/qstring.html) parameters; then make
QByteArrays from them again.

For example: 

```cpp
QByteArray myData;
QString myNewData = mangleData(myData);

QString mangleData(const QString &data)
{
    QByteArray str = data.toLatin1();
    // mangle return QString(str);
}
```

The expensive thing happening here is the conversion to [QString](https://doc.qt.io/qt-6/qstring.html), which
does a conversion to Unicode internally. This is unnecessary because, the first
thing the method does is convert it back using `toLatin1()`. So if you are sure
that the Unicode conversion is not needed, try to avoid inadvertently using
QString along the way. 

The above example should instead be written as:

```cpp
QByteArray myData;
QByteArray myNewData = mangleData(myData);

QByteArray mangleData( const QByteArray& data )
```

## QDomElement

When parsing XML documents, one often needs to iterate over all
the elements. You may be tempted to use the following code for that: 

```cpp
for (QDomElement e = baseElement.firstChild().toElement(); !e.isNull(); e = e.nextSibling().toElement() ) {
    ...
}
```

That is not correct though: the above loop will stop prematurely when it
encounters a [QDomNode](https://doc.qt.io/qt-6/qdomnode.html) that is something other than an element such as a
comment.

The correct loop looks like: 

```cpp
for (QDomNode n = baseElement.firstChild(); !n.isNull(); n = n.nextSibling()) {
    QDomElement e = n.toElement();
    if (e.isNull()) {
        continue;
    }
    ...
}
```
