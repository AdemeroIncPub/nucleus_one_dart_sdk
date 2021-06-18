import 'dart:convert';

import '../api_model/query_result.dart' as api_mod;
import '../nucleus_one.dart';
import '../model/work_task.dart';
import '../http.dart' as http;
import '../api_model/work_task.dart' as api_mod;
import '../../nucleus_one_dart_sdk.dart';

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
  Future<void> postWorkTasks(WorkTaskCollection tasks) async {
    assert(tasks.items.isNotEmpty);

    final workTasks = tasks.toApiModel().workTasks;
    await http.executePostRequest(
      http.apiPaths.dashboardWidgets,
      app,
      body: jsonEncode(workTasks),
    );
  }
}
