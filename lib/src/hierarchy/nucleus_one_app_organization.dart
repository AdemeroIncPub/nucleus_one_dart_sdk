import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../api_model/organization_package.dart' as api_mod;
import '../api_model/organization_permissions.dart' as api_mod;
import '../api_model/tenant.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../http.dart' as http;
import '../model/organization_package.dart';
import '../model/organization_permissions.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_subscriptions.dart';
import 'nucleus_one_app_project.dart';

class NucleusOneAppOrganization with NucleusOneAppDependent {
  final String id;

  NucleusOneAppOrganization({
    NucleusOneAppInternal? app,
    required this.id,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;

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
    return OrganizationPermissions.fromApiModel(apiModel);
  }
}
