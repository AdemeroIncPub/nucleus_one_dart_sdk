// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_content_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentContentPackage _$DocumentContentPackageFromJson(Map<String, dynamic> json) =>
    DocumentContentPackage()
      ..url = json['Url'] as String?
      ..contentType = json['ContentType'] as String?
      ..name = json['Name'] as String?
      ..pageIndex = json['PageIndex'] as int?
      ..pageCount = json['PageCount'] as int?;

Map<String, dynamic> _$DocumentContentPackageToJson(DocumentContentPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Url', instance.url);
  writeNotNull('ContentType', instance.contentType);
  writeNotNull('Name', instance.name);
  writeNotNull('PageIndex', instance.pageIndex);
  writeNotNull('PageCount', instance.pageCount);
  return val;
}
