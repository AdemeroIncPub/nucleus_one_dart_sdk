import 'dart:convert';

import '../api_model/approval.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/string.dart';
import '../http.dart' as http;
import '../model/approval.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';

class NucleusOneAppApprovals with NucleusOneAppDependent {
  final NucleusOneAppProject project;

  NucleusOneAppApprovals({
    required this.project,
  }) {
    app = project.app;
  }

  /// Declines a document.
  ///
  ///
  Future<void> declineDocument({List<String>? ids}) async {
    final reqBody = {'IDs': ids};

    await http.executePostRequest(
      http.apiPaths.organizationsProjectsApprovalActionsDeclineFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Denies a document.
  ///
  ///
  Future<void> denyDocument({List<String>? ids}) async {
    final reqBody = {'IDs': ids};

    await http.executePostRequest(
      http.apiPaths.organizationsProjectsApprovalActionsDenyFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Approves a document.
  ///
  ///
  Future<void> approveDocument({List<String>? ids}) async {
    final reqBody = {'IDs': ids};

    await http.executePostRequest(
      http.apiPaths.organizationsProjectsApprovalActionsApproveFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Gets Approvals.
  ///
  ///
  Future<QueryResult<ApprovalCollection>> getApprovals({
    String? processElementId,
    bool? sortDescending,
    String? cursor,
    String? processId,
    String? sortType,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    qp['processElementID'] = processElementId;
    qp['sortDescending'] = sortDescending;
    qp['processID'] = processId;
    qp['sortType'] = sortType;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsApprovalsFormat.replaceOrganizationAndProjectPlaceholders(project),
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.ApprovalCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: ApprovalCollection(
          items: apiModel.results!.approvals?.map((x) => Approval.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}
