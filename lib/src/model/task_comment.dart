import '../common/model.dart';

import '../api_model/task_comment.dart' as api_mod;
import '../nucleus_one.dart';
import 'task_event.dart';

class TaskCommentCollection extends EntityCollection<TaskEvent, api_mod.TaskCommentCollection> {
  TaskCommentCollection({
    NucleusOneApp? app,
    List<TaskEvent>? items,
  }) : super(app: app, items: items);

  factory TaskCommentCollection.fromApiModel(
    api_mod.TaskCommentCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return TaskCommentCollection(
        items: apiModel.taskEvents?.map((x) => TaskEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.TaskCommentCollection toApiModel() {
    return api_mod.TaskCommentCollection()..taskEvents = items.map((x) => x.toApiModel()).toList();
  }
}
