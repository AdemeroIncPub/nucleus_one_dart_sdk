// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentFolder _$DocumentFolderFromJson(Map<String, dynamic> json) => DocumentFolder()
  ..id = json['ID'] as String?
  ..uniqueID = json['UniqueID'] as String?
  ..parentID = json['ParentID'] as String?
  ..ancestorIDs = (json['AncestorIDs'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..organizationID = json['OrganizationID'] as String?
  ..projectID = json['ProjectID'] as String?
  ..projectName = json['ProjectName'] as String?
  ..projectAccessType = json['ProjectAccessType'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..createdByUserEmail = json['CreatedByUserEmail'] as String?
  ..createdByUserName = json['CreatedByUserName'] as String?
  ..createdByUserID = json['CreatedByUserID'] as String?
  ..modifiedOn = json['ModifiedOn'] as String?
  ..modifiedByUserEmail = json['ModifiedByUserEmail'] as String?
  ..modifiedByUserName = json['ModifiedByUserName'] as String?
  ..modifiedByUserID = json['ModifiedByUserID'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?
  ..depth = json['Depth'] as int?
  ..ancestorAssignmentUserEmails =
      (json['AncestorAssignmentUserEmails'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..assignmentUserEmails =
      (json['AssignmentUserEmails'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..hexColor = json['HexColor'] as String?;

Map<String, dynamic> _$DocumentFolderToJson(DocumentFolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('ParentID', instance.parentID);
  writeNotNull('AncestorIDs', instance.ancestorIDs);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('ModifiedByUserEmail', instance.modifiedByUserEmail);
  writeNotNull('ModifiedByUserName', instance.modifiedByUserName);
  writeNotNull('ModifiedByUserID', instance.modifiedByUserID);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Depth', instance.depth);
  writeNotNull('AncestorAssignmentUserEmails', instance.ancestorAssignmentUserEmails);
  writeNotNull('AssignmentUserEmails', instance.assignmentUserEmails);
  writeNotNull('HexColor', instance.hexColor);
  return val;
}

DocumentFolderCollection _$DocumentFolderCollectionFromJson(Map<String, dynamic> json) =>
    DocumentFolderCollection()
      ..documentFolders = (json['DocumentFolders'] as List<dynamic>?)
          ?.map((e) => DocumentFolder.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DocumentFolderCollectionToJson(DocumentFolderCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DocumentFolders', instance.documentFolders);
  return val;
}
