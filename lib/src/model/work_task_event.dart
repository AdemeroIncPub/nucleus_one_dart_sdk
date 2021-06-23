import 'package:get_it/get_it.dart';

import '../api_model/work_task_event.dart' as api_mod;
import '../nucleus_one.dart';
import '../common/model.dart';

class WorkTaskEventCollection
    extends EntityCollection<WorkTaskEvent, api_mod.WorkTaskEventCollection> {
  WorkTaskEventCollection({
    NucleusOneAppInternal? app,
    List<WorkTaskEvent>? items,
  }) : super(app: app, items: items);

  factory WorkTaskEventCollection.fromApiModel(api_mod.WorkTaskEventCollection apiModel) {
    return WorkTaskEventCollection(
        items: apiModel.workTaskEvents?.map((x) => WorkTaskEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.WorkTaskEventCollection toApiModel() {
    return api_mod.WorkTaskEventCollection()
      ..workTaskEvents = items.map((x) => x.toApiModel()).toList();
  }
}

class WorkTaskEvent with NucleusOneAppDependent {
  WorkTaskEvent._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.workTaskID,
      required this.createdOn,
      required this.createdByUserID,
      required this.createdByUserName,
      required this.createdByUserEmail,
      required this.modifiedOn,
      required this.type,
      required this.workTaskRevision,
      required this.detailJson}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory WorkTaskEvent.fromApiModel(api_mod.WorkTaskEvent apiModel) {
    return WorkTaskEvent._(
        id: apiModel.id!,
        workTaskID: apiModel.workTaskID!,
        createdOn: apiModel.createdOn!,
        createdByUserID: apiModel.createdByUserID!,
        createdByUserName: apiModel.createdByUserName!,
        createdByUserEmail: apiModel.createdByUserEmail!,
        modifiedOn: apiModel.modifiedOn!,
        type: apiModel.type!,
        workTaskRevision: apiModel.workTaskRevision!,
        detailJson: apiModel.detailJson!);
  }

  String id;

  String workTaskID;

  String createdOn;

  String createdByUserID;

  String createdByUserName;

  String createdByUserEmail;

  String modifiedOn;

  String type;

  int workTaskRevision;

  String detailJson;

  api_mod.WorkTaskEvent toApiModel() {
    return api_mod.WorkTaskEvent()
      ..id = id
      ..workTaskID = workTaskID
      ..createdOn = createdOn
      ..createdByUserID = createdByUserID
      ..createdByUserName = createdByUserName
      ..createdByUserEmail = createdByUserEmail
      ..modifiedOn = modifiedOn
      ..type = type
      ..workTaskRevision = workTaskRevision
      ..detailJson = detailJson;
  }
}
