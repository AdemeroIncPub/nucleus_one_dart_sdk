// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document()
  ..id = json['ID'] as String?
  ..organizationID = json['OrganizationID'] as String?
  ..projectID = json['ProjectID'] as String?
  ..projectName = json['ProjectName'] as String?
  ..projectAccessType = json['ProjectAccessType'] as String?
  ..documentID = json['DocumentID'] as String?
  ..documentFolderID = json['DocumentFolderID'] as String?
  ..documentFolderPath = json['DocumentFolderPath'] as String?
  ..assignmentUserEmails =
      (json['AssignmentUserEmails'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..groupID = json['GroupID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..createdByUserEmail = json['CreatedByUserEmail'] as String?
  ..createdByUserName = json['CreatedByUserName'] as String?
  ..modifiedOn = json['ModifiedOn'] as String?
  ..modifiedByUserEmail = json['ModifiedByUserEmail'] as String?
  ..modifiedByUserName = json['ModifiedByUserName'] as String?
  ..purgeDate = json['PurgeDate'] as String?
  ..name = json['Name'] as String?
  ..origin = json['Origin'] as String?
  ..pageCount = json['PageCount'] as int?
  ..fileSize = json['FileSize'] as int?
  ..thumbnailUrl = json['ThumbnailUrl'] as String?
  ..isSigned = json['IsSigned'] as bool?
  ..previewMetadata = (json['PreviewMetadata'] as List<dynamic>?)
      ?.map((e) => Map<String, String>.from(e as Map))
      .toList()
  ..approvalID = json['ApprovalID'] as String?
  ..approvalCreatedOn = json['ApprovalCreatedOn'] as String?
  ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
  ..hasSinglePageImages = json['HasSinglePageImages'] as bool?
  ..signatureSessionIsActive = json['SignatureSessionIsActive'] as bool?
  ..signaturesCompletedOn = json['SignaturesCompletedOn'] as String?
  ..documentSubscriptionID = json['DocumentSubscriptionID'] as String?
  ..documentSubscriptionCreatedOn = json['DocumentSubscriptionCreatedOn'] as String?
  ..processName = json['ProcessName'] as String?
  ..processElementName = json['ProcessElementName'] as String?
  ..revision = json['Revision'] as int?
  ..paperSize = json['PaperSize'] as String?
  ..paperOrientation = json['PaperOrientation'] as String?
  ..paperMarginLeft = (json['PaperMarginLeft'] as num?)?.toDouble()
  ..paperMarginRight = (json['PaperMarginRight'] as num?)?.toDouble()
  ..paperMarginTop = (json['PaperMarginTop'] as num?)?.toDouble()
  ..paperMarginBottom = (json['PaperMarginBottom'] as num?)?.toDouble();

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentFolderID', instance.documentFolderID);
  writeNotNull('DocumentFolderPath', instance.documentFolderPath);
  writeNotNull('AssignmentUserEmails', instance.assignmentUserEmails);
  writeNotNull('GroupID', instance.groupID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('ModifiedByUserEmail', instance.modifiedByUserEmail);
  writeNotNull('ModifiedByUserName', instance.modifiedByUserName);
  writeNotNull('PurgeDate', instance.purgeDate);
  writeNotNull('Name', instance.name);
  writeNotNull('Origin', instance.origin);
  writeNotNull('PageCount', instance.pageCount);
  writeNotNull('FileSize', instance.fileSize);
  writeNotNull('ThumbnailUrl', instance.thumbnailUrl);
  writeNotNull('IsSigned', instance.isSigned);
  writeNotNull('PreviewMetadata', instance.previewMetadata);
  writeNotNull('ApprovalID', instance.approvalID);
  writeNotNull('ApprovalCreatedOn', instance.approvalCreatedOn);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('HasSinglePageImages', instance.hasSinglePageImages);
  writeNotNull('SignatureSessionIsActive', instance.signatureSessionIsActive);
  writeNotNull('SignaturesCompletedOn', instance.signaturesCompletedOn);
  writeNotNull('DocumentSubscriptionID', instance.documentSubscriptionID);
  writeNotNull('DocumentSubscriptionCreatedOn', instance.documentSubscriptionCreatedOn);
  writeNotNull('ProcessName', instance.processName);
  writeNotNull('ProcessElementName', instance.processElementName);
  writeNotNull('Revision', instance.revision);
  writeNotNull('PaperSize', instance.paperSize);
  writeNotNull('PaperOrientation', instance.paperOrientation);
  writeNotNull('PaperMarginLeft', instance.paperMarginLeft);
  writeNotNull('PaperMarginRight', instance.paperMarginRight);
  writeNotNull('PaperMarginTop', instance.paperMarginTop);
  writeNotNull('PaperMarginBottom', instance.paperMarginBottom);
  return val;
}

DocumentCollection _$DocumentCollectionFromJson(Map<String, dynamic> json) => DocumentCollection()
  ..documents = (json['Documents'] as List<dynamic>?)
      ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DocumentCollectionToJson(DocumentCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Documents', instance.documents);
  return val;
}
