// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBookItem _$AddressBookItemFromJson(Map<String, dynamic> json) => AddressBookItem()
  ..emailLower = json['EmailLower'] as String?
  ..name = json['Name'] as String?
  ..tenantMemberID = json['TenantMemberID'] as String?
  ..roleID = json['RoleID'] as String?
  ..fieldID = json['FieldID'] as String?
  ..formTemplateID = json['FormTemplateID'] as String?
  ..formTemplateName = json['FormTemplateName'] as String?
  ..formTemplateFieldID = json['FormTemplateFieldID'] as String?;

Map<String, dynamic> _$AddressBookItemToJson(AddressBookItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('EmailLower', instance.emailLower);
  writeNotNull('Name', instance.name);
  writeNotNull('TenantMemberID', instance.tenantMemberID);
  writeNotNull('RoleID', instance.roleID);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('FormTemplateID', instance.formTemplateID);
  writeNotNull('FormTemplateName', instance.formTemplateName);
  writeNotNull('FormTemplateFieldID', instance.formTemplateFieldID);
  return val;
}
