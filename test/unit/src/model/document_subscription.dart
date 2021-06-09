import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document_subscription.dart';

import 'package:test/test.dart';

import '../api_model/document_subscription.dart';

void main() {
  group('DocumentSubscription class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentSubscription apiModel) {
        expect(apiModel.subscribed, false);
        expect(apiModel.notify, false);
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentID, 'A');
        expect(apiModel.documentCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentName, 'B');
        expect(apiModel.documentPageCount, 0);
        expect(apiModel.documentFileSize, 1);
        expect(apiModel.documentClassificationID, 'C');
        expect(apiModel.documentClassificationName, 'D');
        expect(apiModel.documentPreviewMetadata, isNotNull);
        expect(apiModel.documentPreviewMetadata!.length, 1);
        expect(apiModel.documentIsSigned, false);
      }

      final apiModelOrig =
          api_mod.DocumentSubscription.fromJson(jsonDecode(documentSubscriptionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentSubscription.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
