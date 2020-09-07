template<typename T, typename TEnum>
class QDBusEnumMarshal;

template<typename T>
class QDBusEnumMarshal<T, boost::true_type>
{
public:
	static QDBusArgument& marshal(QDBusArgument &argument, const T& source)
	{
		argument.beginStructure();
		argument << static_cast<int>(source);
		argument.endStructure();
		return argument;
	}

	static const QDBusArgument& unmarshal(const QDBusArgument &argument, T &source)
	{
		int a;
		argument.beginStructure();
		argument >> a;
		argument.endStructure();
	
		source = static_cast<T>(a);
	
		return argument;
	}
}
