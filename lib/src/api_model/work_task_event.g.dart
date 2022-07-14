// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTaskEventCollection _$WorkTaskEventCollectionFromJson(
        Map<String, dynamic> json) =>
    WorkTaskEventCollection()
      ..workTaskEvents = (json['WorkTaskEvents'] as List<dynamic>?)
          ?.map((e) => WorkTaskEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WorkTaskEventCollectionToJson(
    WorkTaskEventCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('WorkTaskEvents', instance.workTaskEvents);
  return val;
}

WorkTaskEvent _$WorkTaskEventFromJson(Map<String, dynamic> json) =>
    WorkTaskEvent()
      ..id = json['ID'] as String?
      ..workTaskID = json['WorkTaskID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..createdByUserID = json['CreatedByUserID'] as String?
      ..createdByUserName = json['CreatedByUserName'] as String?
      ..createdByUserEmail = json['CreatedByUserEmail'] as String?
      ..modifiedOn = json['ModifiedOn'] as String?
      ..type = json['Type'] as String?
      ..workTaskRevision = json['WorkTaskRevision'] as int?
      ..detailJson = json['DetailJson'] as String?;

Map<String, dynamic> _$WorkTaskEventToJson(WorkTaskEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('WorkTaskID', instance.workTaskID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('Type', instance.type);
  writeNotNull('WorkTaskRevision', instance.workTaskRevision);
  writeNotNull('DetailJson', instance.detailJson);
  return val;
}
