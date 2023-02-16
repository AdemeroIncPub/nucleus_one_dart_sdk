// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEvent _$TaskEventFromJson(Map<String, dynamic> json) => TaskEvent()
  ..id = json['ID'] as String?
  ..taskID = json['TaskID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..createdByUserID = json['CreatedByUserID'] as String?
  ..createdByUserName = json['CreatedByUserName'] as String?
  ..createdByUserEmail = json['CreatedByUserEmail'] as String?
  ..modifiedOn = json['ModifiedOn'] as String?
  ..type = json['Type'] as String?
  ..taskRevision = json['TaskRevision'] as int?
  ..detailJson = json['DetailJson'] as String?;

Map<String, dynamic> _$TaskEventToJson(TaskEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('TaskID', instance.taskID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('Type', instance.type);
  writeNotNull('TaskRevision', instance.taskRevision);
  writeNotNull('DetailJson', instance.detailJson);
  return val;
}

TaskEventCollection _$TaskEventCollectionFromJson(Map<String, dynamic> json) =>
    TaskEventCollection()
      ..taskEvents = (json['TaskEvents'] as List<dynamic>?)
          ?.map((e) => TaskEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TaskEventCollectionToJson(TaskEventCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TaskEvents', instance.taskEvents);
  return val;
}
