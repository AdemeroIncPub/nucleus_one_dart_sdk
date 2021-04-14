// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_documents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentDocuments _$RecentDocumentsFromJson(Map<String, dynamic> json) {
  return RecentDocuments()
    ..documents = (json['Documents'] as List<dynamic>?)
        ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
        .toList()
    ..cursor = json['Cursor'] as String?
    ..pageSize = json['PageSize'] as int?;
}

Map<String, dynamic> _$RecentDocumentsToJson(RecentDocuments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Documents', instance.documents);
  writeNotNull('Cursor', instance.cursor);
  writeNotNull('PageSize', instance.pageSize);
  return val;
}
