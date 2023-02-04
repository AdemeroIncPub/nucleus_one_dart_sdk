import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/support_error_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
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
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportErrorEventCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.SupportErrorEventCollection> apiModel) {
        expect(apiModel.results!.supportErrorEvents!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.SupportErrorEventCollection>.fromJson(
          jsonDecode(supportErrorEventCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.SupportErrorEventCollection> apiModelCycled =
            SupportErrorEventCollectionQueryResult.fromApiModelSupportErrorEventCollection(
                    apiModelOrig)
                .toApiModel<api_mod.SupportErrorEventCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
