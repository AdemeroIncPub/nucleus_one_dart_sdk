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
        .toList();
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
  return val;
}
