import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_details.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
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
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getOrganizationSubscriptionPlans method tests', () async {
      final subs = getStandardN1Org().subscriptions();
      final expectedUrlPath = http.ApiPaths.organizationsSubscriptionsPlansFormat
          .replaceOrgIdPlaceholder(subs.organization.id);

      // Test with default parameters
      await performHttpTest<SubscriptionPlanCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => subs.getOrganizationSubscriptionPlans(),
        responseBody: subscriptionPlanCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateOrganizationSubscription method tests', () async {
      final subs = getStandardN1Org().subscriptions();
      final expectedUrlPath = http.ApiPaths.organizationsSubscriptionsFormat
          .replaceOrgIdPlaceholder(subs.organization.id);
      final subscriptionDetails = SubscriptionDetails.fromApiModel(
        api_mod.SubscriptionDetails.fromJson(jsonDecode(subscriptionDetailsJson)),
        app: subs.app,
      );

      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.put,
        httpCallCallback: () => subs.updateOrganizationSubscription(
          subscriptionDetails: subscriptionDetails,
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: subscriptionDetailsJson,
      );
    });

    test('getOrganizationSubscriptionInvoices method tests', () async {
      final subs = getStandardN1Org().subscriptions();
      final expectedUrlPath = http.ApiPaths.organizationsSubscriptionsInvoicesFormat
          .replaceOrgIdPlaceholder(subs.organization.id);

      // Test with default parameters
      await performHttpTest<SubscriptionInvoiceCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => subs.getOrganizationSubscriptionInvoices(),
        responseBody: subscriptionInvoiceCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
