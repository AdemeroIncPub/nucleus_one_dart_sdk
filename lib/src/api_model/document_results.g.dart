// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResults _$DocumentResultsFromJson(Map<String, dynamic> json) {
  return DocumentResults()
    ..documents = (json['Documents'] as List<dynamic>?)
        ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
        .toList()
    ..cursor = json['Cursor'] as String?
    ..pageSize = json['PageSize'] as int?;
}

Map<String, dynamic> _$DocumentResultsToJson(DocumentResults instance) {
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
