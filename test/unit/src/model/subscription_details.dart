import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_details.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/subscription_details.dart';

void main() {
  group('SubscriptionDetails tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SubscriptionDetails), 14);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SubscriptionDetails apiModel) {
        expect(apiModel.paymentSubscriptionCanceled, true);
        expect(apiModel.paymentSubscriptionExists, true);
        expect(apiModel.paymentPlanId, 'A');
        expect(apiModel.tokenId, 'B');
        expect(apiModel.customerName, 'C');
        expect(apiModel.billingEmail, 'D');
        expect(apiModel.postalCode, 'E');
        expect(apiModel.subscriptionRequired, true);
        expect(apiModel.organizationName, 'F');
        expect(apiModel.expiration, '0001-01-01T00:00:00Z');
        expect(apiModel.isExpiringSoon, false);
        expect(apiModel.freeUsers, 0);
        expect(apiModel.subtractFreeUsersFromPlan, true);
        expect(apiModel.isExpired, true);
      }

      final apiModelOrig =
          api_mod.SubscriptionDetails.fromJson(jsonDecode(subscriptionDetailsJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SubscriptionDetails.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
