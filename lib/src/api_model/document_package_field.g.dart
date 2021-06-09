// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_package_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPackageField _$DocumentPackageFieldFromJson(Map<String, dynamic> json) {
  return DocumentPackageField()
    ..classificationFieldID = json['ClassificationFieldID'] as String?
    ..classificationFieldRank = json['ClassificationFieldRank'] as int?
    ..fieldID = json['FieldID'] as String?
    ..parentFieldID = json['ParentFieldID'] as String?
    ..name = json['Name'] as String?
    ..labelOrName = json['LabelOrName'] as String?
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
    ..value = json['Value'] as String?
    ..values = json['Values'] as String?
    ..useCreationDate = json['UseCreationDate'] as bool?
    ..textMatchType = json['TextMatchType'] as String?;
}

Map<String, dynamic> _$DocumentPackageFieldToJson(
    DocumentPackageField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ClassificationFieldID', instance.classificationFieldID);
  writeNotNull('ClassificationFieldRank', instance.classificationFieldRank);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('ParentFieldID', instance.parentFieldID);
  writeNotNull('Name', instance.name);
  writeNotNull('LabelOrName', instance.labelOrName);
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
  writeNotNull('Value', instance.value);
  writeNotNull('Values', instance.values);
  writeNotNull('UseCreationDate', instance.useCreationDate);
  writeNotNull('TextMatchType', instance.textMatchType);
  return val;
}
