import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_invoice.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/subscription_invoice.dart';

void main() {
  group('SubscriptionInvoice class tests', () {
    performStandardModelTests<api_mod.SubscriptionInvoice, SubscriptionInvoice>(
      apiModelJson: subscriptionInvoiceJson,
      expectedPublicFieldCount: 6,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-07-17T01:01:56Z',
        apiModel.amountDue: 0.12,
        apiModel.isUpcoming: true,
        apiModel.status: 'B',
        apiModel.pdfUrl: 'C',
      },
    );
  });

  group('SubscriptionInvoiceCollection class tests', () {
    performStandardModelTests<api_mod.SubscriptionInvoiceCollection, SubscriptionInvoiceCollection>(
      apiModelJson: subscriptionInvoiceCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
