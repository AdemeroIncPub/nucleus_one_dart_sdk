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
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getOrganizations method tests', () async {
      final expectedUrlPath = http.ApiPaths.userOrganizations;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserOrganizationCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getOrganizations(),
        responseBody: userOrganizationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getProjects method tests', () async {
      final expectedUrlPath =
          http.ApiPaths.userOrganizationsProjectsFormat.replaceOrgIdPlaceholder('123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserOrganizationProjectCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getProjects(organizationId: '123'),
        responseBody: userOrganizationProjectCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('updateUserPreference method tests', () async {
      final expectedUrlPath = http.ApiPaths.userPreferences;
      final n1App = getStandardN1App();

      await defineN1AppInScopeAsync(n1App, () async {
        return await performHttpTest<void>(
          httpMethod: HttpMethods.put,
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
          http.ApiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', 'A');
      final n1App = getStandardN1App();

      await defineN1AppInScopeAsync(n1App, () async {
        return await performHttpTest<void>(
          httpMethod: HttpMethods.put,
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
      final expectedUrlPath = http.ApiPaths.userPreferences;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserPreferences>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getPreferences(),
        responseBody: userPreferencesJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('setSmsNumber method tests', () async {
      final expectedUrlPath = http.ApiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).setSmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"SMSNumber":"123"}',
      );
    });

    test('verifySmsNumber method tests', () async {
      final expectedUrlPath =
          http.ApiPaths.userSmsNumbersSmsChangeCodeFormat.replaceFirst('<smsChangeCode>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.put,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).verifySmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('deleteSmsNumber method tests', () async {
      final expectedUrlPath = http.ApiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.delete,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).deleteSmsNumber(),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
