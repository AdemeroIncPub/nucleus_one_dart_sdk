import '../api_model/task_event.dart' as api_mod;
import '../common/get_it.dart';
import '../nucleus_one.dart';
import '../common/model.dart';

class TaskEventCollection extends EntityCollection<TaskEvent, api_mod.TaskEventCollection> {
  TaskEventCollection({
    NucleusOneApp? app,
    List<TaskEvent>? items,
  }) : super(app: app, items: items);

  factory TaskEventCollection.fromApiModel(
    api_mod.TaskEventCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return TaskEventCollection(
        items: apiModel.taskEvents?.map((x) => TaskEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.TaskEventCollection toApiModel() {
    return api_mod.TaskEventCollection()..taskEvents = items.map((x) => x.toApiModel()).toList();
  }
}

class TaskEvent extends Entity with NucleusOneAppDependent {
  TaskEvent._({
    NucleusOneApp? app,
    required this.id,
    required this.taskID,
    required this.createdOn,
    required this.createdByUserID,
    required this.createdByUserName,
    required this.createdByUserEmail,
    required this.modifiedOn,
    required this.type,
    required this.taskRevision,
    required this.detailJson,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory TaskEvent.fromApiModel(
    api_mod.TaskEvent apiModel, {
    NucleusOneApp? app,
  }) {
    return TaskEvent._(
      app: app,
      id: apiModel.id!,
      taskID: apiModel.taskID!,
      createdOn: apiModel.createdOn!,
      createdByUserID: apiModel.createdByUserID!,
      createdByUserName: apiModel.createdByUserName!,
      createdByUserEmail: apiModel.createdByUserEmail!,
      modifiedOn: apiModel.modifiedOn!,
      type: apiModel.type!,
      taskRevision: apiModel.taskRevision!,
      detailJson: apiModel.detailJson!,
    );
  }

  String id;

  String taskID;

  String createdOn;

  String createdByUserID;

  String createdByUserName;

  String createdByUserEmail;

  String modifiedOn;

  String type;

  int taskRevision;

  String detailJson;

  @override
  api_mod.TaskEvent toApiModel() {
    return api_mod.TaskEvent()
      ..id = id
      ..taskID = taskID
      ..createdOn = createdOn
      ..createdByUserID = createdByUserID
      ..createdByUserName = createdByUserName
      ..createdByUserEmail = createdByUserEmail
      ..modifiedOn = modifiedOn
      ..type = type
      ..taskRevision = taskRevision
      ..detailJson = detailJson;
  }
}
