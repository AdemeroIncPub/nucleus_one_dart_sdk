// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalCollection _$ApprovalCollectionFromJson(Map<String, dynamic> json) => ApprovalCollection()
  ..approvals = (json['Approvals'] as List<dynamic>?)
      ?.map((e) => Approval.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ApprovalCollectionToJson(ApprovalCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Approvals', instance.approvals);
  return val;
}

Approval _$ApprovalFromJson(Map<String, dynamic> json) => Approval()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..roleID = json['RoleID'] as String?
  ..roleName = json['RoleName'] as String?
  ..processID = json['ProcessID'] as String?
  ..processName = json['ProcessName'] as String?
  ..processElementID = json['ProcessElementID'] as String?
  ..processElementName = json['ProcessElementName'] as String?
  ..participationType = json['ParticipationType'] as String?
  ..approvingTenantMemberIDs = (json['ApprovingTenantMemberIDs'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  )
  ..result = json['Result'] as String?
  ..itemType = json['ItemType'] as String?
  ..itemID = json['ItemID'] as String?
  ..itemCreatedOn = json['ItemCreatedOn'] as String?
  ..itemCreatedByUserID = json['ItemCreatedByUserID'] as String?
  ..itemCreatedByUserEmail = json['ItemCreatedByUserEmail'] as String?
  ..itemCreatedByUserName = json['ItemCreatedByUserName'] as String?
  ..itemCompletedOn = json['ItemCompletedOn'] as String?
  ..itemCompletedByUserID = json['ItemCompletedByUserID'] as String?
  ..itemCompletedByUserEmail = json['ItemCompletedByUserEmail'] as String?
  ..itemCompletedByUserName = json['ItemCompletedByUserName'] as String?
  ..itemName = json['ItemName'] as String?
  ..itemDescription = json['ItemDescription'] as String?
  ..documentName = json['DocumentName'] as String?
  ..documentCreatedOn = json['DocumentCreatedOn'] as String?
  ..documentCreatedByUserID = json['DocumentCreatedByUserID'] as String?
  ..documentCreatedByUserEmail = json['DocumentCreatedByUserEmail'] as String?
  ..documentCreatedByUserName = json['DocumentCreatedByUserName'] as String?
  ..documentPageCount = json['DocumentPageCount'] as int?
  ..documentFileSize = json['DocumentFileSize'] as int?
  ..documentClassificationID = json['DocumentClassificationID'] as String?
  ..documentClassificationName = json['DocumentClassificationName'] as String?
  ..documentPreviewMetadata = (json['DocumentPreviewMetadata'] as List<dynamic>?)
      ?.map((e) => Map<String, String>.from(e as Map))
      .toList()
  ..documentIsSigned = json['DocumentIsSigned'] as bool?
  ..taskDueOn = json['TaskDueOn'] as String?
  ..thumbnailUrl = json['ThumbnailUrl'] as String?;

Map<String, dynamic> _$ApprovalToJson(Approval instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('RoleID', instance.roleID);
  writeNotNull('RoleName', instance.roleName);
  writeNotNull('ProcessID', instance.processID);
  writeNotNull('ProcessName', instance.processName);
  writeNotNull('ProcessElementID', instance.processElementID);
  writeNotNull('ProcessElementName', instance.processElementName);
  writeNotNull('ParticipationType', instance.participationType);
  writeNotNull('ApprovingTenantMemberIDs', instance.approvingTenantMemberIDs);
  writeNotNull('Result', instance.result);
  writeNotNull('ItemType', instance.itemType);
  writeNotNull('ItemID', instance.itemID);
  writeNotNull('ItemCreatedOn', instance.itemCreatedOn);
  writeNotNull('ItemCreatedByUserID', instance.itemCreatedByUserID);
  writeNotNull('ItemCreatedByUserEmail', instance.itemCreatedByUserEmail);
  writeNotNull('ItemCreatedByUserName', instance.itemCreatedByUserName);
  writeNotNull('ItemCompletedOn', instance.itemCompletedOn);
  writeNotNull('ItemCompletedByUserID', instance.itemCompletedByUserID);
  writeNotNull('ItemCompletedByUserEmail', instance.itemCompletedByUserEmail);
  writeNotNull('ItemCompletedByUserName', instance.itemCompletedByUserName);
  writeNotNull('ItemName', instance.itemName);
  writeNotNull('ItemDescription', instance.itemDescription);
  writeNotNull('DocumentName', instance.documentName);
  writeNotNull('DocumentCreatedOn', instance.documentCreatedOn);
  writeNotNull('DocumentCreatedByUserID', instance.documentCreatedByUserID);
  writeNotNull('DocumentCreatedByUserEmail', instance.documentCreatedByUserEmail);
  writeNotNull('DocumentCreatedByUserName', instance.documentCreatedByUserName);
  writeNotNull('DocumentPageCount', instance.documentPageCount);
  writeNotNull('DocumentFileSize', instance.documentFileSize);
  writeNotNull('DocumentClassificationID', instance.documentClassificationID);
  writeNotNull('DocumentClassificationName', instance.documentClassificationName);
  writeNotNull('DocumentPreviewMetadata', instance.documentPreviewMetadata);
  writeNotNull('DocumentIsSigned', instance.documentIsSigned);
  writeNotNull('TaskDueOn', instance.taskDueOn);
  writeNotNull('ThumbnailUrl', instance.thumbnailUrl);
  return val;
}
