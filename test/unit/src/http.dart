import 'dart:io';

import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart';
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';
import '../../src/mocks/http.dart';

void main() {
  const expectedCommonHeaderCount = 5;

  test('getStandardHttpClient method Tests', () {
    expect(getStandardHttpClient(), isA<HttpClient>());
  });

  test('setRequestHeadersCommon method Tests', () async {
    late MockHttpHeaders headers;
    await createStandardMockHttpClientScopeForAllRequests(
      additionalMockSetup: (client, requestLocal, response) {
        setRequestHeadersCommon(requestLocal);
        headers = requestLocal.headers as MockHttpHeaders;
      },
      callback: () async {
        // This is an arbitrary http call to trigger HTTP request execution
        await HttpClient().getUrl(Uri.parse('https://google.com'));
      },
      requestHttpMethod: HttpMethods.get,
      responseBody: '',
    );

    final headersMap = headers.headers;
    expect(headersMap.length, expectedCommonHeaderCount);
    expect(headersMap['Pragma'], ['no-cache']);
    expect(headersMap['Cache-Control'], ['no-cache']);
    expect(headersMap['Accept'], ['application/json, text/plain, */*']);
    expect(headersMap['Content-Type'], ['application/json;charset=UTF-8']);
    expect(headersMap['Accept-Encoding'], ['gzip, deflate, br']);
  });

  test('setAuthenticatedRequestHeaders method Tests', () async {
    MockHttpHeaders? headers;
    await createStandardMockHttpClientScopeForAllRequests(
      additionalMockSetup: (client, requestLocal, response) {
        final n1App = getStandardN1App();
        setAuthenticatedRequestHeaders(request: requestLocal, app: n1App);
        headers = requestLocal.headers as MockHttpHeaders;
      },
      callback: () async {
        // This is an arbitrary http call to trigger HTTP request execution
        await HttpClient().getUrl(Uri.parse('https://google.com'));
      },
      requestHttpMethod: HttpMethods.get,
      responseBody: '',
    );

    expect(headers!.headers.length, 6);
    expect(headers!.headers['Authorization'], ['Bearer ']);

    headers = null;
    await createStandardMockHttpClientScopeForAllRequests(
      additionalMockSetup: (client, requestLocal, response) {
        final n1App = getStandardN1App(apiKey: '123');
        setAuthenticatedRequestHeaders(request: requestLocal, app: n1App);
        headers = requestLocal.headers as MockHttpHeaders;
      },
      callback: () async {
        // This is an arbitrary http call to trigger HTTP request execution
        await HttpClient().getUrl(Uri.parse('https://google.com'));
      },
      requestHttpMethod: HttpMethods.get,
      responseBody: '',
    );

    expect(headers!.headers.length, 6);
    expect(headers!.headers['Authorization'], ['Bearer 123']);
  });

  group('_executeStandardHttpRequest consumer methods Tests', () {
    // The tests for this operation (GET) are more thorough than the other operations because they
    // are also testing different combination of the parameters for the _executeStandardHttpRequest
    // method, which only needs to be tested in one place; not for all operations.
    test('executeGetRequestWithTextResponse method Tests', () async {
      final requestCombinations = [
        {
          'query': null,
          'body': null,
          'authenticated': true,
          'responseHttpStatus': HttpStatus.ok,
        },
        {
          'query': {'A': 1},
          'body': 'B',
          'authenticated': false,
          'responseHttpStatus': HttpStatus.ok,
        },
        {
          'query': {'A': 1},
          'body': 'B',
          'authenticated': false,
          'responseHttpStatus': HttpStatus.unauthorized,
        },
        {
          'query': {'A': 1},
          'body': 'B',
          'authenticated': false,
          'responseHttpStatus': HttpStatus.internalServerError,
        },
      ];

      late MockHttpHeaders headers;
      for (var requestCombo in requestCombinations) {
        late String responseText;
        final reqQuery = requestCombo['query'] as Map<String, dynamic>?;
        final reqBody = requestCombo['body'] as String?;
        final reqAuthenticated = requestCombo['authenticated'] as bool;
        final responseHttpStatus = requestCombo['responseHttpStatus'] as int;
        final responseIsError = (responseHttpStatus != HttpStatus.ok);

        late HttpClientOperationResult opResult;
        try {
          opResult = await createStandardMockHttpClientScopeForAllRequests(
            additionalMockSetup: (client, requestLocal, response) {
              headers = requestLocal.headers as MockHttpHeaders;
            },
            callback: () async {
              final n1App = getStandardN1App();
              responseText = await executeGetRequestWithTextResponse(
                '',
                n1App,
                query: reqQuery,
                body: reqBody,
                authenticated: reqAuthenticated,
              );
            },
            requestHttpMethod: HttpMethods.get,
            responseBody: '123',
            responseHttpStatus: responseHttpStatus,
          );
        } on NucleusOneHttpException catch (e) {
          // Verify that an exception was expected and that it has the right HTTP status
          expect(responseIsError, isTrue);
          expect(e.status, responseHttpStatus);
          expect(e.message, '123');
        }

        if (!responseIsError) {
          expect(opResult.request.method, 'GET');
          expect(responseText, '123');
          (reqQuery == null)
              ? expect(opResult.request.uri.query, '')
              : expect(opResult.request.uri.query, 'A=1');
          expect(opResult.request.getBodyAsString(), reqBody ?? '');

          if (reqAuthenticated) {
            expect(headers.headers.length, greaterThan(expectedCommonHeaderCount));
            expect(headers.headers['Authorization'], isNotNull);
          } else {
            expect(headers.headers.length, expectedCommonHeaderCount);
            expect(headers.headers['Authorization'], isNull);
          }
        }
      }
    });

    test('_executeStandardHttpRequest method handles null app and context app tests', () async {
      testAssertionErrorAsync(
        () async => await createStandardMockHttpClientScopeForAllRequests(
          callback: () async {
            await executeDeleteRequest('', app: null, query: {});
          },
          requestHttpMethod: HttpMethods.delete,
          responseBody: '123',
        ),
        'instanceFactory != null',
      );

      testValidAssertionAsync(() async {
        await defineN1AppInScopeAsync(getStandardN1App(), () async {
          await createStandardMockHttpClientScopeForAllRequests(
            callback: () async {
              await executeDeleteRequest('', app: null, query: {});
            },
            requestHttpMethod: HttpMethods.delete,
            responseBody: '123',
          );
        });
      });
    });

    test('executeDeleteRequest method Tests', () async {
      final opResult = await createStandardMockHttpClientScopeForAllRequests(
        callback: () async {
          await executeDeleteRequest(
            '',
            app: getStandardN1App(),
            query: {},
          );
        },
        requestHttpMethod: HttpMethods.delete,
        responseBody: '123',
      );

      expect(opResult.request.method, 'DELETE');
    });

    test('executePostRequest method Tests', () async {
      final opResult = await createStandardMockHttpClientScopeForAllRequests(
        callback: () async {
          await executePostRequest(
            '',
            app: getStandardN1App(),
            query: {},
          );
        },
        requestHttpMethod: HttpMethods.post,
        responseBody: '123',
      );

      expect(opResult.request.method, 'POST');
    });

    test('executePostRequestWithTextResponse method Tests', () async {
      late String responseText;
      final opResult = await createStandardMockHttpClientScopeForAllRequests(
        callback: () async {
          responseText = await executePostRequestWithTextResponse(
            '',
            getStandardN1App(),
            query: {},
          );
        },
        requestHttpMethod: HttpMethods.post,
        responseBody: '123',
      );

      expect(opResult.request.method, 'POST');
      expect(responseText, '123');
    });

    test('executePutRequest method Tests', () async {
      final opResult = await createStandardMockHttpClientScopeForAllRequests(
        callback: () async {
          await executePutRequest(
            '',
            getStandardN1App(),
            query: {},
          );
        },
        requestHttpMethod: HttpMethods.put,
        responseBody: '123',
      );

      expect(opResult.request.method, 'PUT');
    });

    test('executePutRequestWithTextResponse method Tests', () async {
      late String responseText;
      final opResult = await createStandardMockHttpClientScopeForAllRequests(
        callback: () async {
          responseText = await executePutRequestWithTextResponse(
            '',
            getStandardN1App(),
            query: {},
          );
        },
        requestHttpMethod: HttpMethods.put,
        responseBody: '123',
      );

      expect(opResult.request.method, 'PUT');
      expect(responseText, '123');
    });
  });

  group('getQueryParamsString method Tests', () {
    test('Valid query strings', () {
      var s = getQueryParamsString({});
      expect(s, '');

      s = getQueryParamsString({
        'A': 1,
        'B': 1.2,
        'C': true,
        'D': 'XYZ',
      });
      expect(s, 'A=1&B=1.2&C=true&D=XYZ');
    });

    test('Invalid query strings', () {
      final qp = {
        'A': {'B': 1.2}
      };
      expect(
          () => getQueryParamsString(qp),
          throwsA(allOf(
            isUnsupportedError,
            predicate((UnsupportedError e) =>
                e.message == 'Unsupported value type provided in query parameters.'),
          )));
    });
  });

  group('ApiRequestBodyObject class Tests', () {
    final json = '{"A":"1","B":2,"C":3.4}';
    void validateMapContents(Map<String, dynamic> map) {
      expect(map.length, 3);
      expect(map['A'], '1');
      expect(map['B'], 2);
      expect(map['C'], 3.4);
    }

    test('populateFromJson method tests', () {
      final arbo = _ApiRequestBodyObjectTest();
      arbo.populateFromJsonPublic(json);
      validateMapContents(arbo.mapPublic);
    });

    test('toJson method tests', () {
      final arbo = _ApiRequestBodyObjectTest();
      expect(arbo.toJson().length, 0);

      arbo.populateFromJsonPublic(json);
      validateMapContents(arbo.toJson());
    });
  });

  group('NucleusOneHttpException class tests', () {
    test('Constructor test', () {
      var e = NucleusOneHttpException(200);
      expect(e.status, 200);
      expect(e.message, isNull);

      e = NucleusOneHttpException(500, 'abc');
      expect(e.status, 500);
      expect(e.message, 'abc');
    });

    test('fromJsonSafe factory constructor test', () {
      var e = NucleusOneHttpException.fromJsonSafe(200, 'abc');
      expect(e.status, 200);
      expect(e.message, 'abc');

      e = NucleusOneHttpException.fromJsonSafe(500, '{"message":"xyz"}');
      expect(e.status, 500);
      expect(e.message, 'xyz');
    });
  });

  group('StandardQueryParams class tests', () {
    test('get method test', () {
      var sqp = StandardQueryParams.get();
      expect(sqp.isEmpty, isTrue);

      sqp = StandardQueryParams.get();
      expect(sqp.isEmpty, isTrue);

      sqp = StandardQueryParams.get(
        callbacks: [
          (sqp) => sqp.cursor('123'),
        ],
      );
      expect(sqp.length, 1);
    });

    test('Standard methods test', () {
      void performTest<T>(
          String keyName, T value, void Function(StandardQueryParams, T?) sqpCallback) {
        // Test that a null value is correctly handled
        var sqp = StandardQueryParams.get(
          callbacks: [
            (sqp) => sqpCallback(sqp, null),
          ],
        );
        expect(sqp.isEmpty, isTrue);

        // Test that a value is correctly handled
        sqp = StandardQueryParams.get(
          callbacks: [
            (sqp) => sqpCallback(sqp, value),
          ],
        );
        expect(sqp.length, 1);
        expect(sqp[keyName], value);
      }

      performTest<bool>('sortDescending', true, (sqp, value) => sqp.sortDescending(value));
      performTest<String>('sortType', '123', (sqp, value) => sqp.sortType(value));
      performTest<int>('offset', 123, (sqp, value) => sqp.offset(value));
      performTest<String>('cursor', '123', (sqp, value) => sqp.cursor(value));
    });
  });
}

class _ApiRequestBodyObjectTest extends ApiRequestBodyObject {
  Map<String, dynamic> get mapPublic => map;
  void populateFromJsonPublic(String json) => populateFromJson(json);
}
