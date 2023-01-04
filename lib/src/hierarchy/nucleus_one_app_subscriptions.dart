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

class NucleusOneAppSubscriptions with NucleusOneAppDependent {
  final NucleusOneAppOrganization organization;
  NucleusOneAppSubscriptions({
    required this.organization,
  }) {
    app = organization.app;
  }

  /// Gets the organization's subscription plans.
  Future<SubscriptionPlanCollection> getOrganizationSubscriptionPlans() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsSubscriptionsPlansFormat.replaceOrgIdPlaceholder(organization.id),
      app,
    );
    final apiModel = api_mod.SubscriptionPlanCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SubscriptionPlanCollection.fromApiModel(apiModel);
    });
  }

  /// Updates the organization's subscription information.
  ///
  /// [subscriptionDetails]: The subscription details.  Should be obtained by first calling
  /// [getOrganizationSubscription].
  Future<void> updateOrganizationSubscription({
    required SubscriptionDetails subscriptionDetails,
  }) async {
    await http.executePutRequest(
      http.apiPaths.organizationsSubscriptionsFormat.replaceOrgIdPlaceholder(organization.id),
      app,
      body: jsonEncode(subscriptionDetails.toApiModel()),
    );
  }

  /// Gets an organization's subscription invoices.
  ///
  /// [organizationId]: The id of the organization.
  Future<SubscriptionInvoiceCollection> getOrganizationSubscriptionInvoices() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsSubscriptionsInvoicesFormat
          .replaceOrgIdPlaceholder(organization.id),
      app,
    );
    final apiModel = api_mod.SubscriptionInvoiceCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SubscriptionInvoiceCollection.fromApiModel(apiModel);
    });
  }
}
