// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentFieldCollection _$DocumentFieldCollectionFromJson(
    Map<String, dynamic> json) {
  return DocumentFieldCollection()
    ..documentFields = (json['DocumentFields'] as List<dynamic>?)
        ?.map((e) => DocumentField.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DocumentFieldCollectionToJson(
    DocumentFieldCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DocumentFields', instance.documentFields);
  return val;
}

DocumentField _$DocumentFieldFromJson(Map<String, dynamic> json) {
  return DocumentField()
    ..id = json['ID'] as String?
    ..fieldID = json['FieldID'] as String?
    ..documentID = json['DocumentID'] as String?
    ..classificationID = json['ClassificationID'] as String?
    ..value = json['Value'] as String?
    ..uniqueTextValue = json['UniqueTextValue'] as String?
    ..uniqueFirst1 = json['UniqueFirst1'] as String?
    ..uniqueFirst2 = json['UniqueFirst2'] as String?
    ..uniqueFirst3 = json['UniqueFirst3'] as String?
    ..uniqueFloatValue = (json['UniqueFloatValue'] as num?)?.toDouble()
    ..uniqueTimeValue = json['UniqueTimeValue'] as String?
    ..uniqueYear = json['UniqueYear'] as String?
    ..uniqueYearMonth = json['UniqueYearMonth'] as String?;
}

Map<String, dynamic> _$DocumentFieldToJson(DocumentField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('Value', instance.value);
  writeNotNull('UniqueTextValue', instance.uniqueTextValue);
  writeNotNull('UniqueFirst1', instance.uniqueFirst1);
  writeNotNull('UniqueFirst2', instance.uniqueFirst2);
  writeNotNull('UniqueFirst3', instance.uniqueFirst3);
  writeNotNull('UniqueFloatValue', instance.uniqueFloatValue);
  writeNotNull('UniqueTimeValue', instance.uniqueTimeValue);
  writeNotNull('UniqueYear', instance.uniqueYear);
  writeNotNull('UniqueYearMonth', instance.uniqueYearMonth);
  return val;
}
