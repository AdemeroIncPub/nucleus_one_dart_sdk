import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/model/document.dart';

import '../api_model/work_task.dart' as api_mod;
import '../nucleus_one.dart';

class WorkTaskCollection extends EntityCollection<WorkTask, api_mod.WorkTaskCollection> {
  WorkTaskCollection({
    NucleusOneAppInternal? app,
    List<WorkTask>? items,
  }) : super(app: app, items: items);

  factory WorkTaskCollection.fromApiModel(api_mod.WorkTaskCollection apiModel) {
    return WorkTaskCollection(
        items: apiModel.workTasks?.map((x) => WorkTask.fromApiModel(x)).toList());
  }

  @override
  api_mod.WorkTaskCollection toApiModel() {
    return api_mod.WorkTaskCollection()..workTasks = items.map((x) => x.toApiModel()).toList();
  }
}

class WorkTask with NucleusOneAppDependent {
  WorkTask._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.modifiedOn,
      required this.createdByUserID,
      required this.createdByUserEmail,
      required this.createdByUserName,
      required this.completedOn,
      required this.completedByUserID,
      required this.completedByUserEmail,
      required this.completedByUserName,
      required this.modifiedByUserID,
      required this.modifiedByUserEmail,
      required this.modifiedByUserName,
      required this.revision,
      required this.result,
      required this.name,
      required this.nameLower,
      required this.description,
      required this.descriptionHtml,
      required this.descriptionRichTextJson,
      required this.roleID,
      required this.roleName,
      required this.roleNameLower,
      required this.dueOn,
      required this.dueOnModifiedOn,
      required this.primaryDocument,
      required this.otherDocuments,
      required this.parentWorkTaskID,
      required this.processID,
      required this.processName,
      required this.processNameLower,
      required this.processElementID,
      required this.processElementName,
      required this.processElementNameLower,
      required this.reminder_7_Day,
      required this.reminder_3_Day,
      required this.reminder_1_Day}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory WorkTask.fromApiModel(api_mod.WorkTask apiModel) {
    return WorkTask._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        modifiedOn: apiModel.modifiedOn!,
        createdByUserID: apiModel.createdByUserID!,
        createdByUserEmail: apiModel.createdByUserEmail!,
        createdByUserName: apiModel.createdByUserName!,
        completedOn: apiModel.completedOn!,
        completedByUserID: apiModel.completedByUserID!,
        completedByUserEmail: apiModel.completedByUserEmail!,
        completedByUserName: apiModel.completedByUserName!,
        modifiedByUserID: apiModel.modifiedByUserID!,
        modifiedByUserEmail: apiModel.modifiedByUserEmail!,
        modifiedByUserName: apiModel.modifiedByUserName!,
        revision: apiModel.revision!,
        result: apiModel.result!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        description: apiModel.description!,
        descriptionHtml: apiModel.descriptionHtml!,
        descriptionRichTextJson: apiModel.descriptionRichTextJson!,
        roleID: apiModel.roleID!,
        roleName: apiModel.roleName!,
        roleNameLower: apiModel.roleNameLower!,
        dueOn: apiModel.dueOn!,
        dueOnModifiedOn: apiModel.dueOnModifiedOn!,
        primaryDocument: Document.fromApiModel(apiModel.primaryDocument!),
        otherDocuments: apiModel.otherDocuments?.map((x) => Document.fromApiModel(x)).toList(),
        parentWorkTaskID: apiModel.parentWorkTaskID!,
        processID: apiModel.processID!,
        processName: apiModel.processName!,
        processNameLower: apiModel.processNameLower!,
        processElementID: apiModel.processElementID!,
        processElementName: apiModel.processElementName!,
        processElementNameLower: apiModel.processElementNameLower!,
        reminder_7_Day: apiModel.reminder_7_Day!,
        reminder_3_Day: apiModel.reminder_3_Day!,
        reminder_1_Day: apiModel.reminder_1_Day!);
  }

  String id;

  String createdOn;

  String modifiedOn;

  String createdByUserID;

  String createdByUserEmail;

  String createdByUserName;

  String completedOn;

  String completedByUserID;

  String completedByUserEmail;

  String completedByUserName;

  String modifiedByUserID;

  String modifiedByUserEmail;

  String modifiedByUserName;

  int revision;

  String result;

  String name;

  String nameLower;

  String description;

  String descriptionHtml;

  String descriptionRichTextJson;

  String roleID;

  String roleName;

  String roleNameLower;

  String dueOn;

  String dueOnModifiedOn;

  Document primaryDocument;

  List<Document>? otherDocuments;

  String parentWorkTaskID;

  String processID;

  String processName;

  String processNameLower;

  String processElementID;

  String processElementName;

  String processElementNameLower;

  String reminder_7_Day;

  String reminder_3_Day;

  String reminder_1_Day;

  api_mod.WorkTask toApiModel() {
    return api_mod.WorkTask()
      ..id = id
      ..createdOn = createdOn
      ..modifiedOn = modifiedOn
      ..createdByUserID = createdByUserID
      ..createdByUserEmail = createdByUserEmail
      ..createdByUserName = createdByUserName
      ..completedOn = completedOn
      ..completedByUserID = completedByUserID
      ..completedByUserEmail = completedByUserEmail
      ..completedByUserName = completedByUserName
      ..modifiedByUserID = modifiedByUserID
      ..modifiedByUserEmail = modifiedByUserEmail
      ..modifiedByUserName = modifiedByUserName
      ..revision = revision
      ..result = result
      ..name = name
      ..nameLower = nameLower
      ..description = description
      ..descriptionHtml = descriptionHtml
      ..descriptionRichTextJson = descriptionRichTextJson
      ..roleID = roleID
      ..roleName = roleName
      ..roleNameLower = roleNameLower
      ..dueOn = dueOn
      ..dueOnModifiedOn = dueOnModifiedOn
      ..primaryDocument = primaryDocument.toApiModel()
      ..otherDocuments = otherDocuments!.map((x) => x.toApiModel()).toList()
      ..parentWorkTaskID = parentWorkTaskID
      ..processID = processID
      ..processName = processName
      ..processNameLower = processNameLower
      ..processElementID = processElementID
      ..processElementName = processElementName
      ..processElementNameLower = processElementNameLower
      ..reminder_7_Day = reminder_7_Day
      ..reminder_3_Day = reminder_3_Day
      ..reminder_1_Day = reminder_1_Day;
  }
}
