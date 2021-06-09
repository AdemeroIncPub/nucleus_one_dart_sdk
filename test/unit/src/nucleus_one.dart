import 'dart:async';

import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_approvals.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_documents.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_fields.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_users.dart';
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';
import '../../src/mocks/http.dart';
import '../../src/http_helper.dart' as http_helper;

void main() {
  final getIt = GetIt.instance;

  group('NucleusOne class tests', () {
    test('intializeSdk & resetSdk methods test', () async {
      expect(getIt.isRegistered<NucleusOneApp>(), isFalse);
      await NucleusOne.intializeSdk();
      expect(getIt.isRegistered<NucleusOneApp>(), isTrue);
      expect(getIt.get<NucleusOneApp>(), isA<NucleusOneAppUninitialized>());
      expect(getIt.isRegistered<file.FileSystem>(), isTrue);
      expect(getIt.get<file.FileSystem>(), isA<file.LocalFileSystem>());

      await NucleusOne.resetSdk();
      expect(getIt.isRegistered<NucleusOneApp>(), isFalse);
      expect(getIt.isRegistered<file.FileSystem>(), isFalse);
    });

    group('Tests depending on NucleusOneApp singleton', () {
      setUp(() {
        getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
      });

      tearDown(() {
        // Unregister the singleton, so that this can be reinitialized later
        getIt.unregister<NucleusOneApp>();
      });

      test('Uninitialized NucleusOne app', () {
        final n1App = NucleusOne.app();
        expect(n1App, isA<NucleusOneAppUninitialized>());
      });

      test('Initialized NucleusOne app', () async {
        Future<NucleusOneApp> _reinitializeApp() async {
          return await NucleusOne.initializeApp(
            options: NucleusOneOptions(baseUrl: 'https://steve.com/'),
          );
        }

        var n1App = await _reinitializeApp();
        expect(n1App, isNotNull);

        try {
          await _reinitializeApp();
          fail('An exception should have been thrown since the app is already initialized');
        } catch (e) {
          expect(e, 'The app is already initialized.');
        }

        // Unregister then reregister the singleton, so that we can verify that initializeApp is correctly
        // operating on the singleton
        getIt.unregister<NucleusOneApp>();
        getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());

        n1App = await _reinitializeApp();
        expect(n1App, isNotNull);
      });
    });
  });

  group('NucleusOneOptions class tests', () {
    test('Constructor tests', () {
      testValidAssertion(() => NucleusOneOptions(baseUrl: ''));

      final n1Opts = NucleusOneOptions(baseUrl: 'abc');
      expect(n1Opts.baseUrl, 'abc');
    });
  });

  group('NucleusOneApp class tests', () {
    test('Constructor tests', () {
      final n1Options = NucleusOneOptions(baseUrl: '');
      final n1App = NucleusOneAppInternal(options: n1Options);
      expect(n1App.options, n1Options);
    });

    test('getFullUrl method tests', () {
      const baseUrl = 'https://abc.com';
      final n1App = getStandardN1App(baseUrl);

      expect(n1App.getFullUrl('/test'), baseUrl + NucleusOneApp.apiBaseUrlPath + '/test');
    });

    test('auth method tests', () {
      final n1App = getStandardN1App('https://abc.com');

      final auth = n1App.auth();
      expect(auth.app, n1App);
    });

    test('classifications method tests', () {
      final n1App = getStandardN1App();

      final c = n1App.classifications();
      expect(c, isA<ClassificationCollection>());
      expect(c.app, n1App);
    });

    test('NucleusOneAppDocuments method tests', () {
      final n1App = getStandardN1App();

      final doc = n1App.documents();
      expect(doc, isA<NucleusOneAppDocuments>());
      expect(doc.app, n1App);
    });

    test('NucleusOneAppFields method tests', () {
      final n1App = getStandardN1App();

      final c = n1App.fields();
      expect(c, isA<NucleusOneAppFields>());
      expect(c.app, n1App);
    });

    test('NucleusOneAppUsers method tests', () {
      final n1App = getStandardN1App();

      final c = n1App.users();
      expect(c, isA<NucleusOneAppUsers>());
      expect(c.app, n1App);
    });

    test('NucleusOneAppApprovals method tests', () {
      final n1App = getStandardN1App();

      final c = n1App.approvals();
      expect(c, isA<NucleusOneAppApprovals>());
      expect(c.app, n1App);
    });

    test('Request headers tests (_setRequestHeadersCommon && _setRequestHeadersAuthCookie)',
        () async {
      // Test in three iterations:
      // 1) No session
      // 2) Session
      for (var i = 0; i <= 1; ++i) {
        final authenticated = (i == 1);
        HttpClientOperationResult? opResult;

        opResult = await createMockHttpClientScopeForGetRequest(
          callback: () async {
            final n1App = getStandardN1App();

            if (authenticated) {
              n1App.setAuthenticationState('abc123');
            }

            // This is an arbitrary method call to trigger an HttpClient request
            await NucleusOneAppDocuments(app: n1App).getCount(true, true);
          },
          responseBody: '0',
        );

        if (i != 1) {
          expect(opResult.headers.headers.length, authenticated ? 6 : 5);
          opResult.headers.expectContainsAllKeys(
              ['Pragma', 'Cache-Control', 'Accept', 'Content-Type', 'Accept-Encoding']);
          if (authenticated) {
            opResult.headers.expectContainsAllKeys(['Cookie']);
          }
        }
      }
    });
  });

  group('DocumentForClient class tests', () {
    test('Constructor tests', () {
      final n1App = getStandardN1App();

      final doc = DocumentForClient(app: n1App);
      expect(doc.app, n1App);
    });

    test('getDocumentCount method tests', () async {
      final returnValue = 123;
      final queryParamCombinations = [
        [false, true],
        [true, false],
      ];

      for (var queryParamCombination in queryParamCombinations) {
        final opResult = await createMockHttpClientScopeForGetRequest(
          callback: () async {
            final n1App = getStandardN1App();
            final ignoreInbox = queryParamCombination[0],
                ignoreRecycleBin = queryParamCombination[1];
            final docCount =
                await NucleusOneAppDocuments(app: n1App).getCount(ignoreInbox, ignoreRecycleBin);
            expect(docCount, returnValue);
          },
          responseBody: returnValue.toString(),
        );

        expect(opResult.request.uri.query,
            matches(r'\bignoreInbox=' + queryParamCombination[0].toString() + r'\b'));
        expect(opResult.request.uri.query,
            matches(r'\bignoreRecycleBin=' + queryParamCombination[1].toString() + r'\b'));

        expect(opResult.headers.headers.length, 5);
        opResult.headers.expectContainsAllKeys([
          'Pragma',
          'Cache-Control',
          'Accept',
          'Content-Type',
          'Accept-Encoding' /*, 'Cookie'*/
        ]);
      }
    });
  });

  group('Auth class tests', () {
    test('Constructor tests', () {
      final n1App = getStandardN1App();
      final getValidAuthObject = () => Auth(app: n1App);

      testValidAssertion(getValidAuthObject);

      final auth = getValidAuthObject();
      expect(auth.app, n1App);
    });

    test('reestablishExistingSession method tests', () {
      final n1App = getStandardN1App();
      final auth = n1App.auth();

      final r = auth.reestablishExistingSession('abc');
      expect(r.success, isTrue);
      expect(r.sessionId, 'abc');
      expect(r.user, isNotNull);
    });

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
        await http_helper.performHttpTest<LoginResult>(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () => n1App.auth().loginGoogle(1, 'oauthTokenAbc'),
          responseBody: '',
          responseCookies: responseCookies,
          expectedRequestUrlPath: apiPaths.userLogin,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (loginResult) {
            if (success) {
              expect(loginResult.success, isTrue);
              expect(loginResult.sessionId, sessionId);
              expect(n1App.sessionId, sessionId);
              expect(n1App.authenticated, isTrue);
            } else {
              expect(loginResult.success, isFalse);
              expect(loginResult.sessionId, isNull);
              expect(n1App.sessionId, isNull);
              expect(n1App.authenticated, isFalse);
            }
          },
        );
      }
    });

    test('logout method tests', () async {
      final n1App = getStandardN1App();
      n1App.setAuthenticationState('123');

      await http_helper.performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: n1App.auth().logout,
        responseBody: '',
        expectedRequestUrlPath: apiPaths.userLogout,
        expectedRequestQueryParams: [],
      );

      expect(n1App.sessionId, isNull);
      expect(n1App.authenticated, isFalse);
    });
  });

  group('LoginResult class tests', () {
    test('Constructor tests', () {
      testAssertionError(() => LoginResult(success: true, sessionId: null), 'sessionId');
      testAssertionError(() => LoginResult(success: true, sessionId: ''), 'sessionId');

      testValidAssertion(() => LoginResult(success: false, sessionId: null));

      final lr = LoginResult(success: true, sessionId: '123');
      expect(lr.success, true);
      expect(lr.sessionId, '123');
    });
  });
}
