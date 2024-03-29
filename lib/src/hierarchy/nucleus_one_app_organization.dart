import 'dart:convert';

import '../api_model/document_subscription_for_client.dart' as api_mod;
import '../api_model/organization_membership_package.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/organization_permissions.dart' as api_mod;
import '../api_model/organization_project.dart' as api_mod;
import '../api_model/subscription_details.dart' as api_mod;
import '../common/get_it.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/document_subscription_for_client.dart';
import '../model/organization_membership_package.dart';
import '../model/organization_permissions.dart';
import '../model/organization_project.dart';
import '../model/query_result.dart';
import '../model/subscription_details.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';
import 'nucleus_one_app_subscriptions.dart';

/// Performs organization operations.
class NucleusOneAppOrganization with NucleusOneAppDependent {
  /// The organization ID.
  final String id;

  /// Creates an instance of the [NucleusOneAppProject] class.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [id]: The organization's ID.
  NucleusOneAppOrganization({
    NucleusOneApp? app,
    required this.id,
  }) {
    this.app = getEffectiveNucleusOneApp(app);

    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
  }

  /// Gets a [NucleusOneAppProject] instance, which can be used to perform project operations for
  /// this organization.
  NucleusOneAppProject project(String projectId) {
    return NucleusOneAppProject(
      organization: this,
      id: projectId,
    );
  }

  /// Gets a [NucleusOneAppSubscriptions] instance, which can be used to perform subscription
  /// operations for this organization.
  NucleusOneAppSubscriptions subscriptions() {
    return NucleusOneAppSubscriptions(
      organization: this,
    );
  }

  /// Gets the current user's permissions within this organization.
  Future<OrganizationPermissions> getPermissions() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsPermissionsFormat.replaceOrgIdPlaceholder(id),
      app: app,
    );

    final apiModel = api_mod.OrganizationPermissions.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return OrganizationPermissions.fromApiModel(apiModel);
    });
  }

  /// Gets the current user's document subscriptions within this organization.
  Future<
      QueryResult<DocumentSubscriptionForClientCollection,
          api_mod.DocumentSubscriptionForClientCollection>> getDocumentSubscriptions() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsOrganizationDocumentSubscriptionsFormat
          .replaceOrgIdPlaceholder(id),
      app: app,
    );

    final apiModel = api_mod.QueryResult<api_mod.DocumentSubscriptionForClientCollection>.fromJson(
        jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult(
        results: DocumentSubscriptionForClientCollection(
            items: apiModel.results!.documentSubscriptions
                ?.map((x) => DocumentSubscriptionForClient.fromApiModel(x))
                .toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }

  /// Gets an organization's subscription.
  ///
  /// [organizationId]: The organization's ID.
  Future<SubscriptionDetails> getOrganizationSubscription({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath:
          http.ApiPaths.organizationsSubscriptionsFormat.replaceOrgIdPlaceholder(id),
      app: app,
    );
    final apiModel = api_mod.SubscriptionDetails.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return SubscriptionDetails.fromApiModel(apiModel);
    });
  }

  /// Gets a project within this organization, by ID.
  ///
  /// [projectId]: The organization's project ID.
  Future<OrganizationProject> getProject({
    required String projectId,
  }) async {
    final qp = http.StandardQueryParams.get();

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsProjectFormat
          .replaceOrgIdAndProjectIdPlaceholders(id, projectId),
      app: app,
      queryParams: qp,
    );
    final apiModel = api_mod.OrganizationProject.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return OrganizationProject.fromApiModel(apiModel);
    });
  }

  /// Gets projects that the current user is a member of, by page.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  ///
  /// [projectAccessType]: Can be any of the following values:
  /// - GlobalAssignments_MemberContentByDefault
  /// - MembersOnlyAssignments_MemberContentByAssignment
  ///
  /// [nameFilter]: Filters results to only those projects starting with this value.
  ///
  /// [getAll]: Returns all projects in a single results, without using paging.
  ///
  /// [adminOnly]: If true, only projects that the current user is an administrator of will be
  /// returned.
  Future<QueryResult<OrganizationProjectCollection, api_mod.OrganizationProjectCollection>>
      getProjects({
    String? cursor,
    String? projectAccessType,
    String? nameFilter,
    bool? getAll,
    bool? adminOnly,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    if (projectAccessType != null) {
      qp['projectAccessType'] = projectAccessType;
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
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsFormat.replaceOrgIdPlaceholder(id),
      app: app,
      queryParams: qp,
    );
    final apiModel = api_mod.QueryResult<api_mod.OrganizationProjectCollection>.fromJson(
        jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
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

  /// Gets membership packages for this organization, which the current user has access to.
  Future<
      QueryResult<OrganizationMembershipPackageCollection,
          api_mod.OrganizationMembershipPackageCollection>> getMembershipPackages() async {
    return app.getOrganizationMembershipPackages(organizationId: id);
  }
}
