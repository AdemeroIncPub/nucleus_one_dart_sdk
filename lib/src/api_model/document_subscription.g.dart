// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSubscription _$DocumentSubscriptionFromJson(Map<String, dynamic> json) {
  return DocumentSubscription()
    ..subscribed = json['Subscribed'] as bool?
    ..notify = json['Notify'] as bool?
    ..createdOn = json['CreatedOn'] as String?
    ..documentID = json['DocumentID'] as String?
    ..documentCreatedOn = json['DocumentCreatedOn'] as String?
    ..documentName = json['DocumentName'] as String?
    ..documentPageCount = json['DocumentPageCount'] as int?
    ..documentFileSize = json['DocumentFileSize'] as int?
    ..documentClassificationID = json['DocumentClassificationID'] as String?
    ..documentClassificationName = json['DocumentClassificationName'] as String?
    ..documentPreviewMetadata = (json['DocumentPreviewMetadata']
            as List<dynamic>?)
        ?.map((e) => PreviewMetadataItem.fromJson(e as Map<String, dynamic>))
        .toList()
    ..documentIsSigned = json['DocumentIsSigned'] as bool?;
}

Map<String, dynamic> _$DocumentSubscriptionToJson(
    DocumentSubscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Subscribed', instance.subscribed);
  writeNotNull('Notify', instance.notify);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentCreatedOn', instance.documentCreatedOn);
  writeNotNull('DocumentName', instance.documentName);
  writeNotNull('DocumentPageCount', instance.documentPageCount);
  writeNotNull('DocumentFileSize', instance.documentFileSize);
  writeNotNull('DocumentClassificationID', instance.documentClassificationID);
  writeNotNull(
      'DocumentClassificationName', instance.documentClassificationName);
  writeNotNull('DocumentPreviewMetadata', instance.documentPreviewMetadata);
  writeNotNull('DocumentIsSigned', instance.documentIsSigned);
  return val;
}
