import '../api_model/task.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'document.dart';

class TaskCollection extends EntityCollection<Task, api_mod.TaskCollection> {
  TaskCollection._({
    NucleusOneApp? app,
    List<Task>? items,
  }) : super(app: app, items: items);

  factory TaskCollection.fromApiModel(
    api_mod.TaskCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return TaskCollection._(
      app: app,
      items: apiModel.tasks?.map((x) => Task.fromApiModel(x, app: app)).toList(),
    );
  }

  @override
  api_mod.TaskCollection toApiModel() {
    return api_mod.TaskCollection()..tasks = items.map((x) => x.toApiModel()).toList();
  }
}

class Task with NucleusOneAppDependent {
  Task._({
    NucleusOneApp? app,
    required this.id,
    required this.organizationID,
    required this.projectID,
    required this.projectName,
    required this.projectAccessType,
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
    required this.assignmentUserEmail,
    required this.assignmentUserName,
    required this.assignmentUserNameLower,
    required this.dueOn,
    required this.dueOnModifiedOn,
    required this.primaryDocument,
    required this.otherDocuments,
    required this.parentTaskID,
    required this.processID,
    required this.processName,
    required this.processNameLower,
    required this.processElementID,
    required this.processElementName,
    required this.processElementNameLower,
    required this.reminder_7_Day,
    required this.reminder_3_Day,
    required this.reminder_1_Day,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory Task.fromApiModel(
    api_mod.Task apiModel, {
    NucleusOneApp? app,
  }) {
    return Task._(
        app: app,
        id: apiModel.id!,
        organizationID: apiModel.organizationID!,
        projectID: apiModel.projectID!,
        projectName: apiModel.projectName!,
        projectAccessType: apiModel.projectAccessType!,
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
        assignmentUserEmail: apiModel.assignmentUserEmail!,
        assignmentUserName: apiModel.assignmentUserName!,
        assignmentUserNameLower: apiModel.assignmentUserNameLower!,
        dueOn: apiModel.dueOn!,
        dueOnModifiedOn: apiModel.dueOnModifiedOn!,
        primaryDocument: Document.fromApiModel(apiModel.primaryDocument!, app: app),
        otherDocuments:
            apiModel.otherDocuments!.map((x) => Document.fromApiModel(x, app: app)).toList(),
        parentTaskID: apiModel.parentTaskID!,
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

  String organizationID;

  String projectID;

  String projectName;

  String projectAccessType;

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

  String assignmentUserEmail;

  String assignmentUserName;

  String assignmentUserNameLower;

  String dueOn;

  String dueOnModifiedOn;

  Document primaryDocument;

  List<Document>? otherDocuments;

  String parentTaskID;

  String processID;

  String processName;

  String processNameLower;

  String processElementID;

  String processElementName;

  String processElementNameLower;

  String reminder_7_Day;

  String reminder_3_Day;

  String reminder_1_Day;

  api_mod.Task toApiModel() {
    return api_mod.Task()
      ..id = id
      ..organizationID = organizationID
      ..projectID = projectID
      ..projectName = projectName
      ..projectAccessType = projectAccessType
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
      ..assignmentUserEmail = assignmentUserEmail
      ..assignmentUserName = assignmentUserName
      ..assignmentUserNameLower = assignmentUserNameLower
      ..dueOn = dueOn
      ..dueOnModifiedOn = dueOnModifiedOn
      ..primaryDocument = primaryDocument.toApiModel()
      ..otherDocuments = otherDocuments?.map((x) => x.toApiModel()).toList()
      ..parentTaskID = parentTaskID
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
