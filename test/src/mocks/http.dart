import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'http.mocks.dart';

/*
The intended names of these mock classes (e.g. CustomMockHttpClientRequest) did not originally include
the "Custom..." prefix.  The "Custom..." prefix was included to workaround an issue (a bug?) with
mockito (5.0.2) complaining about conflicting class names when it regenerate its mock classes.  For
example, it was complaining about our "MockHttpClientRequest" class conflicting with the class of the
same name that it was wanting to generate, even though this behavior is overridden in the "@GenerateMocks"
attribute to be "BaseMockHttpClientRequest" (and it *is* ultimately generated as such).
*/

class CustomMockHttpClientRequest extends BaseMockHttpClientRequest {
  @override
  String method = '';
}

class CustomMockHttpClientResponse extends Mock implements BaseMockHttpClientResponse {
  // @override
  // Stream<S> transform<S>(StreamTransformer<List<int>, S>? streamTransformer) {
  //   if (streamTransformer == null) {
  //     return Stream.empty();
  //   }
  //   return streamTransformer.bind(this);
  // }

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S>? streamTransformer) {
    final r = super.noSuchMethod(Invocation.method(#transform, [streamTransformer]));
    return r as Stream<S>;
  }
}

class CustomMockHttpHeaders extends BaseMockHttpHeaders {
  final headers = <String, List<String>>{};

  void expectContainsAllKeys(List<String> keys) {
    for (var key in keys) {
      expect(headers.containsKey(key), isTrue, reason: 'The "$key" key is expected');
    }
  }

  @override
  void add(String? name, Object? value, {bool? preserveHeaderCase = false}) {
    if (name == null) {
      throw 'The parameter "name" cannot be null.';
    }

    var values = headers[name];
    if (values == null) {
      headers[name] = values = <String>[];
    }
    if (value is DateTime) {
      values.add(HttpDate.format(value));
    } else {
      values.add(value.toString());
    }
  }

  @override
  void set(String? name, Object? value, {bool? preserveHeaderCase = false}) {
    headers.remove(name);
    add(name, value);
  }
}

/*
class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {
  set method(String value);
}

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
      values.add(value.toString());
    }
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    headers.remove(name);
    add(name, value);
  }
}
*/

class HttpClientOperationResult {
  MockHttpClient client;
  CustomMockHttpClientRequest request;
  Uri? requestUri;
  CustomMockHttpClientResponse response;
  CustomMockHttpHeaders headers;
  final body = <int>[];

  String getBodyAsString() {
    return utf8.decode(body);
  }

  HttpClientOperationResult()
      : client = MockHttpClient(),
        request = CustomMockHttpClientRequest(),
        response = CustomMockHttpClientResponse(),
        headers = CustomMockHttpHeaders();
}

/// Mocks HttpClient and prepares it for an HTTP GET request.
Future<HttpClientOperationResult> createMockHttpClientScopeForGetRequest<T>({
  required Future<void> Function() callback,
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) async {
  return _createStandardMockHttpClientScopeForAllRequests(
    callback: callback,
    additionalMockSetup: additionalMockSetup,
    responseBody: responseBody,
    responseCookies: responseCookies,
  );
}

/// Mocks HttpClient and prepares it for an HTTP POST request.
Future<HttpClientOperationResult> createMockHttpClientScopeForPostRequest<T>({
  required Future<void> Function() callback,
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) async {
  return _createStandardMockHttpClientScopeForAllRequests(
    callback: callback,
    additionalMockSetup: additionalMockSetup,
    responseBody: responseBody,
    responseCookies: responseCookies,
  );
}

/// Mocks HttpClient and prepares it for an HTTP DELETE request.
Future<HttpClientOperationResult> createMockHttpClientScopeForDeleteRequest<T>({
  required Future<void> Function() callback,
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) async {
  return _createStandardMockHttpClientScopeForAllRequests(
    callback: callback,
    additionalMockSetup: additionalMockSetup,
    responseBody: responseBody,
    responseCookies: responseCookies,
  );
}

/// Mocks HttpClient and prepares it for an HTTP PUT request.
Future<HttpClientOperationResult> createMockHttpClientScopeForPutRequest<T>({
  required Future<void> Function() callback,
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) async {
  return _createStandardMockHttpClientScopeForAllRequests(
    callback: callback,
    additionalMockSetup: additionalMockSetup,
    responseBody: responseBody,
    responseCookies: responseCookies,
  );
}

/// Creates the standard MockHttpClient scope for all requests.
Future<HttpClientOperationResult> _createStandardMockHttpClientScopeForAllRequests<T>({
  required Future<void> Function() callback,
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) async {
  return _createMockHttpClientScopeForAllRequestsInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext? securityContext) {
      return _createMockHttpClientAllRequests(
        additionalMockSetup: additionalMockSetup,
        responseBody: responseBody,
        responseCookies: responseCookies,
      );
    },
  );
}

Future<HttpClientOperationResult> _createMockHttpClientScopeForAllRequestsInternal<T>({
  required Future<void> Function() callback,
  required HttpClientOperationResult Function(SecurityContext?) createHttpClientHandler,
}) async {
  late HttpClientOperationResult opResult;
  return await HttpOverrides.runZoned<Future<HttpClientOperationResult>>(
    () async {
      await callback();
      return opResult;
    },
    createHttpClient: (SecurityContext? securityContext) {
      opResult = createHttpClientHandler(securityContext);
      return opResult.client;
    },
  );
}

@GenerateMocks(
  [
    HttpClient,
    HttpClientRequest,
    HttpClientResponse,
    HttpHeaders,
  ],
  customMocks: [
    MockSpec<HttpClientRequest>(as: #BaseMockHttpClientRequest),
    MockSpec<HttpClientResponse>(as: #BaseMockHttpClientResponse),
    MockSpec<HttpHeaders>(as: #BaseMockHttpHeaders),
  ],
)
HttpClientOperationResult _createMockHttpClientAllRequests<T>({
  void Function(MockHttpClient, CustomMockHttpClientRequest, CustomMockHttpClientResponse)?
      additionalMockSetup,
  required List<T> responseBody,
  Map<String, String>? responseCookies,
}) {
  responseCookies ??= {};

  final httpOpResult = HttpClientOperationResult(),
      client = httpOpResult.client,
      request = httpOpResult.request,
      response = httpOpResult.response;

  {
    Future<HttpClientRequest> handleHttpUrlInvocation(Invocation invocation, String httpMethod) {
      httpOpResult.requestUri = invocation.positionalArguments[0];
      request.method = httpMethod;
      return Future.value(request);
    }

    when(client.getUrl(any)).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'GET');
    });
    when(client.deleteUrl(any)).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'DELETE');
    });
    when(client.postUrl(any)).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'POST');
    });
    when(client.putUrl(any)).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'PUT');
    });
  }

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

  // Prior to the null safety migration, the "transform" mock was defined as:
  // when(response.transform(any)).thenAnswer((_) => Stream<T>.fromIterable(responseBody));
  if (responseBody is List<String>) {
    when(response.transform(any)).thenAnswer((_) => Stream<T>.fromIterable(responseBody));
  } else {
    throw UnimplementedError(
        'A "transform(...) mock must be specifically implemented for this type.');
  }

  if (additionalMockSetup != null) {
    additionalMockSetup(client, request, response);
  }

  return httpOpResult;
}

abstract class HttpMethods {
  static const String GET = 'GET';
  static const String DELETE = 'DELETE';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
}
