import 'dart:convert';
import 'dart:io';

import 'package:nucleus_one_dart_sdk/src/common/string.dart';

import 'nucleus_one.dart';

// static HttpClient _getHttpClientWithProxy() {
//   final client = HttpClient();
//   client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
//   client.findProxy = (uri) {
//     return 'PROXY 192.168.1.105:8888;';
//   };
//   return client;
// }

HttpClient getStandardHttpClient() {
  return HttpClient();
}

enum _HttpMethod { delete, get, post, put }

void setRequestHeadersCommon(HttpClientRequest request) {
  final headers = request.headers;
  // headers.clear();
  // headers.set('Host', 'localhost:8080');
  // headers.set('Connection', 'keep-alive');
  // headers.set('Content-Length', '1317');
  headers.set('Pragma', 'no-cache');
  headers.set('Cache-Control', 'no-cache');
  headers.set('Accept', 'application/json, text/plain, */*');
  // headers.set('User-Agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36');
  headers.set('Content-Type', 'application/json;charset=UTF-8');
  // headers.set('Origin', 'http://localhost:3000');
  // headers.set('Sec-Fetch-Site', 'same-site');
  // headers.set('Sec-Fetch-Mode', 'cors');
  // headers.set('Sec-Fetch-Dest', 'empty');
  // headers.set('Referer', 'http://localhost:3000/login');
  headers.set('Accept-Encoding', 'gzip, deflate, br');
  // headers.set('Accept-Language', 'en-US,en;q=0.9');
  // headers.set('Cookie', 'G_AUTHUSER_H=0');
}

void setAuthenticatedRequestHeaders(HttpClientRequest request, NucleusOneAppInternal app) {
  setRequestHeadersCommon(request);
  setRequestHeadersAuthCookie(request, app);
}

void setRequestHeadersAuthCookie(HttpClientRequest request, NucleusOneAppInternal app) {
  //'Cookie': 'LoginUserName=ssouser@qwertyuiop.com; G_AUTHUSER_H=1; session_v1=IPY07xOR9mycvzscLy-yZTY5n3YqBqlqKNZ8Vg6aHlI',
  final headers = request.headers;

  if (app.sessionId != null) {
    // headers.set('Cookie',
    //     'LoginUserName=ssouser@qwertyuiop.com; G_AUTHUSER_H=1; session_v1=IPY07xOR9mycvzscLy-yZTY5n3YqBqlqKNZ8Vg6aHlI');

    switch (app.authProvider) {
      case AuthProvider.google:
        headers.set('Cookie', 'G_AUTHUSER_H=1; session_v1=${app.sessionId}');
        break;
      default:
        throw 'Invalid auth provider: _authProvider';
    }
  }
}

String _getQueryParamsString(Map<String, dynamic> queryParams) {
  Map<String, dynamic> stringifyQueryParamValuesRecursive(Map<String, dynamic> qps) {
    // Ensure the map is an instance of Map<String, dynamic>
    qps = qps.map<String, dynamic>((key, value) => MapEntry(key, value));

    final keys = qps.keys.toList();
    final count = keys.length;

    for (var i = 0; i < count; ++i) {
      final qpKey = keys[i];
      final qp = qps[qpKey];

      if (!(qp is String)) {
        if ((qp is bool) || (qp is int)) {
          qps[qpKey] = qp.toString();
        } else if (qp is Iterable) {
          // The only nested structures we support are Map<String, dynamic>
          qps[qpKey] = stringifyQueryParamValuesRecursive(qp as Map<String, dynamic>);
        } else {
          throw 'Unsupported value type provided in query parameters.';
        }
      }
    }
    return qps;
  }

  queryParams = stringifyQueryParamValuesRecursive(queryParams);

  return Uri(queryParameters: queryParams).query;
}

Future<HttpClientResponse> _executeStandardHttpRequest(
    bool authenticated,
    NucleusOneAppInternal app,
    String apiRelativeUrlPath,
    Map<String, dynamic> qp,
    String body,
    _HttpMethod method) async {
  authenticated ??= true;

  HttpClientRequest clientReq;

  {
    final qpAsString = (qp == null) ? '' : '?' + _getQueryParamsString(qp);
    final fullUrl = app.getFullUrl(apiRelativeUrlPath) + qpAsString;
    final parsedUri = Uri.parse(fullUrl);
    final httpClient = getStandardHttpClient();

    switch (method) {
      case _HttpMethod.delete:
        clientReq = await httpClient.deleteUrl(parsedUri);
        break;
      case _HttpMethod.get:
        clientReq = await httpClient.getUrl(parsedUri);
        break;
      case _HttpMethod.post:
        clientReq = await httpClient.postUrl(parsedUri);
        break;
      case _HttpMethod.put:
        clientReq = await httpClient.putUrl(parsedUri);
        break;
    }
  }

  if (authenticated) {
    setAuthenticatedRequestHeaders(clientReq, app);
  } else {
    setRequestHeadersCommon(clientReq);
  }

  if (isNotEmpty(body)) {
    clientReq.write(body);
  }

  return await clientReq.close();
}

Future<String> executeGetRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic> query,
  String body,
  bool authenticated = true,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.get);
  final responseBody = await clientResponse.transform(utf8.decoder).join();
  return responseBody;
}

Future<void> executeDeleteRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic> query,
  String body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.delete);
}

Future<void> executePutRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic> query,
  String body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.put);
}

abstract class apiPaths {
  static const addressBookItems = '/addressBookItems';
  static const dashboardWidgets = '/dashboardWidgets';
  static const documentCounts = '/documentCounts';
}
