import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_plan.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/subscription_plan.dart';

void main() {
  group('SubscriptionPlan tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.SubscriptionPlan apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.title, 'B');
        expect(apiModel.currency, 'C');
        expect(apiModel.interval, 'D');
        expect(apiModel.savingsPercent, 'E');
        expect(apiModel.tieredPricing, true);
        expect(apiModel.amountPerUnit, 0);
        expect(apiModel.active, false);
      }

      final apiModelOrig = api_mod.SubscriptionPlan.fromJson(jsonDecode(subscriptionPlanJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SubscriptionPlan.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('SubscriptionPlanCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
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

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.SubscriptionPlanCollection apiModelCycled =
            SubscriptionPlanCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
