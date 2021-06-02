// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document()
    ..id = json['ID'] as String?
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
    ..score = json['Score'] as int?
    ..createdByUserID = json['CreatedByUserID'] as String?
    ..createdByUserEmail = json['CreatedByUserEmail'] as String?
    ..createdByUserName = json['CreatedByUserName'] as String?
    ..nameLower = json['NameLower'] as String?
    ..origin = json['Origin'] as String?
    ..isActive = json['IsActive'] as bool?
    ..isClassified = json['IsClassified'] as bool?
    ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
    ..signatureSessionIsActive = json['SignatureSessionIsActive'] as bool?
    ..hasSinglePageImages = json['HasSinglePageImages'] as bool?
    ..signaturesCompletedOn = json['SignaturesCompletedOn'] as String?
    ..purgeMarkedOn = json['PurgeMarkedOn'] as String?
    ..failedBuildAttempts = json['FailedBuildAttempts'] as bool?
    ..lastError = json['LastError'] as String?
    ..bucketName = json['BucketName'] as String?
    ..sourceObjectName = json['SourceObjectName'] as String?
    ..thumbnailObjectName = json['ThumbnailObjectName'] as String?
    ..classificationNameLower = json['ClassificationNameLower'] as String?;
}

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
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
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Origin', instance.origin);
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('IsClassified', instance.isClassified);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('SignatureSessionIsActive', instance.signatureSessionIsActive);
  writeNotNull('HasSinglePageImages', instance.hasSinglePageImages);
  writeNotNull('SignaturesCompletedOn', instance.signaturesCompletedOn);
  writeNotNull('PurgeMarkedOn', instance.purgeMarkedOn);
  writeNotNull('FailedBuildAttempts', instance.failedBuildAttempts);
  writeNotNull('LastError', instance.lastError);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('SourceObjectName', instance.sourceObjectName);
  writeNotNull('ThumbnailObjectName', instance.thumbnailObjectName);
  writeNotNull('ClassificationNameLower', instance.classificationNameLower);
  return val;
}
