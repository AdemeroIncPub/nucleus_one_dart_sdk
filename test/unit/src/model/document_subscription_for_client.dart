import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription_for_client.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_subscription_for_client.dart';

void main() {
  group('DocumentSubscriptionForClient class tests', () {
    performStandardModelTests<api_mod.DocumentSubscriptionForClient, DocumentSubscriptionForClient>(
      apiModelJson: documentSubscriptionForClientJson,
      expectedPublicFieldCount: 16,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.subscribed: true,
        apiModel.notify: false,
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.organizationID: 'B',
        apiModel.projectID: 'C',
        apiModel.projectName: 'D',
        apiModel.projectAccessType: 'E',
        apiModel.documentID: 'F',
        apiModel.documentCreatedOn: '0001-01-01T00:00:00Z',
        apiModel.documentName: 'G',
        apiModel.documentPageCount: 0,
        apiModel.documentFileSize: 1,
        apiModel.documentPreviewMetadata: isNotNull,
        apiModel.documentPreviewMetadata!.length: 1,
        apiModel.documentIsSigned: true,
        apiModel.documentThumbnailUrl: 'H',
      },
    );
  });

  group('DocumentSubscriptionForClientCollection class tests', () {
    performStandardQueryResultModelTests<
        DocumentSubscriptionForClientCollection,
        api_mod.DocumentSubscriptionForClientCollection,
        QueryResult<DocumentSubscriptionForClientCollection,
            api_mod.DocumentSubscriptionForClientCollection>,
        api_mod.QueryResult<api_mod.DocumentSubscriptionForClientCollection>>(
      apiModelJson: documentSubscriptionForClientCollectionJson,
    );
  });
}
