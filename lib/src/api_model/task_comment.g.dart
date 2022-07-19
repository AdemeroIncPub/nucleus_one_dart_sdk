// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCommentCollection _$TaskCommentCollectionFromJson(Map<String, dynamic> json) =>
    TaskCommentCollection()
      ..taskEvents = (json['TaskEvents'] as List<dynamic>?)
          ?.map((e) => TaskEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TaskCommentCollectionToJson(TaskCommentCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TaskEvents', instance.taskEvents);
  return val;
}
