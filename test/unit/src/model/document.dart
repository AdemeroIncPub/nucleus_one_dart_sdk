import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document.dart';

void main() {
  group('Document class tests', () {
    performStandardModelTests<Document, api_mod.Document>(
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

  group('DocumentCollection class tests', () {
    performStandardQueryResultModelTests<
        DocumentCollection,
        api_mod.DocumentCollection,
        QueryResult<DocumentCollection, api_mod.DocumentCollection>,
        api_mod.QueryResult<api_mod.DocumentCollection>>(
      apiModelJson: documentCollectionJson,
    );
  });
}
