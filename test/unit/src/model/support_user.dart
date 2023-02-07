import 'package:nucleus_one_dart_sdk/src/api_model/support_user.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/query_result.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_user.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/support_user.dart';

void main() {
  group('SupportUser class tests', () {
    performStandardModelTests<SupportUser, api_mod.SupportUser>(
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
    performStandardQueryResultModelTests<
        SupportUserCollection,
        api_mod.SupportUserCollection,
        QueryResult<SupportUserCollection, api_mod.SupportUserCollection>,
        api_mod.QueryResult<api_mod.SupportUserCollection>>(
      apiModelJson: supportUserCollectionJson,
    );
  });
}
