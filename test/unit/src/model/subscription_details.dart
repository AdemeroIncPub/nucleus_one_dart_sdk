import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_details.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/subscription_details.dart';

void main() {
  group('SubscriptionDetails class tests', () {
    performStandardModelTests<api_mod.SubscriptionDetails, SubscriptionDetails>(
      apiModelJson: subscriptionDetailsJson,
      expectedPublicFieldCount: 14,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.paymentSubscriptionCanceled: true,
        apiModel.paymentSubscriptionExists: true,
        apiModel.paymentPlanId: 'A',
        apiModel.tokenId: 'B',
        apiModel.customerName: 'C',
        apiModel.billingEmail: 'D',
        apiModel.postalCode: 'E',
        apiModel.subscriptionRequired: true,
        apiModel.organizationName: 'F',
        apiModel.expiration: '0001-01-01T00:00:00Z',
        apiModel.isExpiringSoon: false,
        apiModel.freeUsers: 0,
        apiModel.subtractFreeUsersFromPlan: true,
        apiModel.isExpired: true,
      },
    );
  });
}
