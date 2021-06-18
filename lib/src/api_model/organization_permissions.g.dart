// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationPermissions _$OrganizationPermissionsFromJson(
    Map<String, dynamic> json) {
  return OrganizationPermissions()
    ..organizationID = json['OrganizationID'] as String?
    ..organizationName = json['OrganizationName'] as String?
    ..userID = json['UserID'] as String?
    ..userName = json['UserName'] as String?
    ..userEmail = json['UserEmail'] as String?
    ..isAdmin = json['IsAdmin'] as bool?;
}

Map<String, dynamic> _$OrganizationPermissionsToJson(
    OrganizationPermissions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('IsAdmin', instance.isAdmin);
  return val;
}
