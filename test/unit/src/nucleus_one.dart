import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';
import '../../src/mocks/http.dart';

void main() {
  final getIt = GetIt.instance;

  group('NucleusOne class tests', () {
    test('intializeSdk method test', () async {
      try {
        expect(getIt.isRegistered<NucleusOneApp>(), isFalse);
        await NucleusOne.intializeSdk();
        expect(getIt.isRegistered<NucleusOneApp>(), isTrue);
        expect(getIt.get<NucleusOneApp>(), isA<NucleusOneAppUninitialized>());
      } finally {
        if (getIt.isRegistered<NucleusOneApp>()) {
          getIt.unregister<NucleusOneApp>(instance: getIt.get<NucleusOneApp>());
        }
      }
    });

    group('Tests depending on NucleusOneApp singleton', () {
      setUp(() {
        getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
      });

      tearDown(() {
        // Unregister the singleton, so that this can be reinitialized later
        getIt.unregister<NucleusOneApp>(instance: NucleusOne.app());
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
        getIt.unregister<NucleusOneApp>(instance: n1App);
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

    test('document method tests', () {
      final n1App = getStandardN1App();

      final doc = n1App.documents();
      expect(doc.app, n1App);
    });

    test('Request headers tests (_setRequestHeadersCommon && _setRequestHeadersAuthCookie)',
        () async {
      // Test in three iterations:
      // 1) No session
      // 2) Session, but AuthProvider
      // 3) Session and AuthProvider
      for (var i = 0; i <= 2; ++i) {
        final setSession = (i == 1);
        final authenticated = (i == 2);
        HttpClientOperationResult? opResult;

        try {
          opResult = await createMockHttpClientScopeForGetRequest(
            callback: () async {
              final n1App = getStandardN1App();

              if (setSession) {
                n1App.setSessionId('abc123');
              } else if (authenticated) {
                n1App.setAuthProvider(AuthProvider.google, 'abc123');
              }

              // This is an arbitrary method call to trigger an HttpClient request
              await n1App.documents().getCount(true, true);
            },
            responseBody: '0',
          );
        } on RangeError catch (e) {
          // An exception is only expected on the second iteration, where session id has been set, but
          // not auth provider configured.
          if (i != 1) {
            rethrow;
          }
          expect(e.message, startsWith('Invalid auth provider: '));
        }

        if (i != 1) {
          expect(opResult!.headers.headers.length, authenticated ? 6 : 5);
          opResult.headers.expectContainsAllKeys(
              ['Pragma', 'Cache-Control', 'Accept', 'Content-Type', 'Accept-Encoding']);
          if (authenticated) {
            opResult.headers.expectContainsAllKeys(['Cookie']);
          }
        }
      }
    });
  });

  group('Document class tests', () {
    test('Constructor tests', () {
      final n1App = getStandardN1App();

      final doc = Document(app: n1App);
      expect(doc.app, n1App);
    });

    test('getCount method tests', () async {
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
            final docCount = await n1App.documents().getCount(ignoreInbox, ignoreRecycleBin);
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

        var requestWriteCalled = false;
        await createMockHttpClientScopeForPostRequest(
            callback: () async {
              final n1App = getStandardN1App();

              final loginResult = await n1App.auth().loginGoogle(1, 'oauthTokenAbc');

              expect(requestWriteCalled, isTrue);
              if (success) {
                expect(loginResult.success, isTrue);
                expect(loginResult.sessionId, sessionId);
                expect(n1App.sessionId, sessionId);
                expect(n1App.authProvider, AuthProvider.google);
              } else {
                expect(loginResult.success, isFalse);
                expect(loginResult.sessionId, isNull);
                expect(n1App.sessionId, isNull);
                expect(n1App.authProvider, isNull);
              }
            },
            additionalMockSetup: (client, request, response) {
              when(() => request.write(any())).thenAnswer((_) {
                requestWriteCalled = true;
                return;
              });
            },
            responseBody: '0',
            responseCookies: responseCookies);
      }
    });
  });

  group('AuthProvider enum tests', () {
    test('Value count tests', () {
      expect(AuthProvider.values.length, 1);
      expect(AuthProvider.values[0], AuthProvider.google,
          reason: 'Unexpected enum value at this index');
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
