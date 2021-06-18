import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/organization_package.dart' as api_mod;
import '../api_model/organization_permissions.dart' as api_mod;
import '../api_model/tenant.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../http.dart' as http;
import '../model/organization_package.dart';
import '../model/organization_permissions.dart';
import '../nucleus_one.dart';

class NucleusOneAppOrganization with NucleusOneAppDependent {
  NucleusOneAppOrganization({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets organization's tenants.
  ///
  /// [organizationId] The id of the organization.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<TenantCollection>> getTenants({
    required String organizationId,
    String? cursor,
  }) async {
    if (organizationId.isEmpty) {
      throw ArgumentError.value(organizationId, 'organizationId', 'Value cannot be blank.');
    }

    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsTenantsFormat.replaceFirst('<organizationId>', organizationId),
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.TenantCollection>.fromJson(jsonDecode(responseBody));
    return TenantCollectionQueryResult.fromApiModelTenantCollection(apiModel);
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
    return OrganizationPermissions.fromApiModel(apiModel);
  }

  /// Gets organization packages for the current user.
  Future<QueryResult<OrganizationPackageCollection>>
      adminGetOrganizationPackagesForCurrentUser() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.adminOrganizationPackagesForCurrentUser,
      app,
    );

    final apiModel = api_mod.QueryResult<api_mod.OrganizationPackageCollection>.fromJson(
        jsonDecode(responseBody));
    return OrganizationPackageCollectionQueryResult.fromApiModelOrganizationPackageCollection(
        apiModel);
  }

  /// Accepts an invitation to an organization.
  ///
  /// [invitationId] The id of the invitationId.
  Future<OrganizationPackage> acceptInvitation({
    required String invitationId,
  }) async {
    if (invitationId.isEmpty) {
      throw ArgumentError.value(invitationId, 'invitationId', 'Value cannot be blank.');
    }

    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.organizationInvitationsFormat.replaceFirst('<invitationId>', invitationId),
      app,
    );

    final apiModel = api_mod.OrganizationPackage.fromJson(jsonDecode(responseBody));
    return OrganizationPackage.fromApiModel(apiModel);
  }
}
