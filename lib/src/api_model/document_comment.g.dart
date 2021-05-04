// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentCommentCollection _$DocumentCommentCollectionFromJson(
    Map<String, dynamic> json) {
  return DocumentCommentCollection()
    ..documentEvents = (json['DocumentEvents'] as List<dynamic>?)
        ?.map((e) => DocumentEvent.fromJson(e as Map<String, dynamic>))
        .toList()
    ..cursor = json['Cursor'] as String?
    ..reverseCursor = json['ReverseCursor'] as String?
    ..pageSize = json['PageSize'] as int?;
}

Map<String, dynamic> _$DocumentCommentCollectionToJson(
    DocumentCommentCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DocumentEvents', instance.documentEvents);
  writeNotNull('Cursor', instance.cursor);
  writeNotNull('ReverseCursor', instance.reverseCursor);
  writeNotNull('PageSize', instance.pageSize);
  return val;
}
