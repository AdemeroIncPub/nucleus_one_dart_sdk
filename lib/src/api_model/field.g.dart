// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldCollection _$FieldCollectionFromJson(Map<String, dynamic> json) =>
    FieldCollection()
      ..fields = (json['Fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FieldCollectionToJson(FieldCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Fields', instance.fields);
  return val;
}

Field _$FieldFromJson(Map<String, dynamic> json) => Field()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..parentFieldID = json['ParentFieldID'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?
  ..label = json['Label'] as String?
  ..labelLower = json['LabelLower'] as String?
  ..labelOrName = json['LabelOrName'] as String?
  ..labelOrNameLower = json['LabelOrNameLower'] as String?
  ..type = json['Type'] as String?
  ..displaySelectionList = json['DisplaySelectionList'] as bool?
  ..allowMultipleLines = json['AllowMultipleLines'] as bool?
  ..rows = json['Rows'] as int?
  ..allowMultipleValues = json['AllowMultipleValues'] as bool?
  ..allowNewSelectionListItems = json['AllowNewSelectionListItems'] as bool?
  ..saveNewSelectionListItems = json['SaveNewSelectionListItems'] as bool?
  ..decimalPlaces = json['DecimalPlaces'] as int?
  ..mask = json['Mask'] as String?
  ..required = json['Required'] as bool?
  ..sensitive = json['Sensitive'] as bool?
  ..useCreationDate = json['UseCreationDate'] as bool?
  ..textMatchType = json['TextMatchType'] as String?;

Map<String, dynamic> _$FieldToJson(Field instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('ParentFieldID', instance.parentFieldID);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Label', instance.label);
  writeNotNull('LabelLower', instance.labelLower);
  writeNotNull('LabelOrName', instance.labelOrName);
  writeNotNull('LabelOrNameLower', instance.labelOrNameLower);
  writeNotNull('Type', instance.type);
  writeNotNull('DisplaySelectionList', instance.displaySelectionList);
  writeNotNull('AllowMultipleLines', instance.allowMultipleLines);
  writeNotNull('Rows', instance.rows);
  writeNotNull('AllowMultipleValues', instance.allowMultipleValues);
  writeNotNull(
      'AllowNewSelectionListItems', instance.allowNewSelectionListItems);
  writeNotNull('SaveNewSelectionListItems', instance.saveNewSelectionListItems);
  writeNotNull('DecimalPlaces', instance.decimalPlaces);
  writeNotNull('Mask', instance.mask);
  writeNotNull('Required', instance.required);
  writeNotNull('Sensitive', instance.sensitive);
  writeNotNull('UseCreationDate', instance.useCreationDate);
  writeNotNull('TextMatchType', instance.textMatchType);
  return val;
}
