import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serialization/serializers.dart';

part 'address_book.g.dart';

class AddressBook {
  final items = <AddressBookItem>[];

  static AddressBook fromJson(String jsonString) {
    // This JSON structure has an array at its root, which is not currently implicitly supported by built_value.
    // https://github.com/google/built_value.dart/issues/565

    final jsonDecoded = jsonDecode(jsonString);
    final itemsTemp = deserializeListOf<AddressBookItem>(jsonDecoded);

    final ab = AddressBook();
    ab.items.addAll(itemsTemp);
    return ab;
  }
}

abstract class AddressBookItem implements Built<AddressBookItem, AddressBookItemBuilder> {
  AddressBookItem._();

  factory AddressBookItem([Function(AddressBookItemBuilder b) updates]) = _$AddressBookItem;

  @BuiltValueField(wireName: 'EmailLower')
  String get emailLower;
  @BuiltValueField(wireName: 'Name')
  String get name;
  @BuiltValueField(wireName: 'TenantMemberID')
  String get tenantMemberID;
  @BuiltValueField(wireName: 'RoleID')
  String get roleID;
  @BuiltValueField(wireName: 'FieldID')
  String get fieldID;
  @BuiltValueField(wireName: 'FormTemplateID')
  String get formTemplateID;
  @BuiltValueField(wireName: 'FormTemplateName')
  String get formTemplateName;
  @BuiltValueField(wireName: 'FormTemplateFieldID')
  String get formTemplateFieldID;
  String toJson() {
    return json.encode(standardSerializers.serializeWith(AddressBookItem.serializer, this));
  }

  static AddressBookItem fromJson(String jsonString) {
    return standardSerializers.deserializeWith(AddressBookItem.serializer, json.decode(jsonString));
  }

  static Serializer<AddressBookItem> get serializer => _$addressBookItemSerializer;
}
