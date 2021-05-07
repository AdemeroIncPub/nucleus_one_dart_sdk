import 'package:test/test.dart';

import 'common.dart';
import 'mocks/http.dart';

Future<void> performHttpTest<T>({
  required String httpMethod,
  required Future<T> Function() httpCallCallback,
  required String responseBody,
  Map<String, String>? responseCookies,
  required String expectedUrlPath,
  required List<String> expectedQueryParams,
  String? expectedBody,
  void Function(T resultEntity)? additionalValidationsCallback,
}) async {
  Future<HttpClientOperationResult> Function({
    required Future<void> Function() callback,
    void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)?
        additionalMockSetup,
    required String responseBody,
    Map<String, String>? responseCookies,
  }) createMockHttpClientScopeForRequestHandler;

  switch (httpMethod) {
    case HttpMethods.GET:
      createMockHttpClientScopeForRequestHandler = createMockHttpClientScopeForGetRequest;
      break;
    case HttpMethods.DELETE:
      createMockHttpClientScopeForRequestHandler = createMockHttpClientScopeForDeleteRequest;
      break;
    case HttpMethods.POST:
      createMockHttpClientScopeForRequestHandler = createMockHttpClientScopeForPostRequest;
      break;
    case HttpMethods.PUT:
      createMockHttpClientScopeForRequestHandler = createMockHttpClientScopeForPutRequest;
      break;
    default:
      throw UnimplementedError();
  }

  final result = await createMockHttpClientScopeForRequestHandler(
    callback: () async {
      final resultEntity = await httpCallCallback();

      if (additionalValidationsCallback != null) {
        additionalValidationsCallback(resultEntity);
      }
    },
    responseBody: responseBody,
    responseCookies: responseCookies,
  );

  expect(result.request.method, httpMethod);
  expect(result.request.uri.path, apiRequestPathMatches(expectedUrlPath));
  expect(result.request.uri.queryParameters.length, expectedQueryParams.length,
      reason: 'Details:\r\n  Expected (in any order): ' +
          expectedQueryParams.join(',') +
          '\r\n  Actual: ' +
          result.request.uri.queryParameters.entries.map((x) => x.key + '=' + x.value).join(','));
  if (expectedBody != null) {
    expect(result.request.getBodyAsString(), expectedBody);
  }

  final reqUriQuery = result.request.uri.query;
  for (var expectedQP in expectedQueryParams) {
    expect(reqUriQuery, matches('\\b' + RegExp.escape(expectedQP) + '\\b'));
  }
}
