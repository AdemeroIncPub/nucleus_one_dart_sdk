import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_details.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_billing.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';
import '../api_model/subscription_details.dart';
import '../api_model/subscription_invoice.dart';
import '../api_model/subscription_plan.dart';

void main() {
  group('NucleusOneAppBilling class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getOrganizationSubscriptionPlans method tests', () async {
      final expectedUrlPath =
          http.apiPaths.billingSubscriptionPlansFormat.replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<SubscriptionPlanCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppBilling(app: n1App).getOrganizationSubscriptionPlans(
          organizationId: '123',
        ),
        responseBody: subscriptionPlanCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrganizationSubscription method tests', () async {
      final expectedUrlPath = http.apiPaths.billingOrganizationSubscriptionsFormat
          .replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<SubscriptionDetails>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppBilling(app: n1App).getOrganizationSubscription(
          organizationId: '123',
        ),
        responseBody: subscriptionDetailsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateOrganizationSubscription method tests', () async {
      final expectedUrlPath = http.apiPaths.billingOrganizationSubscriptionsFormat
          .replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();
      final subscriptionDetails = SubscriptionDetails.fromApiModel(
          api_mod.SubscriptionDetails.fromJson(jsonDecode(subscriptionDetailsJson)));

      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppBilling(app: n1App).updateOrganizationSubscription(
          organizationId: '123',
          subscriptionDetails: subscriptionDetails,
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: subscriptionDetailsJson,
      );
    });

    test('getOrganizationSubscriptionInvoices method tests', () async {
      final expectedUrlPath =
          http.apiPaths.billingSubscriptionInvoicesFormat.replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<SubscriptionInvoiceCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppBilling(app: n1App).getOrganizationSubscriptionInvoices(
          organizationId: '123',
        ),
        responseBody: subscriptionInvoiceCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
