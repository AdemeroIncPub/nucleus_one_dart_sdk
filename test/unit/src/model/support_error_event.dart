import 'package:nucleus_one_dart_sdk/src/api_model/support_error_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/query_result.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/support_error_event.dart';

void main() {
  group('SupportErrorEvent class tests', () {
    performStandardModelTests<api_mod.SupportErrorEvent, SupportErrorEvent>(
      apiModelJson: supportErrorEventJson,
      expectedPublicFieldCount: 17,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:01Z',
        apiModel.tenantID: 'B',
        apiModel.tenantName: 'C',
        apiModel.tenantNameLower: 'D',
        apiModel.userEmailLower: 'E',
        apiModel.userID: 'F',
        apiModel.serviceNameLower: 'G',
        apiModel.level: 'H',
        apiModel.uniqueID: 'I',
        apiModel.requestURI: 'J',
        apiModel.header: 'K',
        apiModel.message: 'L',
        apiModel.clientMessage: 'M',
        apiModel.httpStatus: 0,
        apiModel.otherValues: ['A', 'B'],
        apiModel.wordsLower: ['A', 'B', 'C'],
      },
    );
  });
  group('SupportErrorEventCollection class tests', () {
    performStandardQueryResultModelTests<
        SupportErrorEventCollection,
        api_mod.SupportErrorEventCollection,
        QueryResult<SupportErrorEventCollection, api_mod.SupportErrorEventCollection>,
        api_mod.QueryResult<api_mod.SupportErrorEventCollection>>(
      apiModelJson: supportErrorEventCollectionJson,
    );
  });
}
