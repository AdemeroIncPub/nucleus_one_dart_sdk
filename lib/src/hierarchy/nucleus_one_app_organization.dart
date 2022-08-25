import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../api_model/query_result.dart' as api_mod;
import '../api_model/organization_permissions.dart' as api_mod;
import '../api_model/organization_project.dart' as api_mod;
import '../api_model/subscription_details.dart' as api_mod;
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/organization_permissions.dart';
import '../model/organization_project.dart';
import '../model/query_result.dart';
import '../model/subscription_details.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';
import 'nucleus_one_app_subscriptions.dart';

class NucleusOneAppOrganization with NucleusOneAppDependent {
  final String id;

  NucleusOneAppOrganization({
    NucleusOneApp? app,
    required this.id,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();

    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
  }

  /// Project
  NucleusOneAppProject project(String projectId) {
    return NucleusOneAppProject(
      organization: this,
      id: projectId,
    );
  }

  /// Subscriptions
  NucleusOneAppSubscriptions subscriptions() {
    return NucleusOneAppSubscriptions(
      organization: this,
    );
  }

  /// Gets organization's tenants.
  ///
  /// [organizationId] The id of the organization.
  Future<OrganizationPermissions> getPermissions({
    required String organizationId,
  }) async {
    if (organizationId.isEmpty) {
      throw ArgumentError.value(organizationId, 'organizationId', 'Value cannot be blank.');
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsPermissionsFormat.replaceFirst('<organizationId>', organizationId),
      app,
    );

    final apiModel = api_mod.OrganizationPermissions.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return OrganizationPermissions.fromApiModel(apiModel);
    });
  }

  /// Gets an organization's subscription.
  ///
  /// [organizationId]: The id of the organization.
  Future<SubscriptionDetails> getOrganizationSubscription({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsSubscriptionsFormat.replaceOrganizationPlaceholder(id),
      app,
    );
    final apiModel = api_mod.SubscriptionDetails.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SubscriptionDetails.fromApiModel(apiModel);
    });
  }

  /// Gets organization projects, by page.
  ///
  /// [organizationId]: The id of the organization.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [projectAccessType]: Can be any of the following values:
  /// - GlobalAssignments_MemberContentByDefault
  /// - MembersOnlyAssignments_MemberContentByAssignment
  ///
  /// [includeProjectId]: Includes a specific project in the results.
  ///
  /// [nameFilter]: Filters results to only those projects starting with this value.
  ///
  /// [getAll]: Returns all projects in a single results, without using paging.
  ///
  /// [adminOnly]:
  Future<QueryResult<OrganizationProjectCollection>> getProjects({
    required String organizationId,
    String? cursor,
    String? projectAccessType,
    String? includeProjectId,
    String? nameFilter,
    bool? getAll,
    bool? adminOnly,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (projectAccessType != null) {
      qp['projectAccessType'] = projectAccessType;
    }
    if (includeProjectId != null) {
      qp['includeProjectId'] = includeProjectId;
    }
    if (nameFilter != null) {
      qp['nameFilter'] = nameFilter;
    }
    if (getAll != null) {
      qp['getAll'] = getAll;
    }
    if (adminOnly != null) {
      qp['adminOnly'] = adminOnly;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsFormat.replaceOrganizationPlaceholder(organizationId),
      app,
      query: qp,
    );
    final apiModel = api_mod.QueryResult<api_mod.OrganizationProjectCollection>.fromJson(
        jsonDecode(responseBody));

    return await DefineN1AppInScope(app, () {
      return QueryResult(
        results: OrganizationProjectCollection(
            items: apiModel.results!.projects!
                .map((x) => OrganizationProject.fromApiModel(x))
                .toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }
}
