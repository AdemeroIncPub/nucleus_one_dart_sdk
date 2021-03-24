import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:nucleus_one_dart_sdk/src/dashboard_widget.dart';

import '../address_book.dart';

part 'serializers.g.dart';

//add all of the built value types that require serialization
@SerializersFor([
  AddressBookItem,
  DashboardWidget,
])
final Serializers serializers = _$serializers;

final standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T deserialize<T>(dynamic value) =>
    standardSerializers.deserializeWith<T>(standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) =>
    BuiltList.from(value.map((value) => deserialize<T>(value)).toList(growable: false));
