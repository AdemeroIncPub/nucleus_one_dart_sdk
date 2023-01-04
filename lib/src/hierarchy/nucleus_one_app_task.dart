import 'dart:convert';

import '../api_model/query_result.dart' as api_mod;
import '../common/get_it.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../model/task.dart';
import '../http.dart' as http;
import '../api_model/task.dart' as api_mod;
import '../../nucleus_one_dart_sdk.dart';
import '../common/model.dart';
import '../api_model/task_comment.dart' as api_mod;
import '../model/task_comment.dart';

class NucleusOneAppTask with NucleusOneAppProjectDependent {
  final String id;

  NucleusOneAppTask({
    NucleusOneAppProject? project,
    required this.id,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets Tasks by id.
  Future<Task> get() async {
    final qp = http.StandardQueryParams.get([]);
    qp['taskId'] = id;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(id),
      project.app,
      query: qp,
    );

    final apiModel = api_mod.Task.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(project.app, () {
      return Task.fromApiModel(apiModel);
    });
  }

  /// Gets comments for a task.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<TaskCommentCollection>> getComments({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(id),
      project.app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.TaskCommentCollection>.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return TaskCommentCollectionQueryResult.fromApiModelTaskCommentCollection(apiModel);
    });
  }

  /// Posts comments for a task.
  ///
  /// [comments]: The comments to post.
  Future<void> createComments({
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      http.apiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(id),
      app: project.app,
      body: jsonEncode({'Comments': comments}),
    );
  }
}

class NucleusOneAppTasks with NucleusOneAppProjectDependent {
  NucleusOneAppTasks({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets all Tasks in this project.
  ///
  /// [activeOnly]: Only return active tasks.
  ///
  /// [completedOnly]: Only return completed tasks.
  ///
  /// [deniedOnly]: Only return denied tasks.
  Future<QueryResult<TaskCollection>> get({
    bool? activeOnly,
    bool? completedOnly,
    bool? deniedOnly,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    if (activeOnly != null) {
      qp['activeOnly'] = activeOnly;
    }
    if (completedOnly != null) {
      qp['completedOnly'] = completedOnly;
    }
    if (deniedOnly != null) {
      qp['deniedOnly'] = deniedOnly;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsTasksFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      project.app,
      query: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.TaskCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      app: project.app,
      results: TaskCollection.fromApiModel(apiModel.results!, app: project.app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Creates one or more Tasks.
  Future<void> create(TaskCollection tasks) async {
    assert(tasks.items.isNotEmpty);

    final apiModel = tasks.toApiModel().tasks;
    await http.executePostRequest(
      http.apiPaths.organizationsProjectsTasksFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode(apiModel),
    );
  }

  /// Updates a Task.
  ///
  /// [task]: The Task to be updated.
  Future<void> update(Task task) async {
    final qp = http.StandardQueryParams.get([]);
    qp['taskId'] = task.id;

    await http.executePutRequest(
      http.apiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(task.id),
      project.app,
      body: jsonEncode(task.toApiModel()),
      query: qp,
    );
  }
}
