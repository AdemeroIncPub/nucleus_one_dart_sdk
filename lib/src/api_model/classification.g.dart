// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationCollection _$ClassificationCollectionFromJson(
    Map<String, dynamic> json) {
  return ClassificationCollection()
    ..classifications = (json['ClassificationCollection'] as List<dynamic>?)
        ?.map((e) => Classification.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ClassificationCollectionToJson(
    ClassificationCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ClassificationCollection', instance.classifications);
  return val;
}

Classification _$ClassificationFromJson(Map<String, dynamic> json) {
  return Classification()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..isActive = json['IsActive'] as bool?;
}

Map<String, dynamic> _$ClassificationToJson(Classification instance) {
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
  writeNotNull('IsActive', instance.isActive);
  return val;
}
