import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'address_book.g.dart';

class AddressBook {
  final items = <AddressBookItem>[];

  static AddressBook fromJson(String jsonString) {
    // This JSON structure has an array at its root, which is not currently implicitly supported by json_serializable.
    // https://github.com/google/json_serializable.dart/issues/648

    final jsonDecodedList = jsonDecode(jsonString) as List;
    final ret = AddressBook();
    ret.items.addAll(jsonDecodedList.map((m) => AddressBookItem.fromJson(m)));
    return ret;
  }
}

// Serializable members must be explicitly marked with [JsonKey]
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class AddressBookItem {
  @JsonKey(name: 'EmailLower')
  String emailLower;
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'TenantMemberID')
  String tenantMemberID;
  @JsonKey(name: 'RoleID')
  String roleID;
  @JsonKey(name: 'FieldID')
  String fieldID;
  @JsonKey(name: 'FormTemplateID')
  String formTemplateID;
  @JsonKey(name: 'FormTemplateName')
  String formTemplateName;
  @JsonKey(name: 'FormTemplateFieldID')
  String formTemplateFieldID;

  AddressBookItem();

  /// A necessary factory constructor for creating a new AddressBookItem instance
  /// from a map. Pass the map to the generated `_$AddressBookItemFromJson()` constructor.
  /// The constructor is named after the source class, in this case, AddressBookItem.
  factory AddressBookItem.fromJson(Map<String, dynamic> json) => _$AddressBookItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CameraPreferencesToJson`.
  Map<String, dynamic> toJson() => _$AddressBookItemToJson(this);
}
