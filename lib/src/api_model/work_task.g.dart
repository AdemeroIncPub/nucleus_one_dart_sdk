// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTaskCollection _$WorkTaskCollectionFromJson(Map<String, dynamic> json) {
  return WorkTaskCollection()
    ..workTasks = (json['WorkTasks'] as List<dynamic>?)
        ?.map((e) => WorkTask.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkTaskCollectionToJson(WorkTaskCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('WorkTasks', instance.workTasks);
  return val;
}

WorkTask _$WorkTaskFromJson(Map<String, dynamic> json) {
  return WorkTask()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..modifiedOn = json['ModifiedOn'] as String?
    ..createdByUserID = json['CreatedByUserID'] as String?
    ..createdByUserEmail = json['CreatedByUserEmail'] as String?
    ..createdByUserName = json['CreatedByUserName'] as String?
    ..completedOn = json['CompletedOn'] as String?
    ..completedByUserID = json['CompletedByUserID'] as String?
    ..completedByUserEmail = json['CompletedByUserEmail'] as String?
    ..completedByUserName = json['CompletedByUserName'] as String?
    ..modifiedByUserID = json['ModifiedByUserID'] as String?
    ..modifiedByUserEmail = json['ModifiedByUserEmail'] as String?
    ..modifiedByUserName = json['ModifiedByUserName'] as String?
    ..revision = json['Revision'] as int?
    ..result = json['Result'] as String?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..description = json['Description'] as String?
    ..descriptionHtml = json['DescriptionHtml'] as String?
    ..descriptionRichTextJson = json['DescriptionRichTextJson'] as String?
    ..roleID = json['RoleID'] as String?
    ..roleName = json['RoleName'] as String?
    ..roleNameLower = json['RoleNameLower'] as String?
    ..dueOn = json['DueOn'] as String?
    ..dueOnModifiedOn = json['DueOnModifiedOn'] as String?
    ..primaryDocument = json['PrimaryDocument'] == null
        ? null
        : Document.fromJson(json['PrimaryDocument'] as Map<String, dynamic>)
    ..otherDocuments = (json['OtherDocuments'] as List<dynamic>?)
        ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
        .toList()
    ..parentWorkTaskID = json['ParentWorkTaskID'] as String?
    ..processID = json['ProcessID'] as String?
    ..processName = json['ProcessName'] as String?
    ..processNameLower = json['ProcessNameLower'] as String?
    ..processElementID = json['ProcessElementID'] as String?
    ..processElementName = json['ProcessElementName'] as String?
    ..processElementNameLower = json['ProcessElementNameLower'] as String?
    ..reminder_7_Day = json['Reminder_7_Day'] as String?
    ..reminder_3_Day = json['Reminder_3_Day'] as String?
    ..reminder_1_Day = json['Reminder_1_Day'] as String?;
}

Map<String, dynamic> _$WorkTaskToJson(WorkTask instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('ModifiedOn', instance.modifiedOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CompletedOn', instance.completedOn);
  writeNotNull('CompletedByUserID', instance.completedByUserID);
  writeNotNull('CompletedByUserEmail', instance.completedByUserEmail);
  writeNotNull('CompletedByUserName', instance.completedByUserName);
  writeNotNull('ModifiedByUserID', instance.modifiedByUserID);
  writeNotNull('ModifiedByUserEmail', instance.modifiedByUserEmail);
  writeNotNull('ModifiedByUserName', instance.modifiedByUserName);
  writeNotNull('Revision', instance.revision);
  writeNotNull('Result', instance.result);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Description', instance.description);
  writeNotNull('DescriptionHtml', instance.descriptionHtml);
  writeNotNull('DescriptionRichTextJson', instance.descriptionRichTextJson);
  writeNotNull('RoleID', instance.roleID);
  writeNotNull('RoleName', instance.roleName);
  writeNotNull('RoleNameLower', instance.roleNameLower);
  writeNotNull('DueOn', instance.dueOn);
  writeNotNull('DueOnModifiedOn', instance.dueOnModifiedOn);
  writeNotNull('PrimaryDocument', instance.primaryDocument);
  writeNotNull('OtherDocuments', instance.otherDocuments);
  writeNotNull('ParentWorkTaskID', instance.parentWorkTaskID);
  writeNotNull('ProcessID', instance.processID);
  writeNotNull('ProcessName', instance.processName);
  writeNotNull('ProcessNameLower', instance.processNameLower);
  writeNotNull('ProcessElementID', instance.processElementID);
  writeNotNull('ProcessElementName', instance.processElementName);
  writeNotNull('ProcessElementNameLower', instance.processElementNameLower);
  writeNotNull('Reminder_7_Day', instance.reminder_7_Day);
  writeNotNull('Reminder_3_Day', instance.reminder_3_Day);
  writeNotNull('Reminder_1_Day', instance.reminder_1_Day);
  return val;
}
