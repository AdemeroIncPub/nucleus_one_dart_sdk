import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preference.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../api_model/user_preference.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('UserPreference class tests', () {
    performStandardModelTests<api_mod.UserPreference, UserPreference>(
      apiModelJson: userPreferenceJson,
      expectedPublicFieldCount: 9,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.userID: 'B',
        apiModel.userName: 'C',
        apiModel.userEmail: 'D',
        apiModel.stringValue: 'E',
        apiModel.boolValue: false,
        apiModel.intValue: 0,
        apiModel.floatValue: 0.1,
        apiModel.mapValue: '[{"0":"A","1":"B","2":"C"}]',
      },
    );

    test('getById method tests', () async {
      final expectedUrlPath =
          http.ApiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', 'ABC');
      final n1App = getStandardN1App();
      await performHttpTest<UserPreference>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getPreferencesById('ABC'),
        responseBody: userPreferenceJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
