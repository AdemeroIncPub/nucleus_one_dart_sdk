import 'dart:convert';
import '../api_model/query_result.dart' as api_mod;
import '../nucleus_one.dart';
import '../model/approval.dart';
import '../http.dart' as http;
import '../api_model/approval.dart' as api_mod;
import '../../nucleus_one_dart_sdk.dart';

class NucleusOneAppApprovals with NucleusOneAppDependent {
  NucleusOneAppApprovals({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
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
      http.apiPaths.approvals,
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
