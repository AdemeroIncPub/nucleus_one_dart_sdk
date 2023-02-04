import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_event.dart';

void main() {
  group('DocumentEventCollection tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentEventCollection), 1);
    });

    performStandardModelTests<api_mod.QueryResult2<api_mod.DocumentEventCollection>,
        QueryResult2<DocumentEventCollection>>(
      apiModelJson: documentEventsJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.results!.documentEvents!.length: 1,
        apiModel.cursor: 'QueryResultA',
        apiModel.reverseCursor: 'QueryResultB',
        apiModel.pageSize: 24,
      },
    );
  });

  group('DocumentEvent tests', () {
    performStandardModelTests<api_mod.DocumentEvent, DocumentEvent>(
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
}
