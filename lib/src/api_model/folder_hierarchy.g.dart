// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_hierarchy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
