import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/query_result.dart' as api_mod;
import '../api_model/support_error_event.dart' as api_mod;
import '../api_model/support_organization.dart' as api_mod;
import '../api_model/support_user.dart' as api_mod;
import '../common/get_it.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/support_error_event.dart';
import '../model/support_organization.dart';
import '../model/support_user.dart';
import '../nucleus_one.dart';

/// Performs support operations.
class NucleusOneAppSupport with NucleusOneAppDependent {
  /// Creates an instance of the [NucleusOneAppSupport] class.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  NucleusOneAppSupport({
    NucleusOneApp? app,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  /// Gets all users, by page.
  /// 
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<SupportUserCollection>> getUsers({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.supportUsers,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.SupportUserCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult(
        results: SupportUserCollection(
            items:
                apiModel.results!.supportUsers?.map((x) => SupportUser.fromApiModel(x)).toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }

  /// Gets all organizations, by page.
  /// 
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<SupportOrganizationCollection>> getOrganizations({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.supportOrganizations,
      app,
      query: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.SupportOrganizationCollection>.fromJson(
        jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult(
        results: SupportOrganizationCollection(
            items: apiModel.results!.supportOrganizations
                ?.map((x) => SupportOrganization.fromApiModel(x))
                .toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }

  /// Gets all error events, by page.
  /// 
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  /// [serviceNameFilter]: 
  /// 
  /// [levelFilter]: 
  /// 
  /// [tenantIdFilter]: 
  /// 
  /// [tenantNameFilter]: 
  /// 
  /// [userEmailFilter]: 
  /// 
  /// [uniqueIdFilter]: 
  /// 
  /// [keywordFilter]: 
  /// 
  /// [sortDescending]: 
  /// 
  Future<QueryResult<SupportErrorEventCollection>> getErrorEvents({
    String? cursor,
    String? serviceNameFilter,
    String? levelFilter,
    String? tenantIdFilter,
    String? tenantNameFilter,
    String? userEmailFilter,
    String? uniqueIdFilter,
    String? keywordFilter,
    bool? sortDescending,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );

    qp['serviceNameFilter'] = serviceNameFilter;
    qp['levelFilter'] = levelFilter;
    qp['tenantIDFilter'] = tenantIdFilter;
    qp['tenantNameFilter'] = tenantNameFilter;
    qp['userEmailFilter'] = userEmailFilter;
    qp['uniqueIdFilter'] = uniqueIdFilter;
    qp['keywordFilter'] = keywordFilter;
    qp['sortDescending'] = sortDescending;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.supportErrorEvents,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.SupportErrorEventCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult(
        results: SupportErrorEventCollection(
            items: apiModel.results!.supportErrorEvents
                ?.map((x) => SupportErrorEvent.fromApiModel(x))
                .toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }

  /// Gets the admin status of a support user.  If the current user is an admin, true is returned;
  /// otherwise, false.
  Future<bool> getAdminStatus() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.supportAdmin,
      app,
    );
    return responseBody.parseBool();
  }
}
