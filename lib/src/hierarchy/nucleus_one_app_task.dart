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

/// Performs operations on a specific task.
class NucleusOneAppTask with NucleusOneAppProjectDependent {
  /// The ID of the current task.
  final String taskId;

  /// Creates an instance of the [NucleusOneAppTask] class.
  ///
  /// [project]: The project to perform task operations on.
  ///
  /// [taskId]: The task's ID.
  NucleusOneAppTask({
    NucleusOneAppProject? project,
    required this.taskId,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets tasks by ID.
  Future<Task> get() async {
    final qp = http.StandardQueryParams.get();
    qp['taskId'] = taskId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(taskId),
      project.app,
      query: qp,
    );

    final apiModel = api_mod.Task.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(project.app, () {
      return Task.fromApiModel(apiModel);
    });
  }

  /// Gets comments for this task.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<TaskCommentCollection>> getComments({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
        (sqp) => sqp.sortDescending(sortDescending),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(taskId),
      project.app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.TaskCommentCollection>.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return TaskCommentCollectionQueryResult.fromApiModelTaskCommentCollection(apiModel);
    });
  }

  /// Posts comments on the task.
  ///
  /// [comments]: The comments to post.
  Future<void> createComments({
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      http.ApiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(taskId),
      app: project.app,
      body: jsonEncode({'Comments': comments}),
    );
  }
}

/// Performs task operations for a project.
class NucleusOneAppTasks with NucleusOneAppProjectDependent {
  /// Creates an instance of the [NucleusOneAppTasks] class.
  ///
  /// [project]: The project to perform task operations on.
  NucleusOneAppTasks({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets all tasks in this project.
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
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );

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
      http.ApiPaths.organizationsProjectsTasksFormat
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

  /// Creates one or more tasks.
  /// 
  /// [tasks]:  The tasks to create.
  Future<void> create(TaskCollection tasks) async {
    assert(tasks.items.isNotEmpty);

    final apiModel = tasks.toApiModel().tasks;
    await http.executePostRequest(
      http.ApiPaths.organizationsProjectsTasksFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode(apiModel),
    );
  }

  /// Updates a task.
  ///
  /// [task]: The task to be updated.
  Future<void> update(Task task) async {
    final qp = http.StandardQueryParams.get();
    qp['taskId'] = task.id;

    await http.executePutRequest(
      http.ApiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder(task.id),
      project.app,
      body: jsonEncode(task.toApiModel()),
      query: qp,
    );
  }
}
