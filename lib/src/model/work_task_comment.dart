import '../common/model.dart';

import '../api_model/work_task_comment.dart' as api_mod;
import '../nucleus_one.dart';
import 'work_task_event.dart';

class WorkTaskCommentCollection
    extends EntityCollection<WorkTaskEvent, api_mod.WorkTaskCommentCollection> {
  WorkTaskCommentCollection({
    NucleusOneAppInternal? app,
    List<WorkTaskEvent>? items,
  }) : super(app: app, items: items);

  factory WorkTaskCommentCollection.fromApiModel(api_mod.WorkTaskCommentCollection apiModel) {
    return WorkTaskCommentCollection(
        items: apiModel.workTaskEvents?.map((x) => WorkTaskEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.WorkTaskCommentCollection toApiModel() {
    return api_mod.WorkTaskCommentCollection()
      ..workTaskEvents = items.map((x) => x.toApiModel()).toList();
  }
}
