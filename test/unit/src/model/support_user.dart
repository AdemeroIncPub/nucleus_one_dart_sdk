import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/support_user.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_user.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/support_user.dart';

void main() {
  group('SupportUser class tests', () {
    performStandardModelTests<api_mod.SupportUser, SupportUser>(
      apiModelJson: supportUserJson,
      expectedPublicFieldCount: 7,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:01Z',
        apiModel.lastSignIn: '0001-01-01T00:00:01Z',
        apiModel.lastActivity: '0001-01-01T00:00:01Z',
        apiModel.email: 'B',
        apiModel.provider: 'C',
        apiModel.name: 'D',
      },
    );
  });

  group('SupportUserCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SupportUserCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.SupportUserCollection> apiModel) {
        expect(apiModel.results!.supportUsers!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.SupportUserCollection>.fromJson(
          jsonDecode(supportUserCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.SupportUserCollection> apiModelCycled =
            SupportUserCollectionQueryResult.fromApiModelSupportUserCollection(apiModelOrig)
                .toApiModel<api_mod.SupportUserCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
