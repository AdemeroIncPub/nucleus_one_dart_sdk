import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

/*
The functionality implemented in these mock classes is only what is applicable for all consumers of
these classes.  Any test-specific logic is extended via mocktail's "when(...).thenAnswer(...)"
functionality.
*/

class MockHttpClientRequest extends Mock implements HttpClientRequest {
  final _body = <int>[];

  @override
  String method = '';

  @override
  Uri uri = Uri.parse('');

  String getBodyAsString() {
    return utf8.decode(_body);
  }
}

class MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  Future pipe(StreamConsumer<List<int>> streamConsumer) {
    return streamConsumer.addStream(this).then((_) => streamConsumer.close());
  }
}

class MockHttpHeaders extends Mock implements HttpHeaders {
  final headers = <String, List<String>>{};

  void expectContainsAllKeys(List<String> keys) {
    for (var key in keys) {
      expect(headers.containsKey(key), isTrue, reason: 'The "$key" key is expected');
    }
  }

  @override
  void add(
    String? name,
    Object? value, {
    bool? preserveHeaderCase = false,
  }) {
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
  void set(
    String? name,
    Object? value, {
    bool? preserveHeaderCase = false,
  }) {
    headers.remove(name);
    add(name, value);
  }

  @override
  List<String>? operator [](String name) => headers[name];
}

class MockHttpClient extends Mock implements HttpClient {}

class HttpClientOperationResult {
  MockHttpClient client;
  MockHttpClientRequest request;
  MockHttpClientResponse response;

  HttpClientOperationResult()
      : client = MockHttpClient(),
        request = MockHttpClientRequest(),
        response = MockHttpClientResponse();

  void requiredCallbackAfterCompletion() {
    reset(client);
    reset(request);
    reset(response);
  }
}

/// Creates the standard MockHttpClient scope for all requests.
Future<HttpClientOperationResult> createStandardMockHttpClientScopeForAllRequests({
  required Future<void> Function() callback,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)? additionalMockSetup,
  required String requestHttpMethod,
  required String responseBody,
  int responseHttpStatus = HttpStatus.ok,
  Map<String, String>? responseCookies,
}) async {
/*
  return (await _createMockHttpClientScopeForAllRequestsInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext? securityContext) {
      return _createMockHttpClientAllRequests(
        additionalMockSetup: additionalMockSetup,
        responseBody: responseBody,
        responseHttpStatus: responseHttpStatus,
        responseCookies: responseCookies,
      );
    },
  ))[0];
*/

  final httpOperation = HttpOperation(
    requestUrl: Uri.parse(''), // Not relevant
    requestHttpMethod: requestHttpMethod,
    requestBody: '', // Not relevant
    responseBody: responseBody,
    responseHttpStatus: responseHttpStatus,
    responseCookies: responseCookies,
  );

  return (await createStandardMockHttpClientScopeForAllRequests2(
    httpOperations: [httpOperation],
    callback: callback,
    additionalMockSetup: additionalMockSetup,
  ))[0];
}

/// Creates the standard MockHttpClient scope for all requests.
Future<List<HttpClientOperationResult>> createStandardMockHttpClientScopeForAllRequests2({
  required List<HttpOperation> httpOperations,
  required Future<void> Function() callback,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)? additionalMockSetup,
}) async {
  late HttpOperation httpOp;
  int httpOpIndex = -1;

  void moveToNextHttpOp() {
    if (++httpOpIndex == httpOperations.length) {
      throw 'The last HttpOperation has already been served.';
    }
    httpOp = httpOperations[httpOpIndex];
  }

  return _createMockHttpClientScopeForAllRequestsInternal(
    callback: callback,
    createHttpClientHandler: (SecurityContext? securityContext) {
      moveToNextHttpOp();
      return _createMockHttpClientAllRequests2(
        additionalMockSetup: additionalMockSetup,
        httpOperation: httpOp,
      );
    },
  );
}

Future<List<HttpClientOperationResult>> _createMockHttpClientScopeForAllRequestsInternal<T>({
  required Future<void> Function() callback,
  required HttpClientOperationResult Function(SecurityContext?) createHttpClientHandler,
}) async {
  final opResults = <HttpClientOperationResult>[];
  return await HttpOverrides.runZoned<Future<List<HttpClientOperationResult>>>(
    () async {
      await callback();
      return opResults;
    },
    createHttpClient: (SecurityContext? securityContext) {
      final opResult = createHttpClientHandler(securityContext);
      opResults.add(opResult);
      return opResult.client;
    },
  );
}

/*
HttpClientOperationResult _createMockHttpClientAllRequests({
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)? additionalMockSetup,
  required String responseBody,
  int responseHttpStatus = HttpStatus.ok,
  Map<String, String>? responseCookies,
}) {
  responseCookies ??= {};

  final httpOpResult = HttpClientOperationResult(),
      client = httpOpResult.client,
      request = httpOpResult.request,
      response = httpOpResult.response;

  {
    Future<HttpClientRequest> handleHttpUrlInvocation(Invocation invocation, String httpMethod) {
      request
        ..uri = invocation.positionalArguments[0]
        ..method = httpMethod;
      return Future.value(request);
    }

    when(() => client.getUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'GET');
    });
    when(() => client.deleteUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'DELETE');
    });
    when(() => client.postUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'POST');
    });
    when(() => client.putUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, 'PUT');
    });
  }

  when(() => request.headers).thenReturn(httpOpResult.headers);
  when(() => request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(() => request.write(any())).thenAnswer((realInvocation) {
    final contentAsString = realInvocation.positionalArguments[0].toString();
    httpOpResult.request._body.addAll(utf8.encode(contentAsString));
  });

  when(() => response.contentLength).thenReturn(responseBody.length);
  when(() => response.statusCode).thenReturn(responseHttpStatus);
  when(() => response.compressionState)
      .thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(() => response.cookies).thenReturn(
      responseCookies.entries.map((mapEntry) => Cookie(mapEntry.key, mapEntry.value)).toList());
  when(() => response.transform(utf8.decoder)).thenAnswer((_) {
    return Stream.value(responseBody);
  });
  // Originally from https://stackoverflow.com/a/49642337
  when(() => response.listen(
        any(),
        onError: any(named: 'onError'),
        onDone: any(named: 'onDone'),
        cancelOnError: any(named: 'cancelOnError'),
      )).thenAnswer((Invocation invocation) {
    final void Function(List<int>) onData = invocation.positionalArguments[0];
    final void Function() onDone = invocation.namedArguments[#onDone];
    final void Function(Object, StackTrace) onError = invocation.namedArguments[#onError];
    final bool cancelOnError = invocation.namedArguments[#cancelOnError];
    final responseBodyBytes = utf8.encode(responseBody);
    return Stream<List<int>>.value(responseBodyBytes).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  });

  if (additionalMockSetup != null) {
    additionalMockSetup(client, request, response);
  }

  return httpOpResult;
}*/

HttpClientOperationResult _createMockHttpClientAllRequests2({
  required HttpOperation httpOperation,
  void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)? additionalMockSetup,
}) {
  final httpOpResult = HttpClientOperationResult(),
      client = httpOpResult.client,
      request = httpOpResult.request,
      response = httpOpResult.response;

  {
    Future<HttpClientRequest> handleHttpUrlInvocation(Invocation invocation, String httpMethod) {
      if (httpOperation.requestHttpMethod != httpMethod) {
        throw 'Expected HTTP method "${httpOperation.requestHttpMethod}".';
      }

      request
        ..uri = invocation.positionalArguments[0]
        ..method = httpMethod;
      return Future.value(request);
    }

    when(() => client.getUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, HttpMethods.GET);
    });
    when(() => client.deleteUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, HttpMethods.DELETE);
    });
    when(() => client.postUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, HttpMethods.POST);
    });
    when(() => client.putUrl(any())).thenAnswer((Invocation invocation) {
      return handleHttpUrlInvocation(invocation, HttpMethods.PUT);
    });
  }

  when(() => request.headers).thenAnswer((_) {
    return httpOperation.requestHeaders;
  });
  when(() => request.close()).thenAnswer((_) {
    when(() => response.headers).thenAnswer((_) {
      return httpOperation.responseHeaders;
    });
    when(() => response.contentLength).thenAnswer((_) {
      return httpOperation.responseBody.length;
    });
    when(() => response.statusCode).thenAnswer((_) {
      return httpOperation.responseHttpStatus;
    });
    when(() => response.compressionState)
        .thenReturn(HttpClientResponseCompressionState.notCompressed);
    when(() => response.cookies).thenAnswer((_) {
      return httpOperation.responseCookies.entries
          .map((mapEntry) => Cookie(mapEntry.key, mapEntry.value))
          .toList();
    });
    when(() => response.transform(utf8.decoder)).thenAnswer((_) {
      return Stream.value(httpOperation.responseBody);
    });
    // Originally from https://stackoverflow.com/a/49642337
    when(() => response.listen(
          any(),
          onError: any(named: 'onError'),
          onDone: any(named: 'onDone'),
          cancelOnError: any(named: 'cancelOnError'),
        )).thenAnswer((Invocation invocation) {
      final void Function(List<int>) onData = invocation.positionalArguments[0];
      final void Function() onDone = invocation.namedArguments[#onDone];
      final void Function(Object, StackTrace) onError = invocation.namedArguments[#onError];
      final bool? cancelOnError = invocation.namedArguments[#cancelOnError];
      final responseBodyBytes = utf8.encode(httpOperation.responseBody);
      return Stream<List<int>>.value(responseBodyBytes).listen(
        onData,
        onDone: onDone,
        onError: onError,
        cancelOnError: cancelOnError,
      );
    });

    return Future<MockHttpClientResponse>.value(response);
  });
  when(() => request.write(any())).thenAnswer((realInvocation) {
    final pArg0 = realInvocation.positionalArguments[0];
    String contentAsString;
    if (pArg0 is List<int>) {
      contentAsString = pArg0.map((x) => String.fromCharCode(x)).join();
    } else {
      contentAsString = pArg0.toString();
    }
    httpOpResult.request._body.addAll(utf8.encode(contentAsString));
  });

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

class HttpOperation {
  final bool isN1ApiOperation;
  final Uri requestUrl;
  final String requestHttpMethod;
  final void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)?
      additionalMockSetup;
  final MockHttpHeaders requestHeaders;
  final List<String> requestQueryParams;
  final String requestBody;
  final String responseBody;
  final int responseHttpStatus;
  final Map<String, String> responseCookies;
  final MockHttpHeaders responseHeaders;

  HttpOperation({
    this.isN1ApiOperation = true,
    required this.requestUrl,
    required this.requestHttpMethod,
    this.additionalMockSetup,
    MockHttpHeaders? requestHeaders,
    List<String>? requestQueryParams,
    required this.requestBody,
    required this.responseBody,
    this.responseHttpStatus = HttpStatus.ok,
    Map<String, String>? responseCookies,
    MockHttpHeaders? responseHeaders,
  })  : requestHeaders = requestHeaders ?? MockHttpHeaders(),
        requestQueryParams = requestQueryParams ?? <String>[],
        responseCookies = responseCookies ?? <String, String>{},
        responseHeaders = responseHeaders ?? MockHttpHeaders();

  HttpOperation shallowCopyWith({
    bool? isN1ApiOperation,
    Uri? requestUrl,
    String? requestHttpMethod,
    void Function(MockHttpClient, MockHttpClientRequest, MockHttpClientResponse)?
        additionalMockSetup,
    MockHttpHeaders? requestHeaders,
    List<String>? requestQueryParams,
    String? requestBody,
    String? responseBody,
    int? responseHttpStatus,
    Map<String, String>? responseCookies,
    MockHttpHeaders? responseHeaders,
  }) {
    return HttpOperation(
      isN1ApiOperation: isN1ApiOperation ?? this.isN1ApiOperation,
      requestUrl: requestUrl ?? this.requestUrl,
      requestHttpMethod: requestHttpMethod ?? this.requestHttpMethod,
      additionalMockSetup: additionalMockSetup ?? this.additionalMockSetup,
      requestHeaders: requestHeaders ?? this.requestHeaders,
      requestQueryParams: requestQueryParams ?? this.requestQueryParams,
      requestBody: requestBody ?? this.requestBody,
      responseBody: responseBody ?? this.responseBody,
      responseHttpStatus: responseHttpStatus ?? this.responseHttpStatus,
      responseCookies: responseCookies ?? this.responseCookies,
      responseHeaders: responseHeaders ?? this.responseHeaders,
    );
  }
}
