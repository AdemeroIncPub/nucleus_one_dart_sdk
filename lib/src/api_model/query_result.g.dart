// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryResult<T> _$QueryResultFromJson<T>(Map<String, dynamic> json) => QueryResult<T>()
  ..cursor = json['Cursor'] as String?
  ..pageSize = json['PageSize'] as int?;

Map<String, dynamic> _$QueryResultToJson<T>(QueryResult<T> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Cursor', instance.cursor);
  writeNotNull('PageSize', instance.pageSize);
  return val;
}

QueryResult2<T> _$QueryResult2FromJson<T>(Map<String, dynamic> json) => QueryResult2<T>()
  ..cursor = json['Cursor'] as String?
  ..pageSize = json['PageSize'] as int?
  ..reverseCursor = json['ReverseCursor'] as String?;

Map<String, dynamic> _$QueryResult2ToJson<T>(QueryResult2<T> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Cursor', instance.cursor);
  writeNotNull('PageSize', instance.pageSize);
  writeNotNull('ReverseCursor', instance.reverseCursor);
  return val;
}
