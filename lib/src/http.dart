import 'dart:convert';
import 'dart:io';

import 'package:file/file.dart' as file;
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
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

    // switch (app.authProvider) {
    //   case AuthProvider.google:
    //     headers.set('Cookie', 'G_AUTHUSER_H=1; session_v1=${app.sessionId}');
    //     break;
    //   default:
    //     throw RangeError('Invalid auth provider: ${app.authProvider}');
    // }

    headers.set('Cookie', 'session_v1=${app.sessionId}');
  }
}

@visibleForTesting
String getQueryParamsString(Map<String, dynamic> queryParams) {
  Map<String, dynamic> stringifyQueryParamValuesRecursive(Map<String, dynamic> qps) {
    // Ensure the map is an instance of Map<String, dynamic>
    qps = qps.map<String, dynamic>((key, value) => MapEntry(key, value));

    final keys = qps.keys.toList();
    final count = keys.length;

    for (var i = 0; i < count; ++i) {
      final qpKey = keys[i];
      final qp = qps[qpKey];

      if (!(qp is String)) {
        if ((qp is bool) || (qp is int) || (qp is double)) {
          qps[qpKey] = qp.toString();
        } else {
          throw UnsupportedError('Unsupported value type provided in query parameters.');
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
    Map<String, dynamic>? qp,
    String? body,
    _HttpMethod method) async {
  HttpClientRequest clientReq;

  {
    final qpAsString = ((qp == null) || qp.isEmpty) ? '' : '?' + getQueryParamsString(qp);
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

  final resp = await clientReq.close();

  if (resp.statusCode != HttpStatus.ok) {
    final respBody = await resp.transform(utf8.decoder).join();
    throw HttpException.fromJsonSafe(resp.statusCode, respBody);
  }

  return resp;
}

Future<String> executeGetRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  final clientResponse =
      await _executeGetRequestInternal(authenticated, app, apiRelativeUrlPath, query, body);
  final respBody = await clientResponse.transform(utf8.decoder).join();
  return respBody;
}

Future<HttpClientResponse> executeGetRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  return await _executeGetRequestInternal(authenticated, app, apiRelativeUrlPath, query, body);
}

Future<HttpClientResponse> _executeGetRequestInternal(bool authenticated, NucleusOneAppInternal app,
    String apiRelativeUrlPath, Map<String, dynamic>? query, String? body) async {
  return await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.get);
}

Future<void> executeDeleteRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.delete);
}

Future<String> executePostRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.post);
  final respBody = await clientResponse.transform(utf8.decoder).join();
  return respBody;
}

Future<void> executePostRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.post);
}

Future<void> executePutRequest(
  String apiRelativeUrlPath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.put);
}

/// Downloads a file to disk.
///
/// [documentId]: The document id to process.
///
/// [destinationDirectory]: The directory in which to save the downloaded file.
Future<void> downloadAuthenticated(
  String apiRelativeUrlPath,
  String destFilePath,
  NucleusOneAppInternal app, {
  Map<String, dynamic>? query,
}) async {
  final response = await _executeGetRequestInternal(true, app, apiRelativeUrlPath, query, null);
  final fs = GetIt.instance.get<file.FileSystem>();
  final fileStream = fs.file(destFilePath).openWrite();
  await response.pipe(fileStream);
}

abstract class apiPaths {
  static const addressBookItems = '/addressBookItems';
  static const approvals = '/approvals';
  static const billingOrganizationSubscriptionsFormat = '/billing/organizationSubscriptions/<organizationId>';
  static const billingSubscriptionInvoicesFormat = '/billing/subscriptionInvoices/<organizationId>';
  static const billingSubscriptionPlansFormat = '/billing/subscriptionPlans/<organizationId>';
  static const classifications = '/classifications';
  static const dashboardWidgets = '/dashboardWidgets';
  static const documentActionsRestoreFromRecycleBin = '/documentActions/restoreFromRecycleBin';
  static const documentActionsSendToRecycleBin = '/documentActions/sendToRecycleBin';
  static const documentContentPackagesFormat = '/documentContentPackages/<documentId>';
  static const documentFields = '/documentFields';
  static const documentPackageFormat = '/documentPackages/<documentId>';
  static const documents = '/documents';
  static const documentsCommentsFormat = '/documents/<documentId>/comments';
  static const documentsEventsFormat = '/documents/<documentId>/events';
  static const documentCounts = '/documentCounts';
  static const fields = '/fields';
  static const fieldsFormat = '/fields/<fieldId>';
  static const fieldsListItemsFormat = '/fields/<fieldId>/listItems';
  static const folderHierarchies = '/folderHierarchies';
  static const folderHierarchiesFormat = '/folderHierarchies/<folderHierarchyId>';
  static const folderHierarchiesItemsFormat = '/folderHierarchies/<folderHierarchyId>/items';
  static const folderHierarchiesItemsItemFormat =
      '/folderHierarchies/<folderHierarchyId>/items/<folderHierarchyItemId>';
  static const formTemplates = '/formTemplates';
  static const formTemplatesPublicFormat = '/formTemplatesPublic/<formTemplateId>';
  static const formTemplatesPublicFieldsFormat = '/formTemplatesPublic/<formTemplateId>/fields';
  static const formTemplatesPublicFieldListItemsFormat =
      '/formTemplatesPublic/<formTemplateId>/fields/<formTemplateFieldId>/listItems';
  static const formTemplatesPublicSubmissions = '/formTemplatesPublic/<formTemplateId>/submissions';
  static const tenantPermissionsFormat = '/tenants/<tenantId>/permissions';
  static const tenantPackagesForCurrentUser = '/tenantPackagesForCurrentUser';
  static const userEmailAddresses = '/user/emailAddresses';
  static const userEmailAddressesEmailChangeCodeFormat = '/user/emailAddresses/<emailChangeCode>';
  static const userEmailAddressVerifications = '/user/emailAddressVerifications';
  static const userEmailLoginOTPSend = '/user/emailLoginOTPSend';
  static const userEmailLoginVerify = '/user/emailLoginVerify';
  static const userLogin = '/user/login';
  static const userLogout = '/user/logout';
  static const userProfile = '/user/profile';
  static const userPreferences = '/user/preferences';
  static const userPreferenceFormat = '/user/preferences/<singleUserPreferenceId>';
  static const userSmsNumbers = '/user/smsNumbers';
  static const userSmsNumbersSmsChangeCodeFormat = '/user/smsNumbers/<smsChangeCode>';
  static const documentUploads = '/documentUploads';
  static const inboxCounts = '/inboxCounts';
  static const pageCounts = '/pageCounts';
  static const recycleBinDocumentCounts = '/recycleBinDocumentCounts';
  static const recycleBinInboxCounts = '/recycleBinInboxCounts';
  static const approvalActionsApprove = '/approvalActions/approve';
  static const approvalActionsDeny = '/approvalActions/deny';
  static const approvalActionsDecline = '/approvalActions/decline';
}

abstract class ApiRequestBodyObject {
  @protected
  final map = <String, dynamic>{};

  /// Intended for use by the [jsonEncode] method.
  Map<String, dynamic> toJson() => map;

  @protected
  void populateFromJson(String json) {
    final m = jsonDecode(json) as Map;
    for (var kvp in m.entries) {
      map[kvp.key as String] = kvp.value;
    }
  }
}

/// Provides support for adding common query string parameters.  Values are only included if they
/// are not null.
class StandardQueryParams {
  final _map = <String, dynamic>{};

  static Map<String, dynamic> get([List<void Function(StandardQueryParams sqp)>? callbacks]) {
    final sqp = StandardQueryParams();
    if (callbacks != null) {
      for (var cb in callbacks) {
        cb(sqp);
      }
    }
    return sqp._map;
  }

  void sortDescending(bool? sortDescending) {
    if (sortDescending != null) {
      _map['sortDescending'] = sortDescending;
    }
  }

  void sortType(String? sortType) {
    if (sortType != null) {
      _map['sortType'] = sortType;
    }
  }

  void offset(int? offset) {
    if (offset != null) {
      _map['offset'] = offset;
    }
  }

  void cursor(String? cursor) {
    if (cursor != null) {
      _map['cursor'] = cursor;
    }
  }
}

@immutable
class HttpException implements Exception {
  final String? message;
  final int status;

  HttpException(this.status, [this.message]);

  factory HttpException.fromJsonSafe(int status, String json) {
    String? message;
    try {
      message = (jsonDecode(json) as Map)['message'];
    } catch (e) {
      // The above logic assumes a standard error response from the API, if that wasn't received,
      // then just set the "json" as the message
      message = json;
    }
    return HttpException(status, message);
  }
}
