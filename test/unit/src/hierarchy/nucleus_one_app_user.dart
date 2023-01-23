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

    //       test('reestablishExistingSession method tests', () {
    //     final n1App = getStandardN1App();
    //     final auth = n1App.auth();

    //     final r = auth.reestablishExistingSession('abc');
    //     expect(r.success, isTrue);
    //     expect(r.sessionId, 'abc');
    //     expect(r.user, isNotNull);
    //   });

    //   group('Methods dependent on SDK being initialized', () {
    //     setUp(() async {
    //       await NucleusOne.initializeSdk();
    //     });

    //     tearDown(() async {
    //       await NucleusOne.resetSdk();
    //     });

    test('loginGoogle method tests', () async {
      const sessionId = 'abc';

      for (var i = 0; i < 2; ++i) {
        final success = (i == 0);
        Map<String, String>? responseCookies;

        if (success) {
          responseCookies = {
            'session_v1': sessionId,
          };
        }

        final n1App = getStandardN1App();
        await performHttpTest<LoginResult>(
          httpMethod: HttpMethods.post,
          httpCallCallback: () => NucleusOneAppUser(app: n1App).loginGoogle(
            oauthIdToken: 'oauthTokenAbc',
            browserFingerprint: 123,
          ),
          responseBody: '',
          responseCookies: responseCookies,
          expectedRequestUrlPath: http.ApiPaths.userLogin,
          expectedRequestQueryParams: [],
          expectedRequestBody:
              '{"BrowserFingerprint":123,"UserProvider":"google","OAuthIdToken":"oauthTokenAbc"}',
          additionalValidationsCallback: (loginResult) {
            if (success) {
              expect(loginResult.success, isTrue);
              expect(loginResult.sessionId, sessionId);
            } else {
              expect(loginResult.success, isFalse);
              expect(loginResult.sessionId, isNull);
            }
          },
        );
      }
    });

    test('loginEmailAndOTP method tests', () async {
      const sessionId = 'abc';

      for (var i = 0; i < 2; ++i) {
        final success = (i == 0);
        Map<String, String>? responseCookies;

        if (success) {
          responseCookies = {
            'session_v1': sessionId,
          };
        }

        final n1App = getStandardN1App();
        await performHttpTest<LoginResult>(
          httpMethod: HttpMethods.post,
          httpCallCallback: () => NucleusOneAppUser(app: n1App).loginEmailAndOTP(
            email: '1@2.com',
            oneTimePasscode: 'qwe',
            browserFingerprint: 123,
          ),
          responseBody: '',
          responseCookies: responseCookies,
          expectedRequestUrlPath: http.ApiPaths.userLogin,
          expectedRequestQueryParams: [],
          expectedRequestBody:
              '{"AuthType":"email","BrowserFingerprint":123,"Email":"1@2.com","OTP":"qwe","UserProvider":"email"}',
          additionalValidationsCallback: (loginResult) {
            if (success) {
              expect(loginResult.success, isTrue);
              expect(loginResult.sessionId, sessionId);
            } else {
              expect(loginResult.success, isFalse);
              expect(loginResult.sessionId, isNull);
            }
          },
        );
      }
    });

    //   test('verifyEmailLogin method tests', () async {
    //     final n1App = getStandardN1App();
    //     await http_helper.performHttpTest<EmailLoginOptions>(
    //       httpMethod: HttpMethods.POST,
    //       httpCallCallback: () => n1App.auth().verifyEmailLogin('1@2.com'),
    //       responseBody: emailLoginOptionsJson,
    //       expectedRequestUrlPath: apiPaths.userEmailLoginVerify,
    //       expectedRequestQueryParams: [],
    //       expectedRequestBody: '{"BrowserFingerprint":0,"Email":"1@2.com","UserProvider":"email"}',
    //     );
    //   });

    //   test('emailLoginSendOneTimePasscode method tests', () async {
    //     final n1App = getStandardN1App();
    //     await http_helper.performHttpTest<void>(
    //       httpMethod: HttpMethods.POST,
    //       httpCallCallback: () => n1App.auth().emailLoginSendOneTimePasscode('1@2.com'),
    //       responseBody: '',
    //       expectedRequestUrlPath: apiPaths.userEmailLoginOTPSend,
    //       expectedRequestQueryParams: [],
    //       expectedRequestBody:
    //           '{"BrowserFingerprint":0,"UserProvider":"email","Email":"1@2.com","AuthType":"email"}',
    //     );
    //   });

    //   test('emailLoginVerifyIfAddressCanBeChangedTo method tests', () async {
    //     final n1App = getStandardN1App();
    //     await http_helper.performHttpTest<void>(
    //       httpMethod: HttpMethods.POST,
    //       httpCallCallback: () => n1App.auth().emailLoginVerifyIfAddressCanBeChangedTo('1@2.com'),
    //       responseBody: '',
    //       expectedRequestUrlPath: apiPaths.userEmailAddressVerifications,
    //       expectedRequestQueryParams: [],
    //       expectedRequestBody: '{"Email":"1@2.com"}',
    //     );
    //   });

    //   test('emailLoginChangeAddress method tests', () async {
    //     final n1App = getStandardN1App();
    //     await http_helper.performHttpTest<void>(
    //       httpMethod: HttpMethods.POST,
    //       httpCallCallback: () => n1App.auth().emailLoginChangeAddress('1@2.com'),
    //       responseBody: '',
    //       expectedRequestUrlPath: apiPaths.userEmailAddresses,
    //       expectedRequestQueryParams: [],
    //       expectedRequestBody: '{"Email":"1@2.com"}',
    //     );
    //   });

    //   test('emailLoginConfirmAddressChange method tests', () async {
    //     final n1App = getStandardN1App();
    //     await http_helper.performHttpTest<void>(
    //       httpMethod: HttpMethods.PUT,
    //       httpCallCallback: () => n1App.auth().emailLoginConfirmAddressChange('123'),
    //       responseBody: '',
    //       expectedRequestUrlPath: apiPaths.userEmailAddressesEmailChangeCodeFormat
    //           .replaceFirst('<emailChangeCode>', '123'),
    //       expectedRequestQueryParams: [],
    //       expectedRequestBody: '',
    //     );
    //   });
    // });

    // test('logout method tests', () async {
    //   final n1App = getStandardN1App();
    //   // n1App.setAuthenticationState('123');

    //   await http_helper.performHttpTest(
    //     httpMethod: HttpMethods.GET,
    //     httpCallCallback: n1App.auth().logout,
    //     responseBody: '',
    //     expectedRequestUrlPath: apiPaths.userLogout,
    //     expectedRequestQueryParams: [],
    //   );

    //   expect(n1App.sessionId, isNull);
    //   expect(n1App.authenticated, isFalse);
    // });
  });
}
