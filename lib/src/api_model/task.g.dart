// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCollection _$TaskCollectionFromJson(Map<String, dynamic> json) => TaskCollection()
  ..tasks = (json['Tasks'] as List<dynamic>?)
      ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TaskCollectionToJson(TaskCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Tasks', instance.tasks);
  return val;
}

Task _$TaskFromJson(Map<String, dynamic> json) => Task()
  ..id = json['ID'] as String?
  ..organizationID = json['OrganizationID'] as String?
  ..projectID = json['ProjectID'] as String?
  ..projectName = json['ProjectName'] as String?
  ..projectAccessType = json['ProjectAccessType'] as String?
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
  ..assignmentUserEmail = json['AssignmentUserEmail'] as String?
  ..assignmentUserName = json['AssignmentUserName'] as String?
  ..assignmentUserNameLower = json['AssignmentUserNameLower'] as String?
  ..dueOn = json['DueOn'] as String?
  ..dueOnModifiedOn = json['DueOnModifiedOn'] as String?
  ..primaryDocument = json['PrimaryDocument'] == null
      ? null
      : Document.fromJson(json['PrimaryDocument'] as Map<String, dynamic>)
  ..otherDocuments = (json['OtherDocuments'] as List<dynamic>?)
      ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
      .toList()
  ..parentTaskID = json['ParentTaskID'] as String?
  ..processID = json['ProcessID'] as String?
  ..processName = json['ProcessName'] as String?
  ..processNameLower = json['ProcessNameLower'] as String?
  ..processElementID = json['ProcessElementID'] as String?
  ..processElementName = json['ProcessElementName'] as String?
  ..processElementNameLower = json['ProcessElementNameLower'] as String?
  ..reminder7Day = json['Reminder_7_Day'] as String?
  ..reminder3Day = json['Reminder_3_Day'] as String?
  ..reminder1Day = json['Reminder_1_Day'] as String?;

Map<String, dynamic> _$TaskToJson(Task instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('ProjectID', instance.projectID);
  writeNotNull('ProjectName', instance.projectName);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
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
  writeNotNull('AssignmentUserEmail', instance.assignmentUserEmail);
  writeNotNull('AssignmentUserName', instance.assignmentUserName);
  writeNotNull('AssignmentUserNameLower', instance.assignmentUserNameLower);
  writeNotNull('DueOn', instance.dueOn);
  writeNotNull('DueOnModifiedOn', instance.dueOnModifiedOn);
  writeNotNull('PrimaryDocument', instance.primaryDocument);
  writeNotNull('OtherDocuments', instance.otherDocuments);
  writeNotNull('ParentTaskID', instance.parentTaskID);
  writeNotNull('ProcessID', instance.processID);
  writeNotNull('ProcessName', instance.processName);
  writeNotNull('ProcessNameLower', instance.processNameLower);
  writeNotNull('ProcessElementID', instance.processElementID);
  writeNotNull('ProcessElementName', instance.processElementName);
  writeNotNull('ProcessElementNameLower', instance.processElementNameLower);
  writeNotNull('Reminder_7_Day', instance.reminder7Day);
  writeNotNull('Reminder_3_Day', instance.reminder3Day);
  writeNotNull('Reminder_1_Day', instance.reminder1Day);
  return val;
}
