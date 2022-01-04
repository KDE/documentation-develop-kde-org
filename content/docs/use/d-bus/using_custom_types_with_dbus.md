---
title: Using Custom Types with D-Bus
linkTitle: Using Custom Types with D-Bus
weight: 5
description: >
    Using custom types as arguments of D-Bus method calls.
aliases:
  - /docs/d-bus/using_custom_types_with_dbus/
---

## Write a class

Write the class you would like to publish, complete with signals, slots and properties, using custom types as you go along.

The class being published in the example is the following:

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Chat.hpp" highlight="cpp" >}}


It contains simple user management and provides the means to send a message. The Message class is the custom type in the example. It contains only a user and a text message. There is no reason why the methods in the Chat class couldn't just take 2 QString parameters, but then Qt would be able to do everything automatically and we need something irregular for this tutorial.

To show that Qt supports a lot of types right out of the box, a QStringList was used. This will become clear further on.

### Q_CLASSINFO

The `Q_CLASSINFO` declaration provides a means to specify an interface name that will be take into account by the xml tools.

Typically, the company name is included in the name, resulting in declarations like:

```
Q_CLASSINFO("D-Bus Interface", "com.firm.department.product.interface")
```

## Generate XML

Generate the xml description of the class using the qdbuscpp2xml tool provided by Qt.

If you run `qdbuscpp2xml` on the `Chat.hpp` file in the example, you will get the following output:

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/chat2xml.xml" highlight="xml" >}}

Note that this xml file contains all methods from the Chat class using standard Qt types. If you were to generate Adaptor and Interface classes based on this xml, you would be able to add and remove users, get the list of users and receive the userAdded and userRemoved signals. Even the `QStringList` type is handled automatically.

The methods dealing with the Message type, however, are not available. To generate an Adaptor and an Interface capable of dealing with the Message type, you need to modify the XML.

Tip: You may want to generate the Adaptor and Interface using only the automatically generated xml. It might be helpful to compare them to the versions we will generate further on.


## Edit the XML

The `qdbusxml2cpp` tool needs to be told about the custom types, so you need to add some type information to the XML.

This is done by specifying annotations:

```xml
<annotation name="org.qtproject.QtDBus.QtTypeName"
value="*customType*"/>
```

The syntax differs slightly depending on whether you're using it in a signal/method or in a property (the `.In0` is omitted for properties), but it is fairly straightforward. The following is an example dealing with the QRect type (it has no relation with the example):

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/qrect.xml" highlight="xml" >}}


Don't worry too much about what type to specify; any type that is somewhat too complex to get marshaled/unmarshaled by default handlers will be processed using the custom type, so it really doesn't matter what type you use. You could even use `"(iiii)"` for everything.

If any of your methods returns a complex result, you need to add an annotation for `org.qtproject.QtDBus.QtTypeName.Out0` as well.

If any of your signals have arguments with complex types, again you need to add an annotation for `org.qtproject.QtDBus.QtTypeName.Out0`. For backward-compatibility with Qt < 5.6.3 & 5.7.0 though you can use `org.qtproject.QtDBus.QtTypeName.In0` as with the arguments of a normal method. `qdbusxml2cpp` supports that still in later versions, but will emit a warning.
Note
The XML above uses QRects. QRect is supported by default, so the code above would be generated for you by `qdbuscpp2xml`.


The complete interface used for the Chat interface in the example is as follows:

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Chat.xml" highlight="xml" >}}


## Generate Adaptor and Interface classes

Now that the XML contains all the information `qdbusxml2cpp` needs, it's time to generate the Adaptor and Interface classes.

Since custom types are involved, you will need to specify some extra includes, so the Adaptor and Interface classes can find all the type information.

For the DBusChat example, the Adaptor and Interface classes were created by calling

```bash
qdbusxml2cpp Chat.xml -i Message.hpp -a ChatAdaptor
qdbusxml2cpp Chat.xml -i Message.hpp -p ChatInterface
```

## Qt Meta object magic

Even though we now have an Adaptor to wrap an object and an Interface to talk to it, you will not be able to compile them as some extra things are necessary for the Qt Meta object system to be able to process the custom type.

### Register the type

Declare the type as a Qt meta type by adding a

```cpp
 Q_DECLARE_METATYPE
```
 
statement to the header file containing

your custom type definition.

Add `qRegisterMetaType` and `qDBusRegisterMetaType` calls to enable the framework to work with the custom type.

In the example's Message class, a static method is included to do this

```cpp
void Message::registerMetaType()
{
    qRegisterMetaType<Message>("Message");
    qDBusRegisterMetaType<Message>();
}
```

Important: You need to register the type both in the application publishing the object and in the application using it, since both applications need to be able to handle the custom type.
Also take care to register the custom types before calling methods on the Adaptor/Interface that need them.
Qt will show error output if you are using types it cannot (yet) handle, but you should be aware of it nonetheless.

### Provide QDBusArgument streaming operators

When a DBus call is executed that uses a custom type, the Qt framework will need to marshal (serialize) or unmarshal (unserialize) the instance.

This is done by using the QDBusArgument stream operators, so you will need to implement those operators for your custom types, as explained here.

For the Message type from the example, these operators are very simple, since it only contains 2 strings:

```cpp
QDBusArgument &operator<<(QDBusArgument &argument, const Message& message)
{
    argument.beginStructure();
    argument << message.m_user;
    argument << message.m_text;
    argument.endStructure();

    return argument;
}

const QDBusArgument &operator>>(const QDBusArgument &argument, Message &message)
{
    argument.beginStructure();
    argument >> message.m_user;
    argument >> message.m_text;
    argument.endStructure();

    return argument;
}
```

`QDBusArgument` provides functions to handle much more complex types as well.

## Use the adaptor and interface classes

You are now ready to start using the Adaptor and Interface classes and have your custom type handled automatically.

### Publishing an object using an Adaptor

To publish an object, you should instantiate an Adaptor for it and then register the object with the DBus you are using.

This is the code that publishes a Chat object in the DBusChat example:

```cpp
Chat* pChat = new Chat(&a);
ChatAdaptor* pChatAdaptor = new ChatAdaptor(pChat);

if (!connection.registerService(CHAT_SERVICE))
{
    qFatal("Could not register service!");
}

if (!connection.registerObject(CHAT_PATH, pChat))
{
    qFatal("Could not register Chat object!");
}
```

The ChatAdaptor instance will process any incoming DBus requests for the Chat object. When a method is invoked, it will call the matching slot on the Chat object. When the Chat object emits a signal, the ChatAdaptor will transmit it across DBus.

### Talking to a remote object using an Interface

To talk to a remote object, you need only instantiate the matching Interface and pass the correct service name and object path.

In the DBusChat example, a connection is made with a remote Chat object like this:

```cpp
demo::Chat chatInterface(CHAT_SERVICE, CHAT_PATH, connection);
```

### Using the remote object in your application

Once you have an instance of the Interface class, you should be able to interact with the remote object like you would with any other QObject.

The ChatWindow class in the DBusChat example, for instance, adds a user simply by calling

```cpp
m_chatInterface.addUser(m_userName);
```

Furthermore, ChatWindow is able to respond to signals emitted by the Chat object by connecting to its Interface class just like with any other QObject:

```cpp
connect(&m_chatInterface, SIGNAL(userAdded(QString)), SLOT(chat_userAdded(QString)));
connect(&m_chatInterface, SIGNAL(userRemoved(QString)), SLOT(chat_userRemoved(QString)));
connect(&m_chatInterface, SIGNAL(messageSent(Message)), SLOT(chat_messageSent(Message)));
```

## Varia
### Automation

We're not too wild about having to do some of this stuff manually, but using the Adaptors and Interfaces is much more convenient than writing code that manually constructs dbus calls and processes the replies.

One might hope qdbuscpp2xml and qdbusxml2cpp will be extended to support custom types by analyzing an entire code tree instead of just the header files passed to them, so they would be able to recognize the custom types and add methods/signals/properties to the XML accordingly. One potential strategy for extending qdbuscpp2xml is with plugins, and this is presented at Cpp2XmlPlugins.

Alternatively, a feature could be added to Qt Creator to support the kind of solution presented here in a automated fashion. Since Qt Creator already needs to be aware of custom types used in a project, this might be more feasible (or at least easier) than modifying the qdbus tools.

### Adventurous serialization of enumerations

If you happen to use a lot of enumerations and you need them to be exported across DBus, you will likely end up with QDBusArgument stream operators for every enumeration. A basic implementation could simply cast the enum to and from an int, resulting in code looking like this:

```cpp
QDBusArgument &operator<<(QDBusArgument &argument, const EnumerationType& source)
{
    argument.beginStructure();
    argument << static_cast<int>(source);
    argument.endStructure();
    return argument;
}

const QDBusArgument &operator>>(const QDBusArgument &argument, EnumerationType &dest)
{
    int a;
    argument.beginStructure();
    argument >> a;
    argument.endStructure();
    dest = static_cast<EnumerationType>(a);
    return argument;
}
```

You will notice that this code will be much the same for all enumerations. The only part that will differ is the "EnumerationType".

Thankfully, C++ knows how to handle templates, so we should be able to write just the one template-based implementation. However, we need that one implementation to handle only enumeration types, not the other custom types we want to send across DBus. Otherwise, any custom type would be cast from and to an integer value, which is probably not what you want for all types, especially not for complex ones.

This is where modern C++ Standard Library comes to our aid. With some magic, it supports conditionals within template definitions.

That way, we can provide `QDBusArgument` marshaling and unmarshalling implementations that will be used only in situations when such a conditional is true.

This is what the marshaling and unmarshalling code actually looks like:

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/marshaling.cpp" highlight="cpp" >}}

The marshal implementation can now be called by invoking:

```cpp
QDBusEnumMarshal<T, typename std::is_enum<T>::type>::marshal(argument, source);
```

with `T` being the type we want to marshal.

Some further glue code is needed to link the implementation to the QDbusArgument stream operators:

```cpp
template<typename T>
QDBusArgument& operator<<(QDBusArgument &argument, const T& source)
{
    return QDBusEnumMarshal<T, typename std::is_enum<T>::type>::marshal(argument, source);
}

template<typename T>
const QDBusArgument& operator>>(const QDBusArgument &argument, T &source)
{
    return QDBusEnumMarshal<T, typename std::is_enum<T>::type>::unmarshal(argument, source);
}
```


Put all that in a header file and include it where you declare the enumerations that need to pass across DBus. The compiler is now able to find the streaming operators all on its own.

You do still need to declare the enumeration as a metatype and register it with the Qt meta object system though.


#### enumDBus.hpp

This is the entire header file needed to marshal / unmarshal any enumeration:

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/enumDBus.hpp" highlight="cpp" >}}


## Example

This section contains the sources for the chat example. The wiki does not allow the upload of files other than images, so they've been posted as text.

Chat is the interface being published. ChatAdaptor and ChatInterface were generated using Chat.xml.

Put all these files in a directory and run

```bash
mkdir build
pushd build
cmake ../ -G Ninja
ninja
./dbuschat
```

### Chat.hpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Chat.hpp" highlight="cpp" >}}

### Chat.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Chat.cpp" highlight="cpp" >}}

### Chat.xml

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Chat.xml" highlight="cpp" >}}

### ChatAdaptor.h

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatAdaptor.h" highlight="cpp" >}}

### ChatAdaptor.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatAdaptor.cpp" highlight="cpp" >}}

### ChatInterface.h

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatInterface.h" highlight="cpp" >}}

### ChatInterface.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatInterface.cpp" highlight="cpp" >}}

### ChatWindow.hpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatWindow.hpp" highlight="cpp" >}}

### ChatWindow.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatWindow.cpp" highlight="cpp" >}}

### ChatWindow.ui

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/ChatWindow.ui" highlight="xml" >}}

### Message.hpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Message.hpp" highlight="cpp" >}}

### Message.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/Message.cpp" highlight="cpp" >}}

### main.cpp

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/main.cpp" highlight="cpp" >}}

### CMakeLists.txt

{{< readfile file="/content/docs/use/d-bus/using_custom_types_with_dbus/CMakeLists.txt" highlight="cpp" >}}
