import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_plan.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/subscription_plan.dart';

void main() {
  group('SubscriptionPlan class tests', () {
    performStandardModelTests<SubscriptionPlan, api_mod.SubscriptionPlan>(
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
    performStandardModelTests<SubscriptionPlanCollection, api_mod.SubscriptionPlanCollection>(
      apiModelJson: subscriptionPlanCollectionJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.subscriptionPlans!.length: 1,
        apiModel.currentUniqueNonReadOnlyTenantMemberCount: 0,
        apiModel.currentUniqueReadOnlyTenantMemberCount: 1,
        apiModel.salesTaxRate: 2.0,
      },
    );
  });
}
