// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_metadata_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewMetadataItem _$PreviewMetadataItemFromJson(Map<String, dynamic> json) {
  return PreviewMetadataItem()
    ..item0 = json['0'] as String?
    ..item1 = json['1'] as String?
    ..item2 = json['2'] as String?;
}

Map<String, dynamic> _$PreviewMetadataItemToJson(PreviewMetadataItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('0', instance.item0);
  writeNotNull('1', instance.item1);
  writeNotNull('2', instance.item2);
  return val;
}
