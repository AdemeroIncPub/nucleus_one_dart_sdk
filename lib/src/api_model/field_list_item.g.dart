// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldListItem _$FieldListItemFromJson(Map<String, dynamic> json) => FieldListItem()
  ..id = json['ID'] as String?
  ..parentValue = json['ParentValue'] as String?
  ..value = json['Value'] as String?;

Map<String, dynamic> _$FieldListItemToJson(FieldListItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('ParentValue', instance.parentValue);
  writeNotNull('Value', instance.value);
  return val;
}
