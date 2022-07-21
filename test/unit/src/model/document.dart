import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document.dart';

void main() {
  group('Document class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.Document apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.projectID, 'C');
        expect(apiModel.projectName, 'D');
        expect(apiModel.projectAccessType, 'E');
        expect(apiModel.documentID, 'F');
        expect(apiModel.documentFolderID, '');
        expect(apiModel.documentFolderPath, '');
        expect(apiModel.assignmentUserEmails, ['F0']);
        expect(apiModel.groupID, '');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserEmail, 'G@H.com');
        expect(apiModel.createdByUserName, 'I');
        expect(apiModel.modifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.modifiedByUserEmail, '');
        expect(apiModel.modifiedByUserName, '');
        expect(apiModel.purgeDate, '0001-01-01T00:00:00Z');
        expect(apiModel.name, 'J');
        expect(apiModel.origin, 'UserUpload');
        expect(apiModel.pageCount, 3);
        expect(apiModel.fileSize, 648732);
        expect(apiModel.thumbnailUrl, 'https://K');
        expect(apiModel.isSigned, false);
        expect(apiModel.previewMetadata, isNotNull);
        expect(apiModel.previewMetadata!.length, 2);
        expect(apiModel.approvalID, '');
        expect(apiModel.approvalCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.isMarkedForPurge, false);
        expect(apiModel.hasSinglePageImages, true);
        expect(apiModel.signatureSessionIsActive, false);
        expect(apiModel.signaturesCompletedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentSubscriptionID, '');
        expect(apiModel.documentSubscriptionCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.processName, '');
        expect(apiModel.processElementName, '');
        expect(apiModel.revision, 0);
        expect(apiModel.paperSize, '');
        expect(apiModel.paperOrientation, '');
        expect(apiModel.paperMarginLeft, 0);
        expect(apiModel.paperMarginRight, 0);
        expect(apiModel.paperMarginTop, 0);
        expect(apiModel.paperMarginBottom, 0);
      }

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = Document.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.DocumentCollection> apiModel) {
        expect(apiModel.results!.documents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.DocumentCollection>.fromJson(
          jsonDecode(documentCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentCollectionQueryResult.fromApiModelDocumentCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
