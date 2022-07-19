import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preference.dart' as api_mod;

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/user_preferences.dart';

final up = api_mod.UserPreference()
  ..id = 'A'
  ..userID = 'B'
  ..userName = 'C'
  ..userEmail = 'D'
  ..stringValue = 'E'
  ..boolValue = false
  ..intValue = 0
  ..floatValue = 1
  ..mapValue = 'F';

void main() {
  group('NucleusOneAppProject class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('updateUserPreference method tests', () async {
      final expectedUrlPath = http.apiPaths.userPreferences;
      final n1App = getStandardN1App();

      await DefineN1AppInScopeAsync(n1App, () async {
        return await performHttpTest<void>(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () =>
              NucleusOneAppUsers(app: n1App).updateUserPreference(UserPreference.fromApiModel(up)),
          responseBody: '',
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [],
        );
      });
    });

    test('updateUserPreferenceByUserPreferenceId method tests', () async {
      final expectedUrlPath =
          http.apiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', 'A');
      final n1App = getStandardN1App();

      await DefineN1AppInScopeAsync(n1App, () async {
        return await performHttpTest<void>(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () => NucleusOneAppUsers(app: n1App)
              .updateUserPreferenceByUserPreferenceId(UserPreference.fromApiModel(up), 'A'),
          responseBody: '',
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [
            'singleUserPreferenceId=A',
          ],
        );
      });
    });

    test('getPreferences method tests', () async {
      final expectedUrlPath = http.apiPaths.userPreferences;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserPreferences>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).getPreferences(),
        responseBody: userPreferencesJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('setSmsNumber method tests', () async {
      final expectedUrlPath = http.apiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).setSmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"SMSNumber":"123"}',
      );
    });

    test('verifySmsNumber method tests', () async {
      final expectedUrlPath =
          http.apiPaths.userSmsNumbersSmsChangeCodeFormat.replaceFirst('<smsChangeCode>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).verifySmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('deleteSmsNumber method tests', () async {
      final expectedUrlPath = http.apiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).deleteSmsNumber(),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
