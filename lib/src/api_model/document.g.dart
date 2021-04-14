// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document()
    ..uniqueID = json['UniqueID'] as String?
    ..documentID = json['DocumentID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..purgeDate = json['PurgeDate'] as String?
    ..name = json['Name'] as String?
    ..pageCount = json['PageCount'] as int?
    ..fileSize = json['FileSize'] as int?
    ..thumbnailUrl = json['ThumbnailUrl'] as String?
    ..isSigned = json['IsSigned'] as bool?
    ..classificationID = json['ClassificationID'] as String?
    ..classificationName = json['ClassificationName'] as String?
    ..previewMetadata = (json['PreviewMetadata'] as List<dynamic>?)
        ?.map((e) => PreviewMetadataItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..documentApprovalID = json['DocumentApprovalID'] as String?
    ..documentApprovalCreatedOn = json['DocumentApprovalCreatedOn'] as String?
    ..documentSubscriptionID = json['DocumentSubscriptionID'] as String?
    ..documentSubscriptionCreatedOn =
        json['DocumentSubscriptionCreatedOn'] as String?
    ..documentSignatureSessionRecipientID =
        json['DocumentSignatureSessionRecipientID'] as String?
    ..documentSignatureSessionID = json['DocumentSignatureSessionID'] as String?
    ..documentSignatureSessionRecipientEmail =
        json['DocumentSignatureSessionRecipientEmail'] as String?
    ..documentSignatureSessionRecipientFullName =
        json['DocumentSignatureSessionRecipientFullName'] as String?
    ..documentSignatureSessionRecipientRequestedOn =
        json['DocumentSignatureSessionRecipientRequestedOn'] as String?
    ..roleName = json['RoleName'] as String?
    ..processName = json['ProcessName'] as String?
    ..processElementName = json['ProcessElementName'] as String?
    ..score = json['Score'] as int?;
}

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('PurgeDate', instance.purgeDate);
  writeNotNull('Name', instance.name);
  writeNotNull('PageCount', instance.pageCount);
  writeNotNull('FileSize', instance.fileSize);
  writeNotNull('ThumbnailUrl', instance.thumbnailUrl);
  writeNotNull('IsSigned', instance.isSigned);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('ClassificationName', instance.classificationName);
  writeNotNull('PreviewMetadata', instance.previewMetadata);
  writeNotNull('DocumentApprovalID', instance.documentApprovalID);
  writeNotNull('DocumentApprovalCreatedOn', instance.documentApprovalCreatedOn);
  writeNotNull('DocumentSubscriptionID', instance.documentSubscriptionID);
  writeNotNull(
      'DocumentSubscriptionCreatedOn', instance.documentSubscriptionCreatedOn);
  writeNotNull('DocumentSignatureSessionRecipientID',
      instance.documentSignatureSessionRecipientID);
  writeNotNull(
      'DocumentSignatureSessionID', instance.documentSignatureSessionID);
  writeNotNull('DocumentSignatureSessionRecipientEmail',
      instance.documentSignatureSessionRecipientEmail);
  writeNotNull('DocumentSignatureSessionRecipientFullName',
      instance.documentSignatureSessionRecipientFullName);
  writeNotNull('DocumentSignatureSessionRecipientRequestedOn',
      instance.documentSignatureSessionRecipientRequestedOn);
  writeNotNull('RoleName', instance.roleName);
  writeNotNull('ProcessName', instance.processName);
  writeNotNull('ProcessElementName', instance.processElementName);
  writeNotNull('Score', instance.score);
  return val;
}
