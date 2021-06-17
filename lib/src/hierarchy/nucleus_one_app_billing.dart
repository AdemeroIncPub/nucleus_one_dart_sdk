import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/subscription_details.dart' as api_mod;
import '../api_model/subscription_invoice.dart' as api_mod;
import '../api_model/subscription_plan.dart' as api_mod;
import '../http.dart' as http;
import '../model/subscription_details.dart';
import '../model/subscription_invoice.dart';
import '../model/subscription_plan.dart';
import '../nucleus_one.dart';

class NucleusOneAppBilling with NucleusOneAppDependent {
  NucleusOneAppBilling({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets an organization's subscription plans.
  ///
  /// [organizationId]: The id of the organization.
  Future<SubscriptionPlanCollection> getOrganizationSubscriptionPlans({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.billingSubscriptionPlansFormat.replaceFirst('<organizationId>', organizationId),
      app,
    );
    final apiModel = api_mod.SubscriptionPlanCollection.fromJson(jsonDecode(responseBody));
    return SubscriptionPlanCollection.fromApiModel(apiModel);
  }

  /// Gets an organization's subscription.
  ///
  /// [organizationId]: The id of the organization.
  Future<SubscriptionDetails> getOrganizationSubscription({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.billingOrganizationSubscriptionsFormat
          .replaceFirst('<organizationId>', organizationId),
      app,
    );
    final apiModel = api_mod.SubscriptionDetails.fromJson(jsonDecode(responseBody));
    return SubscriptionDetails.fromApiModel(apiModel);
  }

  /// Updates an organization's subscription information.
  ///
  /// [organizationId]: The id of the organization.
  ///
  /// [subscriptionDetails]: The subscription details.  Should be obtained by first calling
  /// [getOrganizationSubscription].
  Future<void> updateOrganizationSubscription({
    required String organizationId,
    required SubscriptionDetails subscriptionDetails,
  }) async {
    await http.executePutRequest(
      http.apiPaths.billingOrganizationSubscriptionsFormat
          .replaceFirst('<organizationId>', organizationId),
      app,
      body: jsonEncode(subscriptionDetails.toApiModel()),
    );
  }

  /// Gets an organization's subscription invoices.
  ///
  /// [organizationId]: The id of the organization.
  Future<SubscriptionInvoiceCollection> getOrganizationSubscriptionInvoices({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.billingSubscriptionInvoicesFormat
          .replaceFirst('<organizationId>', organizationId),
      app,
    );
    final apiModel = api_mod.SubscriptionInvoiceCollection.fromJson(jsonDecode(responseBody));
    return SubscriptionInvoiceCollection.fromApiModel(apiModel);
  }
}
