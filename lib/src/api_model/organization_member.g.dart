// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationMember _$OrganizationMemberFromJson(Map<String, dynamic> json) => OrganizationMember()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..organizationID = json['OrganizationID'] as String?
  ..organizationName = json['OrganizationName'] as String?
  ..userID = json['UserID'] as String?
  ..userName = json['UserName'] as String?
  ..userNameLower = json['UserNameLower'] as String?
  ..userEmail = json['UserEmail'] as String?
  ..disabled = json['Disabled'] as bool?
  ..isReadOnly = json['IsReadOnly'] as bool?
  ..isAdmin = json['IsAdmin'] as bool?;

Map<String, dynamic> _$OrganizationMemberToJson(OrganizationMember instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserNameLower', instance.userNameLower);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsReadOnly', instance.isReadOnly);
  writeNotNull('IsAdmin', instance.isAdmin);
  return val;
}
