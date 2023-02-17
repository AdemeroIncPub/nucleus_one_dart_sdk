// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_recipient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionRecipient _$DocumentSignatureSessionRecipientFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionRecipient()
      ..id = json['ID'] as String?
      ..tenantID = json['TenantID'] as String?
      ..documentID = json['DocumentID'] as String?
      ..documentCreatedOn = json['DocumentCreatedOn'] as String?
      ..documentBucketName = json['DocumentBucketName'] as String?
      ..documentThumbnailObjectName = json['DocumentThumbnailObjectName'] as String?
      ..documentName = json['DocumentName'] as String?
      ..documentNameLower = json['DocumentNameLower'] as String?
      ..documentPageCount = json['DocumentPageCount'] as int?
      ..documentFileSize = json['DocumentFileSize'] as int?
      ..documentClassificationID = json['DocumentClassificationID'] as String?
      ..documentClassificationName = json['DocumentClassificationName'] as String?
      ..documentClassificationNameLower = json['DocumentClassificationNameLower'] as String?
      ..documentPreviewMetadata = (json['DocumentPreviewMetadata'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList()
      ..documentSignatureSessionID = json['DocumentSignatureSessionID'] as String?
      ..documentSignatureSessionIsActive = json['DocumentSignatureSessionIsActive'] as bool?
      ..documentSignatureSessionIsComplete = json['DocumentSignatureSessionIsComplete'] as bool?
      ..uniqueID = json['UniqueID'] as String?
      ..rank = json['Rank'] as int?
      ..email = json['Email'] as String?
      ..fullName = json['FullName'] as String?
      ..type = json['Type'] as String?
      ..tenantMemberID = json['TenantMemberID'] as String?
      ..signingRequestSent = json['SigningRequestSent'] as bool?
      ..requestedOn = json['RequestedOn'] as String?
      ..isActive = json['IsActive'] as bool?
      ..isComplete = json['IsComplete'] as bool?
      ..completedOn = json['CompletedOn'] as String?
      ..ipAddress = json['IPAddress'] as String?;

Map<String, dynamic> _$DocumentSignatureSessionRecipientToJson(
    DocumentSignatureSessionRecipient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentCreatedOn', instance.documentCreatedOn);
  writeNotNull('DocumentBucketName', instance.documentBucketName);
  writeNotNull('DocumentThumbnailObjectName', instance.documentThumbnailObjectName);
  writeNotNull('DocumentName', instance.documentName);
  writeNotNull('DocumentNameLower', instance.documentNameLower);
  writeNotNull('DocumentPageCount', instance.documentPageCount);
  writeNotNull('DocumentFileSize', instance.documentFileSize);
  writeNotNull('DocumentClassificationID', instance.documentClassificationID);
  writeNotNull('DocumentClassificationName', instance.documentClassificationName);
  writeNotNull('DocumentClassificationNameLower', instance.documentClassificationNameLower);
  writeNotNull('DocumentPreviewMetadata', instance.documentPreviewMetadata);
  writeNotNull('DocumentSignatureSessionID', instance.documentSignatureSessionID);
  writeNotNull('DocumentSignatureSessionIsActive', instance.documentSignatureSessionIsActive);
  writeNotNull('DocumentSignatureSessionIsComplete', instance.documentSignatureSessionIsComplete);
  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('Rank', instance.rank);
  writeNotNull('Email', instance.email);
  writeNotNull('FullName', instance.fullName);
  writeNotNull('Type', instance.type);
  writeNotNull('TenantMemberID', instance.tenantMemberID);
  writeNotNull('SigningRequestSent', instance.signingRequestSent);
  writeNotNull('RequestedOn', instance.requestedOn);
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('IsComplete', instance.isComplete);
  writeNotNull('CompletedOn', instance.completedOn);
  writeNotNull('IPAddress', instance.ipAddress);
  return val;
}
