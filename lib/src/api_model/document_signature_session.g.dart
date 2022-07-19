// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSession _$DocumentSignatureSessionFromJson(Map<String, dynamic> json) =>
    DocumentSignatureSession()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..modifiedOn = json['ModifiedOn'] as String?
      ..createdByUserID = json['CreatedByUserID'] as String?
      ..createdByUserEmail = json['CreatedByUserEmail'] as String?
      ..createdByUserName = json['CreatedByUserName'] as String?
      ..lastModifiedByUserID = json['LastModifiedByUserID'] as String?
      ..lastModifiedByUserEmail = json['LastModifiedByUserEmail'] as String?
      ..lastModifiedByUserName = json['LastModifiedByUserName'] as String?
      ..documentID = json['DocumentID'] as String?
      ..documentRevisionID = json['DocumentRevisionID'] as String?
      ..isActive = json['IsActive'] as bool?
      ..isComplete = json['IsComplete'] as bool?
      ..wasStopped = json['WasStopped'] as bool?
      ..completedOn = json['CompletedOn'] as String?
      ..isRendered = json['IsRendered'] as bool?
      ..renderedOn = json['RenderedOn'] as String?
      ..formDesignType = json['FormDesignType'] as String?
      ..useAccessCode = json['UseAccessCode'] as bool?
      ..accessCode = json['AccessCode'] as String?
      ..useCustomSubjectAndBody = json['UseCustomSubjectAndBody'] as bool?
      ..customSubject = json['CustomSubject'] as String?
      ..customBody = json['CustomBody'] as String?
      ..quickDesignPlaceInitials = json['QuickDesignPlaceInitials'] as bool?
      ..quickDesignPlaceFullName = json['QuickDesignPlaceFullName'] as bool?
      ..quickDesignPlaceEmail = json['QuickDesignPlaceEmail'] as bool?
      ..quickDesignPlaceTitle = json['QuickDesignPlaceTitle'] as bool?;

Map<String, dynamic> _$DocumentSignatureSessionToJson(DocumentSignatureSession instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('LastModifiedByUserID', instance.lastModifiedByUserID);
  writeNotNull('LastModifiedByUserEmail', instance.lastModifiedByUserEmail);
  writeNotNull('LastModifiedByUserName', instance.lastModifiedByUserName);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentRevisionID', instance.documentRevisionID);
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('IsComplete', instance.isComplete);
  writeNotNull('WasStopped', instance.wasStopped);
  writeNotNull('CompletedOn', instance.completedOn);
  writeNotNull('IsRendered', instance.isRendered);
  writeNotNull('RenderedOn', instance.renderedOn);
  writeNotNull('FormDesignType', instance.formDesignType);
  writeNotNull('UseAccessCode', instance.useAccessCode);
  writeNotNull('AccessCode', instance.accessCode);
  writeNotNull('UseCustomSubjectAndBody', instance.useCustomSubjectAndBody);
  writeNotNull('CustomSubject', instance.customSubject);
  writeNotNull('CustomBody', instance.customBody);
  writeNotNull('QuickDesignPlaceInitials', instance.quickDesignPlaceInitials);
  writeNotNull('QuickDesignPlaceFullName', instance.quickDesignPlaceFullName);
  writeNotNull('QuickDesignPlaceEmail', instance.quickDesignPlaceEmail);
  writeNotNull('QuickDesignPlaceTitle', instance.quickDesignPlaceTitle);
  return val;
}

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

DocumentSignatureSessionPackage _$DocumentSignatureSessionPackageFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionPackage()
      ..session = json['Session'] == null
          ? null
          : DocumentSignatureSession.fromJson(json['Session'] as Map<String, dynamic>)
      ..recipients = (json['Recipients'] as List<dynamic>?)
          ?.map((e) => DocumentSignatureSessionRecipient.fromJson(e as Map<String, dynamic>))
          .toList()
      ..beginSession = json['BeginSession'] as bool?
      ..resetSession = json['ResetSession'] as bool?;

Map<String, dynamic> _$DocumentSignatureSessionPackageToJson(
    DocumentSignatureSessionPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Session', instance.session);
  writeNotNull('Recipients', instance.recipients);
  writeNotNull('BeginSession', instance.beginSession);
  writeNotNull('ResetSession', instance.resetSession);
  return val;
}
