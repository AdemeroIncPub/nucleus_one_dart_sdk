import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription_for_client.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_subscription_for_client.dart';

void main() {
  group('DocumentSubscriptionForClient class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSubscriptionForClient), 16);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSubscriptionForClient apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.subscribed, true);
        expect(apiModel.notify, false);
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.projectID, 'C');
        expect(apiModel.projectName, 'D');
        expect(apiModel.projectAccessType, 'E');
        expect(apiModel.documentID, 'F');
        expect(apiModel.documentCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentName, 'G');
        expect(apiModel.documentPageCount, 0);
        expect(apiModel.documentFileSize, 1);
        expect(apiModel.documentPreviewMetadata, isNotNull);
        expect(apiModel.documentPreviewMetadata!.length, 1);
        expect(apiModel.documentIsSigned, true);
        expect(apiModel.documentThumbnailUrl, 'H');
      }

      final apiModelOrig = api_mod.DocumentSubscriptionForClient.fromJson(
          jsonDecode(documentSubscriptionForClientJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSubscriptionForClient.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSubscriptionForClientCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSubscriptionForClientCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSubscriptionForClientCollection apiModel) {
        expect(apiModel.documentSubscriptions!.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSubscriptionForClientCollection.fromJson(
          jsonDecode(documentSubscriptionForClientCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSubscriptionForClientCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
