// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organization_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrganizationProject _$UserOrganizationProjectFromJson(Map<String, dynamic> json) =>
    UserOrganizationProject()
      ..userEmail = json['UserEmail'] as String?
      ..organizationID = json['OrganizationID'] as String?
      ..organizationName = json['OrganizationName'] as String?
      ..projectID = json['ProjectID'] as String?
      ..projectName = json['ProjectName'] as String?
      ..projectAccessType = json['ProjectAccessType'] as String?
      ..projectIsDisabled = json['ProjectIsDisabled'] as bool?
      ..assignmentTypes =
          (json['AssignmentTypes'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..hasAssignment = json['HasAssignment'] as bool?;

Map<String, dynamic> _$UserOrganizationProjectToJson(UserOrganizationProject instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('ProjectIsDisabled', instance.projectIsDisabled);
  writeNotNull('AssignmentTypes', instance.assignmentTypes);
  writeNotNull('HasAssignment', instance.hasAssignment);
  return val;
}

UserOrganizationProjectCollection _$UserOrganizationProjectCollectionFromJson(
        Map<String, dynamic> json) =>
    UserOrganizationProjectCollection()
      ..userOrganizationProjects = (json['UserOrganizationProjects'] as List<dynamic>?)
          ?.map((e) => UserOrganizationProject.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UserOrganizationProjectCollectionToJson(
    UserOrganizationProjectCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserOrganizationProjects', instance.userOrganizationProjects);
  return val;
}
