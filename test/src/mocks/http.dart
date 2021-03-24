import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {
  final headers = <String, List<String>>{};

  void expectContainsAllKeys(List<String> keys) {
    for (var key in keys) {
      expect(headers.containsKey(key), isTrue, reason: 'The "$key" key is expected');
    }
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    var values = headers[name];
    if (values == null) {
      headers[name] = values = <String>[];
    }
    if (value is DateTime) {
      values.add(HttpDate.format(value));
    } else {
      values.add(value);
    }
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    headers.remove(name);
    add(name, value);
  }
}

class HttpClientOperationResult {
  MockHttpClient client;
  MockHttpClientRequest request;
  Uri requestUri;
  MockHttpClientResponse response;
  MockHttpHeaders headers;
  final body = <int>[];

  String getBodyAsString() {
    if (body == null) {
      return null;
    }
    return utf8.decode(body);
  }

  HttpClientOperationResult()
      : client = MockHttpClient(),
        request = MockHttpClientRequest(),
        response = MockHttpClientResponse(),
        headers = MockHttpHeaders();
}

/// Mocks HttpClient and prepares it for an HTTP GET request.
Future<HttpClientOperationResult> createMockHttpClientScopeForGetRequest<T>({
  @required Future<void> Function() callback,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse) additionalMockSetup,
  List<T> responseBody,
}) async {
  assert(callback != null);

  return _createMockHttpClientScopeForRequestInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext securityContext) {
      return _createMockHttpClientAllRequests(
        httpFunctionFromClientHandler: (client) => client.getUrl,
        additionalMockSetup: additionalMockSetup,
        responseBody: responseBody,
      );
    },
  );
}

/// Mocks HttpClient and prepares it for an HTTP POST request.
Future<HttpClientOperationResult> createMockHttpClientScopeForPostRequest<T>({
  @required Future<void> Function() callback,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse) additionalMockSetup,
  List<T> responseBody,
  Map<String, String> responseCookies,
}) async {
  assert(callback != null);

  return _createMockHttpClientScopeForRequestInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext securityContext) {
      return _createMockHttpClientAllRequests(
        httpFunctionFromClientHandler: (client) => client.postUrl,
        additionalMockSetup: additionalMockSetup,
        responseBody: responseBody,
        responseCookies: responseCookies,
      );
    },
  );
}

/// Mocks HttpClient and prepares it for an HTTP DELETE request.
Future<HttpClientOperationResult> createMockHttpClientScopeForDeleteRequest<T>({
  @required Future<void> Function() callback,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse) additionalMockSetup,
  List<T> responseBody,
  Map<String, String> responseCookies,
}) async {
  assert(callback != null);

  return _createMockHttpClientScopeForRequestInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext securityContext) {
      return _createMockHttpClientAllRequests(
        httpFunctionFromClientHandler: (client) => client.deleteUrl,
        additionalMockSetup: additionalMockSetup,
        responseBody: responseBody,
        responseCookies: responseCookies,
      );
    },
  );
}

Future<HttpClientOperationResult> _createMockHttpClientScopeForRequestInternal<T>({
  Future<void> Function() callback,
  HttpClientOperationResult Function(SecurityContext) createHttpClientHandler,
}) async {
  HttpClientOperationResult opResult;
  return await HttpOverrides.runZoned<Future<HttpClientOperationResult>>(
    () async {
      await callback();
      return opResult;
    },
    createHttpClient: (SecurityContext securityContext) {
      opResult = createHttpClientHandler(securityContext);
      return opResult.client;
    },
  );
}

typedef _HttpUrlFunction = Future<HttpClientRequest> Function(Uri url);

HttpClientOperationResult _createMockHttpClientAllRequests<T>({
  _HttpUrlFunction Function(MockHttpClient) httpFunctionFromClientHandler,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse) additionalMockSetup,
  List<T> responseBody,
  Map<String, String> responseCookies,
}) {
  responseCookies ??= {};

  final httpOpResult = HttpClientOperationResult(),
      client = httpOpResult.client,
      request = httpOpResult.request,
      response = httpOpResult.response;

  final httpFunctionHandler = httpFunctionFromClientHandler(client);
  when(httpFunctionHandler(any)).thenAnswer((Invocation invocation) {
    httpOpResult.requestUri = invocation.positionalArguments[0];
    return Future<HttpClientRequest>.value(request);
  });

  when(request.headers).thenReturn(httpOpResult.headers);
  when(request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(request.write(any)).thenAnswer((realInvocation) {
    final contentAsString = realInvocation.positionalArguments[0].toString();
    httpOpResult.body.addAll(utf8.encode(contentAsString));
  });

  when(response.contentLength).thenReturn(responseBody.length);
  when(response.statusCode).thenReturn(HttpStatus.ok);
  when(response.compressionState).thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(response.cookies).thenReturn(
      responseCookies.entries.map((mapEntry) => Cookie(mapEntry.key, mapEntry.value)).toList());
  when(response.transform(any)).thenAnswer((_) => Stream<T>.fromIterable(responseBody));

  if (additionalMockSetup != null) {
    additionalMockSetup(client, request, response);
  }

  return httpOpResult;
}
