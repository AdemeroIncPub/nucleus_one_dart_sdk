import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../api_model/organization_permissions.dart' as api_mod;
import '../api_model/subscription_details.dart' as api_mod;
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/organization_permissions.dart';
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
}
