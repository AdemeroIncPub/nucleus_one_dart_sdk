import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/subscription_invoice.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/subscription_invoice.dart';

void main() {
  group('SubscriptionInvoice tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.SubscriptionInvoice apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-07-17T01:01:56Z');
        expect(apiModel.amountDue, 0.12);
        expect(apiModel.isUpcoming, true);
        expect(apiModel.status, 'B');
        expect(apiModel.pdfUrl, 'C');
      }

      final apiModelOrig =
          api_mod.SubscriptionInvoice.fromJson(jsonDecode(subscriptionInvoiceJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = SubscriptionInvoice.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('SubscriptionInvoiceCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.SubscriptionInvoiceCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.SubscriptionInvoiceCollection.fromJson(
          jsonDecode(subscriptionInvoiceCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.SubscriptionInvoiceCollection apiModelCycled =
          SubscriptionInvoiceCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
