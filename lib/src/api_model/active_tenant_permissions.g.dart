// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_tenant_permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveTenantPermissions _$ActiveTenantPermissionsFromJson(
    Map<String, dynamic> json) {
  return ActiveTenantPermissions()
    ..organizationID = json['OrganizationID'] as String?
    ..organizationName = json['OrganizationName'] as String?
    ..tenantID = json['TenantID'] as String?
    ..tenantName = json['TenantName'] as String?
    ..tenantMemberID = json['TenantMemberID'] as String?
    ..userID = json['UserID'] as String?
    ..userName = json['UserName'] as String?
    ..userEmail = json['UserEmail'] as String?
    ..disabled = json['Disabled'] as bool?
    ..isAdmin = json['IsAdmin'] as bool?;
}

Map<String, dynamic> _$ActiveTenantPermissionsToJson(
    ActiveTenantPermissions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('TenantName', instance.tenantName);
  writeNotNull('TenantMemberID', instance.tenantMemberID);
  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsAdmin', instance.isAdmin);
  return val;
}
