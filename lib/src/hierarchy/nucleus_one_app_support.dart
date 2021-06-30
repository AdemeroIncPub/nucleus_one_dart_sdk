import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/model/support_organization.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/support_organization_tenant.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_organization_tenant.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_error_event.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../nucleus_one.dart';
import '../model/support_user.dart';
import '../http.dart' as http;
import '../api_model/support_user.dart' as api_mod;
import '../../nucleus_one_dart_sdk.dart';

class NucleusOneAppSupport with NucleusOneAppDependent {
  NucleusOneAppSupport({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets Support Users.
  ///
  ///
  Future<QueryResult<SupportUserCollection>> getSupportUsers({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.supportUsers,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.SupportUserCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: SupportUserCollection(
          items: apiModel.results!.supportUsers?.map((x) => SupportUser.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets Support Organizations.
  ///
  ///
  Future<QueryResult<SupportOrganizationCollection>> getSupportOrganizations({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.supportOrganizations,
      app,
      query: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.SupportOrganizationCollection>.fromJson(
        jsonDecode(responseBody));

    return QueryResult(
      results: SupportOrganizationCollection(
          items: apiModel.results!.supportOrganizations
              ?.map((x) => SupportOrganization.fromApiModel(x))
              .toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets Support Organization Tenants.
  ///
  ///
  Future<QueryResult<SupportOrganizationTenantCollection>> getSupportOrganizationTenants({
    required String organizationId,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.supportOrganizationsTenantsFormat
          .replaceFirst('<organizationId>', organizationId),
      app,
      query: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.SupportOrganizationTenantCollection>.fromJson(
        jsonDecode(responseBody));

    return QueryResult(
      results: SupportOrganizationTenantCollection(
          items: apiModel.results!.supportOrganizationTenants
              ?.map((x) => SupportOrganizationTenant.fromApiModel(x))
              .toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets Support Error Events.
  ///
  ///
  Future<QueryResult<SupportErrorEventCollection>> getSupportErrorEvents({
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
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);

    qp['serviceNameFilter'] = serviceNameFilter;
    qp['levelFilter'] = levelFilter;
    qp['tenantIDFilter'] = tenantIdFilter;
    qp['tenantNameFilter'] = tenantNameFilter;
    qp['userEmailFilter'] = userEmailFilter;
    qp['uniqueIdFilter'] = uniqueIdFilter;
    qp['keywordFilter'] = keywordFilter;
    qp['sortDescending'] = sortDescending;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.supportErrorEvents,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.SupportErrorEventCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: SupportErrorEventCollection(
          items: apiModel.results!.supportErrorEvents
              ?.map((x) => SupportErrorEvent.fromApiModel(x))
              .toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets the Admin Status of a support user.
  Future<void> getSupportAdminStatus() async {
    await http.executeGetRequest(
      http.apiPaths.supportAdmin,
      app,
    );
  }
}
