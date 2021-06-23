import 'dart:convert';

import '../api_model/query_result.dart' as api_mod;
import '../nucleus_one.dart';
import '../model/work_task.dart';
import '../http.dart' as http;
import '../api_model/work_task.dart' as api_mod;
import '../../nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import '../api_model/work_task_comment.dart' as api_mod;
import '../model/work_task_comment.dart';

class NucleusOneAppWorkTasks with NucleusOneAppDependent {
  NucleusOneAppWorkTasks({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets Work Tasks.
  ///
  ///
  Future<QueryResult<WorkTaskCollection>> getWorkTasks({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.workTasks,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.WorkTaskCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: WorkTaskCollection(
          items: apiModel.results!.workTasks?.map((x) => WorkTask.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Creates one or more Work Tasks for the user.
  Future<void> createWorkTasks(WorkTaskCollection tasks) async {
    assert(tasks.items.isNotEmpty);

    final workTasks = tasks.toApiModel().workTasks;
    await http.executePostRequest(
      http.apiPaths.workTasks,
      app,
      body: jsonEncode(workTasks),
    );
  }

  /// Gets Work Tasks by Work Task Id.
  ///
  ///
  Future<QueryResult<WorkTaskCollection>> getWorkTasksByWorkTaskId(
    String workTaskId, {
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    qp['workTaskId'] = workTaskId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.workTasksFormat.replaceFirst('<workTaskId>', workTaskId),
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.WorkTaskCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: WorkTaskCollection(
          items: apiModel.results!.workTasks?.map((x) => WorkTask.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Updates a Work Task.
  ///
  /// [workTask] The Work Task to be updated.
  Future<void> updateWorkTask(WorkTask workTask) async {
    final qp = http.StandardQueryParams.get([]);
    qp['workTaskId'] = workTask.id;

    await http.executePutRequest(
      http.apiPaths.workTasksFormat.replaceFirst('<workTaskId>', workTask.id),
      app,
      body: jsonEncode(workTask.toApiModel()),
      query: qp,
    );
  }

  /// Gets comments for a work task.
  ///
  /// [workTaskId]: The document id.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<WorkTaskCommentCollection>> getWorkTaskComments({
    required String workTaskId,
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.workTasksCommentsFormat.replaceFirst('<workTaskId>', workTaskId),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.WorkTaskCommentCollection>.fromJson(jsonDecode(responseBody));
    return WorkTaskCommentCollectionQueryResult.fromApiModelWorkTaskCommentCollection(apiModel);
  }

  /// Posts comments for a work task.
  ///
  /// [workTaskId]: The work task id.
  ///
  /// [comments]: The comments to post.
  Future<void> createWorkTaskComments({
    required String workTaskId,
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      http.apiPaths.workTasksCommentsFormat.replaceFirst('<workTaskId>', workTaskId),
      app,
      body: jsonEncode({'Comments': comments}),
    );
  }
}
