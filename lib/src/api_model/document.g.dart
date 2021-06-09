// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..createdByUserID = json['CreatedByUserID'] as String?
    ..createdByUserEmail = json['CreatedByUserEmail'] as String?
    ..createdByUserName = json['CreatedByUserName'] as String?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..origin = json['Origin'] as String?
    ..isActive = json['IsActive'] as bool?
    ..isClassified = json['IsClassified'] as bool?
    ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
    ..isSigned = json['IsSigned'] as bool?
    ..signatureSessionIsActive = json['SignatureSessionIsActive'] as bool?
    ..hasSinglePageImages = json['HasSinglePageImages'] as bool?
    ..signaturesCompletedOn = json['SignaturesCompletedOn'] as String?
    ..purgeMarkedOn = json['PurgeMarkedOn'] as String?
    ..failedBuildAttempts = json['FailedBuildAttempts'] as bool?
    ..lastError = json['LastError'] as String?
    ..pageCount = json['PageCount'] as int?
    ..fileSize = json['FileSize'] as int?
    ..bucketName = json['BucketName'] as String?
    ..sourceObjectName = json['SourceObjectName'] as String?
    ..thumbnailObjectName = json['ThumbnailObjectName'] as String?
    ..classificationID = json['ClassificationID'] as String?
    ..classificationName = json['ClassificationName'] as String?
    ..classificationNameLower = json['ClassificationNameLower'] as String?
    ..previewMetadata = (json['PreviewMetadata'] as List<dynamic>?)
        ?.map((e) => PreviewMetadataItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Origin', instance.origin);
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('IsClassified', instance.isClassified);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('IsSigned', instance.isSigned);
  writeNotNull('SignatureSessionIsActive', instance.signatureSessionIsActive);
  writeNotNull('HasSinglePageImages', instance.hasSinglePageImages);
  writeNotNull('SignaturesCompletedOn', instance.signaturesCompletedOn);
  writeNotNull('PurgeMarkedOn', instance.purgeMarkedOn);
  writeNotNull('FailedBuildAttempts', instance.failedBuildAttempts);
  writeNotNull('LastError', instance.lastError);
  writeNotNull('PageCount', instance.pageCount);
  writeNotNull('FileSize', instance.fileSize);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('SourceObjectName', instance.sourceObjectName);
  writeNotNull('ThumbnailObjectName', instance.thumbnailObjectName);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('ClassificationName', instance.classificationName);
  writeNotNull('ClassificationNameLower', instance.classificationNameLower);
  writeNotNull('PreviewMetadata', instance.previewMetadata);
  return val;
}
