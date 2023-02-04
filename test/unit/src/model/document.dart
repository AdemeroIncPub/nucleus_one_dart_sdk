import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document.dart';

void main() {
  group('Document class tests', () {
    performStandardModelTests<api_mod.Document, Document>(
      apiModelJson: documentJson,
      expectedPublicFieldCount: 41,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.organizationID: 'B',
        apiModel.projectID: 'C',
        apiModel.projectName: 'D',
        apiModel.projectAccessType: 'E',
        apiModel.documentID: 'F',
        apiModel.documentFolderID: '',
        apiModel.documentFolderPath: '',
        apiModel.assignmentUserEmails: ['F0'],
        apiModel.groupID: '',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.createdByUserEmail: 'G@H.com',
        apiModel.createdByUserName: 'I',
        apiModel.modifiedOn: '0001-01-01T00:00:00Z',
        apiModel.modifiedByUserEmail: '',
        apiModel.modifiedByUserName: '',
        apiModel.purgeDate: '0001-01-01T00:00:00Z',
        apiModel.name: 'J',
        apiModel.origin: 'UserUpload',
        apiModel.pageCount: 3,
        apiModel.fileSize: 648732,
        apiModel.thumbnailUrl: 'https://K',
        apiModel.isSigned: false,
        apiModel.previewMetadata: isNotNull,
        apiModel.previewMetadata!.length: 2,
        apiModel.approvalID: '',
        apiModel.approvalCreatedOn: '0001-01-01T00:00:00Z',
        apiModel.isMarkedForPurge: false,
        apiModel.hasSinglePageImages: true,
        apiModel.signatureSessionIsActive: false,
        apiModel.signaturesCompletedOn: '0001-01-01T00:00:00Z',
        apiModel.documentSubscriptionID: '',
        apiModel.documentSubscriptionCreatedOn: '0001-01-01T00:00:00Z',
        apiModel.processName: '',
        apiModel.processElementName: '',
        apiModel.revision: 0,
        apiModel.paperSize: '',
        apiModel.paperOrientation: '',
        apiModel.paperMarginLeft: 0,
        apiModel.paperMarginRight: 0,
        apiModel.paperMarginTop: 0,
        apiModel.paperMarginBottom: 0,
      },
    );
  });

  group('DocumentCollection tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentCollection), 1);
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

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentCollectionQueryResult.fromApiModelDocumentCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
