// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrganization _$UserOrganizationFromJson(Map<String, dynamic> json) =>
    UserOrganization()
      ..userEmail = json['UserEmail'] as String?
      ..organizationID = json['OrganizationID'] as String?
      ..organizationName = json['OrganizationName'] as String?
      ..assignmentTypes = (json['AssignmentTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..hasAssignment = json['HasAssignment'] as bool?
      ..isOrganizationMember = json['IsOrganizationMember'] as bool?;

Map<String, dynamic> _$UserOrganizationToJson(UserOrganization instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('AssignmentTypes', instance.assignmentTypes);
  writeNotNull('HasAssignment', instance.hasAssignment);
  writeNotNull('IsOrganizationMember', instance.isOrganizationMember);
  return val;
}
