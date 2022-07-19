// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_hierarchies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FolderHierarchyCollection _$FolderHierarchyCollectionFromJson(Map<String, dynamic> json) =>
    FolderHierarchyCollection()
      ..folderHierarchies = (json['FolderHierarchies'] as List<dynamic>?)
          ?.map((e) => FolderHierarchy.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FolderHierarchyCollectionToJson(FolderHierarchyCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FolderHierarchies', instance.folderHierarchies);
  return val;
}

FolderHierarchy _$FolderHierarchyFromJson(Map<String, dynamic> json) => FolderHierarchy()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?;

Map<String, dynamic> _$FolderHierarchyToJson(FolderHierarchy instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  return val;
}

FolderHierarchyItem _$FolderHierarchyItemFromJson(Map<String, dynamic> json) =>
    FolderHierarchyItem()
      ..id = json['ID'] as String?
      ..folderHierarchyID = json['FolderHierarchyID'] as String?
      ..folderHierarchyName = json['FolderHierarchyName'] as String?
      ..rank = json['Rank'] as int?
      ..type = json['Type'] as String?
      ..fieldID = json['FieldID'] as String?
      ..fieldName = json['FieldName'] as String?
      ..fieldType = json['FieldType'] as String?
      ..fieldValueType = json['FieldValueType'] as String?;

Map<String, dynamic> _$FolderHierarchyItemToJson(FolderHierarchyItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('FolderHierarchyID', instance.folderHierarchyID);
  writeNotNull('FolderHierarchyName', instance.folderHierarchyName);
  writeNotNull('Rank', instance.rank);
  writeNotNull('Type', instance.type);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('FieldName', instance.fieldName);
  writeNotNull('FieldType', instance.fieldType);
  writeNotNull('FieldValueType', instance.fieldValueType);
  return val;
}
