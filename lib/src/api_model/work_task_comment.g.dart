// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTaskCommentCollection _$WorkTaskCommentCollectionFromJson(
        Map<String, dynamic> json) =>
    WorkTaskCommentCollection()
      ..workTaskEvents = (json['WorkTaskEvents'] as List<dynamic>?)
          ?.map((e) => WorkTaskEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WorkTaskCommentCollectionToJson(
    WorkTaskCommentCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('WorkTaskEvents', instance.workTaskEvents);
  return val;
}
