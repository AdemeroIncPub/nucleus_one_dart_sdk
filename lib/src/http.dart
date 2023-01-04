import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

import 'common/get_it.dart';
import 'common/string.dart';
import 'common/util.dart';
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

void setAuthenticatedRequestHeaders(HttpClientRequest request, NucleusOneApp app) {
  setRequestHeadersCommon(request);

  request.headers.add('Authorization', 'Bearer ${app.options.apiKey ?? ''}');
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
  NucleusOneApp? app,
  String apiRelativeUrlPath,
  Map<String, dynamic>? qp,
  String? body,
  _HttpMethod method,
) async {
  app = app ?? getIt.get<NucleusOneApp>();

  HttpClientRequest clientReq;
  HttpClient? httpClient;
  late HttpClientResponse resp;

  try {
    httpClient = getStandardHttpClient();

    {
      final qpAsString = ((qp == null) || qp.isEmpty) ? '' : '?' + getQueryParamsString(qp);
      final fullUrl = app.getFullUrl(apiRelativeUrlPath) + qpAsString;
      final parsedUri = Uri.parse(fullUrl);

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

    resp = await clientReq.close();
  } finally {
    httpClient?.close();
  }

  if (resp.statusCode != HttpStatus.ok) {
    final respBody = await resp.readToEnd();
    throw NucleusOneHttpException.fromJsonSafe(resp.statusCode, respBody);
  }

  return resp;
}

Future<String> executeGetRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneApp app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  final clientResponse =
      await _executeGetRequestInternal(authenticated, app, apiRelativeUrlPath, query, body);
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

Future<HttpClientResponse> executeGetRequest(
  String apiRelativeUrlPath,
  NucleusOneApp app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  return await _executeGetRequestInternal(authenticated, app, apiRelativeUrlPath, query, body);
}

Future<HttpClientResponse> _executeGetRequestInternal(bool authenticated, NucleusOneApp app,
    String apiRelativeUrlPath, Map<String, dynamic>? query, String? body) async {
  return await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.get);
}

Future<void> executeDeleteRequest(
  String apiRelativeUrlPath, {
  NucleusOneApp? app,
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.delete);
}

Future<String> executePostRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneApp app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.post);
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

Future<void> executePostRequest(
  String apiRelativeUrlPath, {
  NucleusOneApp? app,
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.post);
}

Future<String> executePutRequestWithTextResponse(
  String apiRelativeUrlPath,
  NucleusOneApp app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.put);
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

Future<void> executePutRequest(
  String apiRelativeUrlPath,
  NucleusOneApp app, {
  Map<String, dynamic>? query,
  String? body,
  bool authenticated = true,
}) async {
  await _executeStandardHttpRequest(
      authenticated, app, apiRelativeUrlPath, query, body, _HttpMethod.put);
}

// /// Downloads a file to disk.
// ///
// /// [documentId]: The document id to process.
// ///
// /// [destinationDirectory]: The directory in which to save the downloaded file.
// Future<void> downloadAuthenticated(
//   String apiRelativeUrlPath,
//   String destFilePath,
//   NucleusOneApp app, {
//   Map<String, dynamic>? query,
// }) async {
//   final response = await _executeGetRequestInternal(true, app, apiRelativeUrlPath, query, null);
//   final fs = getIt.get<file.FileSystem>();
//   final fileStream = fs.file(destFilePath).openWrite();
//   await response.pipe(fileStream);
// }

abstract class apiPaths {
  static const documentSignatureSessionsSigningRecipientsFieldsFormat =
      '/documentSignatureSessions/<documentSignatureSessionId>/signingRecipients/<documentSignatureSessionRecipientId>/fields';
  static const formTemplatesPublicFormat = '/formTemplatesPublic/<formTemplateId>';
  static const formTemplatesPublicFieldsFormat = '/formTemplatesPublic/<formTemplateId>/fields';
  static const formTemplatesPublicFieldListItemsFormat =
      '/formTemplatesPublic/<formTemplateId>/fields/<formTemplateFieldId>/listItems';
  static const formTemplatesPublicSubmissions = '/formTemplatesPublic/<formTemplateId>/submissions';
  static const organizations = '/organizations';
  static const organizationsOrganizationFormat = '/organizations/<organizationId>';
  static const organizationsPermissionsFormat = '/organizations/<organizationId>/permissions';
  static const organizationsProjectsApprovalActionsApproveFormat =
      '/organizations/<organizationId>/projects/<projectId>/approvalActions/approve';
  static const organizationsProjectsApprovalActionsDeclineFormat =
      '/organizations/<organizationId>/projects/<projectId>/approvalActions/decline';
  static const organizationsProjectsApprovalActionsDenyFormat =
      '/organizations/<organizationId>/projects/<projectId>/approvalActions/deny';
  static const organizationsProjectsApprovalsFormat =
      '/organizations/<organizationId>/projects/<projectId>/approvals';
  static const organizationsProjectsCountsDocumentsFormat =
      '/organizations/<organizationId>/projects/<projectId>/counts/documents';
  static const organizationsProjectsCountsPagesFormat =
      '/organizations/<organizationId>/projects/<projectId>/counts/pages';
  static const organizationsProjectsCountsRecycleBinDocumentsFormat =
      '/organizations/<organizationId>/projects/<projectId>/counts/recycleBinDocuments';
  static const organizationsProjectsDocumentActionsRestoreFromRecycleBinFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentActions/restoreFromRecycleBin';
  static const organizationsProjectsDocumentActionsSendToRecycleBinFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentActions/sendToRecycleBin';
  static const organizationsProjectsDocumentContentPackagesFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentContentPackages/<documentId>';
  static const organizationsProjectsDocumentFoldersFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentFolders';
  static const organizationsProjectsDocumentFoldersDocumentFolderFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentFolders/<documentFolderId>';
  static const organizationsProjectsDocumentPackagesFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentPackages/<documentId>';
  static const organizationsProjectsDocumentSubscriptionsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentSubscriptions/<documentId>';
  static const organizationsProjectsDocumentUploadsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documentUploads';
  static const organizationsProjectsDocumentsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents';
  static const organizationsProjectsDocumentsDocumentFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>';
  static const organizationsProjectsDocumentsDocumentCommentsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/comments';
  static const organizationProjectsDocumentsDocumentEventsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/events';
  static const organizationsProjectsDocumentsDocumentSignatureFormsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/signatureForms';
  static const organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/signatureForms/<documentSignatureFormId>';
  static const organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/signatureForms/<documentSignatureFormId>/fields';
  static const organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/signatureForms/<documentSignatureFormId>/fields/<documentSignatureFormFieldId>';
  static const organizationsProjectsDocumentsSignatureSessionPackagesFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/signatureSessionPackages';
  static const organizationsProjectsDocumentsThumbnailsFormat =
      '/organizations/<organizationId>/projects/<projectId>/documents/<documentId>/thumbnails';
  static const organizationsProjectsDocumentsRecentDocumentSignatureFormsFormat =
      '/organizations/<organizationId>/projects/<projectId>/recentDocumentSignatureForms';
  static const organizationsProjectsFieldsFormat =
      '/organizations/<organizationId>/projects/<projectId>/fields';
  static const organizationsProjectsFieldsFieldFormat =
      '/organizations/<organizationId>/projects/<projectId>/fields/<fieldId>';
  static const organizationsProjectsFieldsFieldListItemsFormat =
      '/organizations/<organizationId>/projects/<projectId>/fields/<fieldId>/listItems';
  static const organizationsProjectsFormat = '/organizations/<organizationId>/projects';
  static const organizationsProjectsProjectFormat =
      '/organizations/<organizationId>/projects/<projectId>';
  static const organizationsProjectsFormTemplatesFormat =
      '/organizations/<organizationId>/projects/<projectId>/formTemplates';
  static const organizationsProjectsSignatureFormTemplatesFormat =
      '/organizations/<organizationId>/projects/<projectId>/signatureFormTemplates';
  static const organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat =
      '/organizations/<organizationId>/projects/<projectId>/signatureFormTemplates/<signatureFormTemplateId>';
  static const organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat =
      '/organizations/<organizationId>/projects/<projectId>/signatureFormTemplates/<signatureFormTemplateId>/fields';
  static const organizationsProjectsTasksFormat =
      '/organizations/<organizationId>/projects/<projectId>/tasks';
  static const organizationsProjectsTasksTaskFormat =
      '/organizations/<organizationId>/projects/<projectId>/tasks/<taskId>';
  static const organizationsProjectsTasksTaskCommentsFormat =
      '/organizations/<organizationId>/projects/<projectId>/tasks/<taskId>/comments';
  static const organizationsSubscriptionsFormat = '/organizations/<organizationId>/subscriptions';
  static const organizationsSubscriptionsInvoicesFormat =
      '/organizations/<organizationId>/subscriptions/invoices';
  static const organizationsSubscriptionsPlansFormat =
      '/organizations/<organizationId>/subscriptions/plans';
  static const supportErrorEvents = '/support/errorEvents';
  static const supportOrganizations = '/support/organizations';
  static const supportUsers = '/support/users';
  static const supportAdmin = '/supportAdmin';
  static const userAddressBookItems = '/user/addressBookItems';
  static const userEmailAddresses = '/user/emailAddresses';
  static const userEmailAddressesEmailChangeCodeFormat = '/user/emailAddresses/<emailChangeCode>';
  static const userEmailAddressVerifications = '/user/emailAddressVerifications';
  static const userEmailLoginOTPSend = '/user/emailLoginOTPSend';
  static const userEmailLoginVerify = '/user/emailLoginVerify';
  static const userLogin = '/user/login';
  static const userLogout = '/user/logout';
  static const userOrganizations = '/user/organizations';
  static const userOrganizationsProjectsFormat = '/user/organizations/<organizationId>/projects';
  static const userPreferences = '/user/preferences';
  static const userPreferenceFormat = '/user/preferences/<singleUserPreferenceId>';
  static const userProfile = '/user/profile';
  static const userSmsNumbers = '/user/smsNumbers';
  static const userSmsNumbersSmsChangeCodeFormat = '/user/smsNumbers/<smsChangeCode>';
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
class NucleusOneHttpException implements Exception {
  final String? message;
  final int status;

  NucleusOneHttpException(this.status, [this.message]);

  factory NucleusOneHttpException.fromJsonSafe(int status, String json) {
    String? message;
    try {
      message = (jsonDecode(json) as Map)['message'];
    } catch (e) {
      // The above logic assumes a standard error response from the API, if that wasn't received,
      // then just set the "json" as the message
      message = json;
    }
    return NucleusOneHttpException(status, message);
  }
}
