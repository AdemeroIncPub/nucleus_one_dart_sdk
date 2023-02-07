import 'dart:convert';

import '../api_model/approval.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/get_it.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/approval.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';

/// Performs approval process operations for a project.
class NucleusOneAppApprovals with NucleusOneAppProjectDependent {
  /// Creates an instance of the [NucleusOneAppApprovals] class.
  ///
  /// [project]: The project to perform approval process operations on.
  NucleusOneAppApprovals({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Declines documents, by ID.
  ///
  /// [documentIds]: A list of document IDs.
  Future<void> declineDocuments({
    List<String>? documentIds,
  }) async {
    final reqBody = {'IDs': documentIds};

    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsApprovalActionsDeclineFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode(reqBody),
    );
  }

  /// Denies documents, by ID.
  ///
  /// [documentIds]: A list of document IDs.
  Future<void> denyDocuments({
    List<String>? documentIds,
  }) async {
    final reqBody = {'IDs': documentIds};

    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsApprovalActionsDenyFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode(reqBody),
    );
  }

  /// Approves documents, by ID.
  ///
  /// [documentIds]: A list of document IDs.
  Future<void> approveDocuments({
    List<String>? documentIds,
  }) async {
    final reqBody = {'IDs': documentIds};

    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsApprovalActionsApproveFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode(reqBody),
    );
  }

  /// Gets approvals assigned to the current user, by page.
  ///
  /// [processId]: The approval process ID.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  ///
  /// [sortType]: How sorting should be performed.
  Future<QueryResult<ApprovalCollection, api_mod.ApprovalCollection>> getApprovals({
    String? processId,
    String? cursor,
    String? sortType,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    qp['processID'] = processId;
    qp['sortType'] = sortType;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsApprovalsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      queryParams: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.ApprovalCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(project.app, () {
      return QueryResult(
        results: ApprovalCollection(
            items: apiModel.results!.approvals?.map((x) => Approval.fromApiModel(x)).toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }
}
