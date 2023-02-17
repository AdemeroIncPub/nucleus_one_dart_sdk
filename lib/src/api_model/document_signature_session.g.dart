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
