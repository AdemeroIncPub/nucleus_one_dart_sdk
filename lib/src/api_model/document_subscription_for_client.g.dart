// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_subscription_for_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSubscriptionForClient _$DocumentSubscriptionForClientFromJson(Map<String, dynamic> json) =>
    DocumentSubscriptionForClient()
      ..id = json['ID'] as String?
      ..subscribed = json['Subscribed'] as bool?
      ..notify = json['Notify'] as bool?
      ..createdOn = json['CreatedOn'] as String?
      ..organizationID = json['OrganizationID'] as String?
      ..projectID = json['ProjectID'] as String?
      ..projectName = json['ProjectName'] as String?
      ..projectAccessType = json['ProjectAccessType'] as String?
      ..documentID = json['DocumentID'] as String?
      ..documentCreatedOn = json['DocumentCreatedOn'] as String?
      ..documentName = json['DocumentName'] as String?
      ..documentPageCount = json['DocumentPageCount'] as int?
      ..documentFileSize = json['DocumentFileSize'] as int?
      ..documentPreviewMetadata = (json['DocumentPreviewMetadata'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList()
      ..documentIsSigned = json['DocumentIsSigned'] as bool?
      ..documentThumbnailUrl = json['DocumentThumbnailUrl'] as String?;

Map<String, dynamic> _$DocumentSubscriptionForClientToJson(DocumentSubscriptionForClient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('Subscribed', instance.subscribed);
  writeNotNull('Notify', instance.notify);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentCreatedOn', instance.documentCreatedOn);
  writeNotNull('DocumentName', instance.documentName);
  writeNotNull('DocumentPageCount', instance.documentPageCount);
  writeNotNull('DocumentFileSize', instance.documentFileSize);
  writeNotNull('DocumentPreviewMetadata', instance.documentPreviewMetadata);
  writeNotNull('DocumentIsSigned', instance.documentIsSigned);
  writeNotNull('DocumentThumbnailUrl', instance.documentThumbnailUrl);
  return val;
}

DocumentSubscriptionForClientCollection _$DocumentSubscriptionForClientCollectionFromJson(
        Map<String, dynamic> json) =>
    DocumentSubscriptionForClientCollection()
      ..documentSubscriptions = (json['DocumentSubscriptions'] as List<dynamic>?)
          ?.map((e) => DocumentSubscriptionForClient.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DocumentSubscriptionForClientCollectionToJson(
    DocumentSubscriptionForClientCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DocumentSubscriptions', instance.documentSubscriptions);
  return val;
}
