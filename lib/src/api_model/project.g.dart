// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMember _$ProjectMemberFromJson(Map<String, dynamic> json) => ProjectMember()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..organizationMemberID = json['OrganizationMemberID'] as String?
  ..organizationMemberIsAdmin = json['OrganizationMemberIsAdmin'] as bool?
  ..organizationID = json['OrganizationID'] as String?
  ..organizationName = json['OrganizationName'] as String?
  ..projectID = json['ProjectID'] as String?
  ..projectName = json['ProjectName'] as String?
  ..projectIsDisabled = json['ProjectIsDisabled'] as bool?
  ..projectAccessType = json['ProjectAccessType'] as String?
  ..userID = json['UserID'] as String?
  ..userName = json['UserName'] as String?
  ..userNameLower = json['UserNameLower'] as String?
  ..userEmail = json['UserEmail'] as String?
  ..disabled = json['Disabled'] as bool?
  ..isReadOnly = json['IsReadOnly'] as bool?
  ..isAdmin = json['IsAdmin'] as bool?;

Map<String, dynamic> _$ProjectMemberToJson(ProjectMember instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('OrganizationMemberID', instance.organizationMemberID);
  writeNotNull('OrganizationMemberIsAdmin', instance.organizationMemberIsAdmin);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectIsDisabled', instance.projectIsDisabled);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserNameLower', instance.userNameLower);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsReadOnly', instance.isReadOnly);
  writeNotNull('IsAdmin', instance.isAdmin);
  return val;
}

Project _$ProjectFromJson(Map<String, dynamic> json) => Project()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..organizationID = json['OrganizationID'] as String?
  ..organizationName = json['OrganizationName'] as String?
  ..organizationNameLower = json['OrganizationNameLower'] as String?
  ..organizationSubscriptionRequired = json['OrganizationSubscriptionRequired'] as bool?
  ..organizationSubscriptionFreeUsers = json['OrganizationSubscriptionFreeUsers'] as int?
  ..organizationSubscriptionExpiration = json['OrganizationSubscriptionExpiration'] as String?
  ..bucketName = json['BucketName'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?
  ..creatingUserID = json['CreatingUserID'] as String?
  ..creatingUserName = json['CreatingUserName'] as String?
  ..creatingUserEmail = json['CreatingUserEmail'] as String?
  ..crmAccountId = json['CrmAccountId'] as String?
  ..disabled = json['Disabled'] as bool?
  ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
  ..purgeMarkedOn = json['PurgeMarkedOn'] as String?
  ..purgeMarkedByUserID = json['PurgeMarkedByUserID'] as String?
  ..purgeMarkedByUserName = json['PurgeMarkedByUserName'] as String?
  ..purgeMarkedByUserEmail = json['PurgeMarkedByUserEmail'] as String?;

Map<String, dynamic> _$ProjectToJson(Project instance) {
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
  writeNotNull('OrganizationNameLower', instance.organizationNameLower);
  writeNotNull('OrganizationSubscriptionRequired', instance.organizationSubscriptionRequired);
  writeNotNull('OrganizationSubscriptionFreeUsers', instance.organizationSubscriptionFreeUsers);
  writeNotNull('OrganizationSubscriptionExpiration', instance.organizationSubscriptionExpiration);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('CreatingUserID', instance.creatingUserID);
  writeNotNull('CreatingUserName', instance.creatingUserName);
  writeNotNull('CreatingUserEmail', instance.creatingUserEmail);
  writeNotNull('CrmAccountId', instance.crmAccountId);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('PurgeMarkedOn', instance.purgeMarkedOn);
  writeNotNull('PurgeMarkedByUserID', instance.purgeMarkedByUserID);
  writeNotNull('PurgeMarkedByUserName', instance.purgeMarkedByUserName);
  writeNotNull('PurgeMarkedByUserEmail', instance.purgeMarkedByUserEmail);
  return val;
}
