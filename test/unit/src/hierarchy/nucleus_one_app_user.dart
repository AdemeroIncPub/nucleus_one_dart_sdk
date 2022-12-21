import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preference.dart' as api_mod;

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/user_organization.dart';
import '../api_model/user_organization_project.dart';
import '../api_model/user_preferences.dart';

final _up = api_mod.UserPreference()
  ..id = 'A'
  ..userID = 'B'
  ..userName = 'C'
  ..userEmail = 'D'
  ..stringValue = 'E'
  ..boolValue = false
  ..intValue = 0
  ..floatValue = 1
  ..mapValue = 'F';
const _expectedUserPrefJson =
    r'{"ID":"A","UserID":"B","UserName":"C","UserEmail":"D","StringValue":"E","BoolValue":false,"IntValue":0,"FloatValue":1.0}';

void main() {
  group('NucleusOneAppProject class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getOrganizations method tests', () async {
      final expectedUrlPath = http.apiPaths.userOrganizations;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserOrganizationCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getOrganizations(),
        responseBody: userOrganizationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getProjects method tests', () async {
      final expectedUrlPath =
          http.apiPaths.userOrganizationsProjectsFormat.replaceOrganizationPlaceholder('123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserOrganizationProjectCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getProjects(organizationId: '123'),
        responseBody: userOrganizationProjectCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateUserPreference method tests', () async {
      final expectedUrlPath = http.apiPaths.userPreferences;
      final n1App = getStandardN1App();

      await DefineN1AppInScopeAsync(n1App, () async {
        return await performHttpTest<void>(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () =>
              NucleusOneAppUser(app: n1App).updateUserPreference(UserPreference.fromApiModel(_up)),
          expectedRequestBody: _expectedUserPrefJson,
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
          httpCallCallback: () => NucleusOneAppUser(app: n1App)
              .updateUserPreferenceByUserPreferenceId(UserPreference.fromApiModel(_up), 'A'),
          expectedRequestBody: _expectedUserPrefJson,
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
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getPreferences(),
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
        httpCallCallback: () => NucleusOneAppUser(app: n1App).setSmsNumber('123'),
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
        httpCallCallback: () => NucleusOneAppUser(app: n1App).verifySmsNumber('123'),
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
        httpCallCallback: () => NucleusOneAppUser(app: n1App).deleteSmsNumber(),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
