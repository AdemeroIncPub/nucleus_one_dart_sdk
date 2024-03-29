import 'dart:convert';

import '../api_model/subscription_invoice.dart' as api_mod;
import '../api_model/subscription_plan.dart' as api_mod;
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/subscription_details.dart';
import '../model/subscription_invoice.dart';
import '../model/subscription_plan.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_organization.dart';

/// Performs subscription operations for an organization.
class NucleusOneAppSubscriptions with NucleusOneAppDependent {
  /// The Nucleus One organization.
  final NucleusOneAppOrganization organization;

  /// Creates an instance of the [NucleusOneAppSubscriptions] class.
  ///
  /// [organization]: The organization to perform task operations on.
  NucleusOneAppSubscriptions({
    required this.organization,
  }) {
    app = organization.app;
  }

  /// Gets the organization's subscription plans.
  Future<SubscriptionPlanCollection> getOrganizationSubscriptionPlans() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsSubscriptionsPlansFormat
          .replaceOrgIdPlaceholder(organization.id),
      app: app,
    );
    final apiModel = api_mod.SubscriptionPlanCollection.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return SubscriptionPlanCollection.fromApiModel(apiModel);
    });
  }

  /// Updates the organization's subscription information.
  ///
  /// [subscriptionDetails]: The subscription details.  Should be obtained by first calling
  /// [NucleusOneAppOrganization.getOrganizationSubscription].
  Future<void> updateOrganizationSubscription({
    required SubscriptionDetails subscriptionDetails,
  }) async {
    await http.executePutRequest(
      apiRelativeUrlPath:
          http.ApiPaths.organizationsSubscriptionsFormat.replaceOrgIdPlaceholder(organization.id),
      app: app,
      body: jsonEncode(subscriptionDetails.toApiModel()),
    );
  }

  /// Gets an organization's subscription invoices.
  Future<SubscriptionInvoiceCollection> getOrganizationSubscriptionInvoices() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsSubscriptionsInvoicesFormat
          .replaceOrgIdPlaceholder(organization.id),
      app: app,
    );
    final apiModel =
        api_mod.SubscriptionInvoiceCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return SubscriptionInvoiceCollection.fromApiModel(apiModel);
    });
  }
}
