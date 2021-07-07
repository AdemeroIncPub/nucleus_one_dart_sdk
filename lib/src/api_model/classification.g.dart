// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationCollection _$ClassificationCollectionFromJson(
    Map<String, dynamic> json) {
  return ClassificationCollection()
    ..classifications = (json['Classifications'] as List<dynamic>?)
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

  writeNotNull('Classifications', instance.classifications);
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

ClassificationField _$ClassificationFieldFromJson(Map<String, dynamic> json) {
  return ClassificationField()
    ..id = json['ID'] as String?
    ..classificationID = json['ClassificationID'] as String?
    ..classificationName = json['ClassificationName'] as String?
    ..fieldID = json['FieldID'] as String?
    ..fieldName = json['FieldName'] as String?
    ..fieldNameLower = json['FieldNameLower'] as String?
    ..rank = (json['Rank'] as num?)?.toDouble()
    ..mapped = json['Mapped'] as bool?;
}

Map<String, dynamic> _$ClassificationFieldToJson(ClassificationField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('ClassificationName', instance.classificationName);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('FieldName', instance.fieldName);
  writeNotNull('FieldNameLower', instance.fieldNameLower);
  writeNotNull('Rank', instance.rank);
  writeNotNull('Mapped', instance.mapped);
  return val;
}
