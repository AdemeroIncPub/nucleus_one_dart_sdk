import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/get_it.dart';
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';

void main() {
  group('NucleusOne class tests', () {
    test('intializeSdk & resetSdk methods test', () async {
      expect(getIt.isRegistered<file.FileSystem>(), isFalse);
      await NucleusOne.intializeSdk();
      expect(getIt.isRegistered<file.FileSystem>(), isTrue);
      expect(getIt.get<file.FileSystem>(), isA<file.LocalFileSystem>());

      await NucleusOne.resetSdk();
      expect(getIt.isRegistered<file.FileSystem>(), isFalse);
    });
  });

  group('NucleusOneOptions class tests', () {
    test('Constructor tests', () {
      testValidAssertion(() => NucleusOneOptions(apiBaseUrl: ''));

      testValidAssertion(() => NucleusOneOptions(apiBaseUrl: '', apiKey: ''));

      final n1Opts = NucleusOneOptions(apiBaseUrl: 'abc', apiKey: 'bcd');
      expect(n1Opts.apiBaseUrl, 'abc');
      expect(n1Opts.apiKey, 'bcd');
    });
  });

  group('NucleusOneApp class tests', () {
    test('Constructor tests', () {
      final n1Options = NucleusOneOptions(apiBaseUrl: '');
      final n1App = NucleusOneApp(options: n1Options);
      expect(n1App.options, n1Options);
    });

    test('getFullUrl method tests', () {
      const baseUrl = 'https://abc.com';
      final n1App = getStandardN1App(baseUrl: baseUrl);

      expect(n1App.getFullUrl('/test'), baseUrl + NucleusOneApp.apiBaseUrlPath + '/test');
    });

    test('users method tests', () {
      final n1App = getStandardN1App();

      final users = n1App.user();
      expect(users, isA<NucleusOneAppUser>());
      expect(users.app, n1App);
    });

    test('organization method tests', () {
      final n1App = getStandardN1App();

      final org = n1App.organization('123');
      expect(org, isA<NucleusOneAppOrganization>());
      expect(org.app, n1App);
    });
  });

  // group('DocumentForClient class tests', () {
  //   test('Constructor tests', () {
  //     final n1App = getStandardN1App();

  //     final doc = DocumentForClient(app: n1App);
  //     expect(doc.app, n1App);
  //   });

  //   test('getDocumentCount method tests', () async {
  //     final returnValue = 123;
  //     final queryParamCombinations = [
  //       [false, true],
  //       [true, false],
  //     ];

  //     for (var queryParamCombination in queryParamCombinations) {
  //       final opResult = await createMockHttpClientScopeForGetRequest(
  //         callback: () async {
  //           final n1App = getStandardN1App();
  //           final ignoreInbox = queryParamCombination[0],
  //               ignoreRecycleBin = queryParamCombination[1];
  //           final docCount = await NucleusOneAppDocument(app: n1App)
  //               .getDocumentCount(ignoreInbox, ignoreRecycleBin);
  //           expect(docCount, returnValue);
  //         },
  //         responseBody: returnValue.toString(),
  //       );

  //       expect(opResult.request.uri.query,
  //           matches(r'\bignoreInbox=' + queryParamCombination[0].toString() + r'\b'));
  //       expect(opResult.request.uri.query,
  //           matches(r'\bignoreRecycleBin=' + queryParamCombination[1].toString() + r'\b'));

  //       expect(opResult.headers.headers.length, 5);
  //       opResult.headers.expectContainsAllKeys([
  //         'Pragma',
  //         'Cache-Control',
  //         'Accept',
  //         'Content-Type',
  //         'Accept-Encoding' /*, 'Cookie'*/
  //       ]);
  //     }
  //   });
  // });

  // group('Auth class tests', () {
  //   test('Constructor tests', () {
  //     final n1App = getStandardN1App();
  //     final getValidAuthObject = () => Auth(app: n1App);

  //     testValidAssertion(getValidAuthObject);

  //     final auth = getValidAuthObject();
  //     expect(auth.app, n1App);
  //   });

  //   test('reestablishExistingSession method tests', () {
  //     final n1App = getStandardN1App();
  //     final auth = n1App.auth();

  //     final r = auth.reestablishExistingSession('abc');
  //     expect(r.success, isTrue);
  //     expect(r.sessionId, 'abc');
  //     expect(r.user, isNotNull);
  //   });

  //   group('Methods dependent on SDK being initialized', () {
  //     setUp(() async {
  //       await NucleusOne.intializeSdk();
  //     });

  //     tearDown(() async {
  //       await NucleusOne.resetSdk();
  //     });

  //     test('loginGoogle method tests', () async {
  //       const sessionId = 'abc';

  //       for (var i = 0; i < 2; ++i) {
  //         final success = (i == 0);
  //         Map<String, String>? responseCookies;

  //         if (success) {
  //           responseCookies = {
  //             'session_v1': sessionId,
  //           };
  //         }

  //         final n1App = getStandardN1App();
  //         await http_helper.performHttpTest<LoginResult>(
  //           httpMethod: HttpMethods.POST,
  //           httpCallCallback: () => n1App.auth().loginGoogle('oauthTokenAbc'),
  //           responseBody: '',
  //           responseCookies: responseCookies,
  //           expectedRequestUrlPath: apiPaths.userLogin,
  //           expectedRequestQueryParams: [],
  //           expectedRequestBody:
  //               '{"BrowserFingerprint":0,"UserProvider":"google","OAuthIdToken":"oauthTokenAbc"}',
  //           additionalValidationsCallback: (loginResult) {
  //             if (success) {
  //               expect(loginResult.success, isTrue);
  //               expect(loginResult.sessionId, sessionId);
  //               expect(n1App.sessionId, sessionId);
  //               expect(n1App.authenticated, isTrue);
  //             } else {
  //               expect(loginResult.success, isFalse);
  //               expect(loginResult.sessionId, isNull);
  //               expect(n1App.sessionId, isNull);
  //               expect(n1App.authenticated, isFalse);
  //             }
  //           },
  //         );
  //       }
  //     });

  //     test('loginEmailAndOTP method tests', () async {
  //       const sessionId = 'abc';

  //       for (var i = 0; i < 2; ++i) {
  //         final success = (i == 0);
  //         Map<String, String>? responseCookies;

  //         if (success) {
  //           responseCookies = {
  //             'session_v1': sessionId,
  //           };
  //         }

  //         final n1App = getStandardN1App();
  //         await http_helper.performHttpTest<LoginResult>(
  //           httpMethod: HttpMethods.POST,
  //           httpCallCallback: () => n1App.auth().loginEmailAndOTP('1@2.com', 'qwe'),
  //           responseBody: '',
  //           responseCookies: responseCookies,
  //           expectedRequestUrlPath: apiPaths.userLogin,
  //           expectedRequestQueryParams: [],
  //           expectedRequestBody:
  //               '{"AuthType":"email","BrowserFingerprint":0,"Email":"1@2.com","OTP":"qwe","UserProvider":"email"}',
  //           additionalValidationsCallback: (loginResult) {
  //             if (success) {
  //               expect(loginResult.success, isTrue);
  //               expect(loginResult.sessionId, sessionId);
  //               expect(n1App.sessionId, sessionId);
  //               expect(n1App.authenticated, isTrue);
  //             } else {
  //               expect(loginResult.success, isFalse);
  //               expect(loginResult.sessionId, isNull);
  //               expect(n1App.sessionId, isNull);
  //               expect(n1App.authenticated, isFalse);
  //             }
  //           },
  //         );
  //       }
  //     });

  //     test('verifyEmailLogin method tests', () async {
  //       final n1App = getStandardN1App();
  //       await http_helper.performHttpTest<EmailLoginOptions>(
  //         httpMethod: HttpMethods.POST,
  //         httpCallCallback: () => n1App.auth().verifyEmailLogin('1@2.com'),
  //         responseBody: emailLoginOptionsJson,
  //         expectedRequestUrlPath: apiPaths.userEmailLoginVerify,
  //         expectedRequestQueryParams: [],
  //         expectedRequestBody: '{"BrowserFingerprint":0,"Email":"1@2.com","UserProvider":"email"}',
  //       );
  //     });

  //     test('emailLoginSendOneTimePasscode method tests', () async {
  //       final n1App = getStandardN1App();
  //       await http_helper.performHttpTest<void>(
  //         httpMethod: HttpMethods.POST,
  //         httpCallCallback: () => n1App.auth().emailLoginSendOneTimePasscode('1@2.com'),
  //         responseBody: '',
  //         expectedRequestUrlPath: apiPaths.userEmailLoginOTPSend,
  //         expectedRequestQueryParams: [],
  //         expectedRequestBody:
  //             '{"BrowserFingerprint":0,"UserProvider":"email","Email":"1@2.com","AuthType":"email"}',
  //       );
  //     });

  //     test('emailLoginVerifyIfAddressCanBeChangedTo method tests', () async {
  //       final n1App = getStandardN1App();
  //       await http_helper.performHttpTest<void>(
  //         httpMethod: HttpMethods.POST,
  //         httpCallCallback: () => n1App.auth().emailLoginVerifyIfAddressCanBeChangedTo('1@2.com'),
  //         responseBody: '',
  //         expectedRequestUrlPath: apiPaths.userEmailAddressVerifications,
  //         expectedRequestQueryParams: [],
  //         expectedRequestBody: '{"Email":"1@2.com"}',
  //       );
  //     });

  //     test('emailLoginChangeAddress method tests', () async {
  //       final n1App = getStandardN1App();
  //       await http_helper.performHttpTest<void>(
  //         httpMethod: HttpMethods.POST,
  //         httpCallCallback: () => n1App.auth().emailLoginChangeAddress('1@2.com'),
  //         responseBody: '',
  //         expectedRequestUrlPath: apiPaths.userEmailAddresses,
  //         expectedRequestQueryParams: [],
  //         expectedRequestBody: '{"Email":"1@2.com"}',
  //       );
  //     });

  //     test('emailLoginConfirmAddressChange method tests', () async {
  //       final n1App = getStandardN1App();
  //       await http_helper.performHttpTest<void>(
  //         httpMethod: HttpMethods.PUT,
  //         httpCallCallback: () => n1App.auth().emailLoginConfirmAddressChange('123'),
  //         responseBody: '',
  //         expectedRequestUrlPath: apiPaths.userEmailAddressesEmailChangeCodeFormat
  //             .replaceFirst('<emailChangeCode>', '123'),
  //         expectedRequestQueryParams: [],
  //         expectedRequestBody: '',
  //       );
  //     });
  //   });

  //   test('logout method tests', () async {
  //     final n1App = getStandardN1App();
  //     // n1App.setAuthenticationState('123');

  //     await http_helper.performHttpTest(
  //       httpMethod: HttpMethods.GET,
  //       httpCallCallback: n1App.auth().logout,
  //       responseBody: '',
  //       expectedRequestUrlPath: apiPaths.userLogout,
  //       expectedRequestQueryParams: [],
  //     );

  //     expect(n1App.sessionId, isNull);
  //     expect(n1App.authenticated, isFalse);
  //   });
  // });

  // group('LoginResult class tests', () {
  //   test('Constructor tests', () {
  //     testAssertionError(() => LoginResult(success: true, sessionId: null), 'sessionId');
  //     testAssertionError(() => LoginResult(success: true, sessionId: ''), 'sessionId');

  //     testValidAssertion(() => LoginResult(success: false, sessionId: null));

  //     final lr = LoginResult(success: true, sessionId: '123');
  //     expect(lr.success, true);
  //     expect(lr.sessionId, '123');
  //   });
  // });
}
