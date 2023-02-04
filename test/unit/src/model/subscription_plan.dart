import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_plan.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/subscription_plan.dart';

void main() {
  group('SubscriptionPlan class tests', () {
    performStandardModelTests<api_mod.SubscriptionPlan, SubscriptionPlan>(
      apiModelJson: subscriptionPlanJson,
      expectedPublicFieldCount: 8,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.title: 'B',
        apiModel.currency: 'C',
        apiModel.interval: 'D',
        apiModel.savingsPercent: 'E',
        apiModel.tieredPricing: true,
        apiModel.amountPerUnit: 0,
        apiModel.active: false,
      },
    );
  });

  group('SubscriptionPlanCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SubscriptionPlanCollection), 4);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SubscriptionPlanCollection apiModel) {
        expect(apiModel.subscriptionPlans!.length, 1);
        expect(apiModel.currentUniqueNonReadOnlyTenantMemberCount, 0);
        expect(apiModel.currentUniqueReadOnlyTenantMemberCount, 1);
        expect(apiModel.salesTaxRate, 2.0);
      }

      final apiModelOrig =
          api_mod.SubscriptionPlanCollection.fromJson(jsonDecode(subscriptionPlanCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.SubscriptionPlanCollection apiModelCycled =
            SubscriptionPlanCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
