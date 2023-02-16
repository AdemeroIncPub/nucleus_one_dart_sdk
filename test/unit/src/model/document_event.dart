import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_event.dart';

void main() {
  group('DocumentEvent class tests', () {
    performStandardModelTests<DocumentEvent, api_mod.DocumentEvent>(
      apiModelJson: documentEventJson,
      expectedPublicFieldCount: 8,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.documentID: 'B',
        apiModel.createdOn: '2020-09-10T18:55:56.901688Z',
        apiModel.createdByUserID: 'C',
        apiModel.createdByUserName: 'D',
        apiModel.createdByUserEmail: 'E',
        apiModel.type: 'Comment',
        apiModel.detailJson: 'F',
      },
    );
  });

  group('DocumentEventCollection class tests', () {
    performStandardQueryResultModelTests<
        DocumentEventCollection,
        api_mod.DocumentEventCollection,
        QueryResult2<DocumentEventCollection, api_mod.DocumentEventCollection>,
        api_mod.QueryResult2<api_mod.DocumentEventCollection>>(
      apiModelJson: documentEventCollectionJson,
    );
  });
}
