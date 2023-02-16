// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationProject _$OrganizationProjectFromJson(Map<String, dynamic> json) =>
    OrganizationProject()
      ..id = json['ID'] as String?
      ..organizationID = json['OrganizationID'] as String?
      ..accessType = json['AccessType'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..createdByUserID = json['CreatedByUserID'] as String?
      ..createdByUserEmail = json['CreatedByUserEmail'] as String?
      ..createdByUserName = json['CreatedByUserName'] as String?
      ..name = json['Name'] as String?
      ..nameLower = json['NameLower'] as String?
      ..disabled = json['Disabled'] as bool?
      ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
      ..purgeMarkedOn = json['PurgeMarkedOn'] as String?
      ..purgeMarkedByUserID = json['PurgeMarkedByUserID'] as String?
      ..purgeMarkedByUserName = json['PurgeMarkedByUserName'] as String?
      ..purgeMarkedByUserEmail = json['PurgeMarkedByUserEmail'] as String?;

Map<String, dynamic> _$OrganizationProjectToJson(OrganizationProject instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('AccessType', instance.accessType);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('PurgeMarkedOn', instance.purgeMarkedOn);
  writeNotNull('PurgeMarkedByUserID', instance.purgeMarkedByUserID);
  writeNotNull('PurgeMarkedByUserName', instance.purgeMarkedByUserName);
  writeNotNull('PurgeMarkedByUserEmail', instance.purgeMarkedByUserEmail);
  return val;
}

OrganizationProjectCollection _$OrganizationProjectCollectionFromJson(Map<String, dynamic> json) =>
    OrganizationProjectCollection()
      ..projects = (json['Projects'] as List<dynamic>?)
          ?.map((e) => OrganizationProject.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OrganizationProjectCollectionToJson(OrganizationProjectCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Projects', instance.projects);
  return val;
}
