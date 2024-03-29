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

/// Gets a standard [HttpClient] instance.
HttpClient getStandardHttpClient() {
  return HttpClient();
}

/// Implemented HTTP methods
enum _HttpMethod { delete, get, post, put }

/// Sets the standard HTTP headers applicable to all HTTP requests to the Nucleus One API.
///
/// [request]: The [HttpClientRequest] to configure.
@visibleForTesting
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

/// Sets the standard HTTP headers applicable to all HTTP requests to the Nucleus One API.
///
/// [request]: The [HttpClientRequest] to configure.
///
/// [app]: The application to use when connecting to Nucleus One.
@visibleForTesting
void setAuthenticatedRequestHeaders({
  required HttpClientRequest request,
  required NucleusOneApp app,
}) {
  setRequestHeadersCommon(request);

  request.headers.add('Authorization', 'Bearer ${app.options.apiKey ?? ''}');
}

/// Converts a map to a query string.
///
/// [queryParams]: The map to convert.
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

      if (qp is! String) {
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

/// Contains core logic for executing HTTP requests.
///
/// {@template http.standardHttpRequest.params}
/// [authenticated]: Whether this request should include authentication information.
///
/// [app]: The application to use when connecting to Nucleus One.
///
/// [apiRelativeUrlPath]: The relative Nucleus One API path to use when call the API.
///
/// [queryParams]: The query string parameters to include in the URL.
///
/// [body]: The request body.
/// {@endtemplate}
///
/// [method]: The HTTP method to use.
Future<HttpClientResponse> _executeStandardHttpRequest({
  required bool authenticated,
  NucleusOneApp? app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
  required _HttpMethod method,
}) async {
  app = getEffectiveNucleusOneApp(app);

  HttpClientRequest clientReq;
  HttpClient? httpClient;
  final HttpClientResponse resp;

  try {
    httpClient = getStandardHttpClient();

    {
      final qpAsString =
          (queryParams?.isNotEmpty == true) ? '?${getQueryParamsString(queryParams!)}' : '';
      final fullUrl = app.getFullUrl(apiRelativeUrlPath) + qpAsString;
      final parsedUri = Uri.parse(fullUrl);

      Future<HttpClientRequest> getHttpRequestHandler() async {
        switch (method) {
          case _HttpMethod.delete:
            return httpClient!.deleteUrl(parsedUri);
          case _HttpMethod.get:
            return httpClient!.getUrl(parsedUri);
          case _HttpMethod.post:
            return httpClient!.postUrl(parsedUri);
          case _HttpMethod.put:
            return httpClient!.putUrl(parsedUri);
        }
      }

      clientReq = await getHttpRequestHandler();
    }

    if (authenticated) {
      setAuthenticatedRequestHeaders(request: clientReq, app: app);
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

/// Execute an HTTP GET request, returning the response body.
///
/// {@macro http.standardHttpRequest.params}
Future<String> executeGetRequestWithTextResponse({
  bool authenticated = true,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  final clientResponse = await _executeGetRequestInternal(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
  );
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

/// Execute an HTTP GET request, returning the response object.
///
/// {@macro http.standardHttpRequest.params}
Future<HttpClientResponse> executeGetRequest({
  bool authenticated = true,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  return await _executeGetRequestInternal(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
  );
}

/// Contains the core logic for executing an HTTP GET request, returning the response object.
///
/// {@macro http.standardHttpRequest.params}
Future<HttpClientResponse> _executeGetRequestInternal({
  required bool authenticated,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  return await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.get,
  );
}

/// Execute an HTTP DELETE request.
///
/// {@macro http.standardHttpRequest.params}
Future<HttpClientResponse> executeDeleteRequest({
  bool authenticated = true,
  NucleusOneApp? app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  return await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.delete,
  );
}

/// Execute an HTTP POST request, returning the response body.
///
/// {@macro http.standardHttpRequest.params}
Future<String> executePostRequestWithTextResponse({
  bool authenticated = true,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.post,
  );
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

/// Execute an HTTP POST request.
///
/// {@macro http.standardHttpRequest.params}
Future<HttpClientResponse> executePostRequest({
  bool authenticated = true,
  NucleusOneApp? app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  return await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.post,
  );
}

/// Execute an HTTP PUT request, returning the response body.
///
/// {@macro http.standardHttpRequest.params}
Future<String> executePutRequestWithTextResponse({
  bool authenticated = true,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  final clientResponse = await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.put,
  );
  final respBody = await clientResponse.readToEnd();
  return respBody;
}

/// Execute an HTTP PUT request.
///
/// {@macro http.standardHttpRequest.params}
Future<HttpClientResponse> executePutRequest({
  bool authenticated = true,
  required NucleusOneApp app,
  required String apiRelativeUrlPath,
  Map<String, dynamic>? queryParams,
  String? body,
}) async {
  return await _executeStandardHttpRequest(
    authenticated: authenticated,
    app: app,
    apiRelativeUrlPath: apiRelativeUrlPath,
    queryParams: queryParams,
    body: body,
    method: _HttpMethod.put,
  );
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
//   Map<String, dynamic>? queryParams,
// }) async {
//   final response = await _executeGetRequestInternal(true, app, apiRelativeUrlPath, query, null);
//   final fs = getIt.get<file.FileSystem>();
//   final fileStream = fs.file(destFilePath).openWrite();
//   await response.pipe(fileStream);
// }

/// Contains relative URL paths for calling the Nucleus One API.
abstract class ApiPaths {
  static const documentSignatureSessionsSigningRecipientsFieldsFormat =
      '/documentSignatureSessions/<documentSignatureSessionId>/signingRecipients/<documentSignatureSessionRecipientId>/fields';
  static const formTemplatesPublicFormat = '/formTemplatesPublic/<formTemplateId>';
  static const formTemplatesPublicFieldsFormat = '/formTemplatesPublic/<formTemplateId>/fields';
  static const formTemplatesPublicFieldListItemsFormat =
      '/formTemplatesPublic/<formTemplateId>/fields/<formTemplateFieldId>/listItems';
  static const formTemplatesPublicSubmissions = '/formTemplatesPublic/<formTemplateId>/submissions';
  static const logs = '/logs';
  static const organizationMembershipPackages = '/organizationMembershipPackages';
  static const organizationMembershipPackagesFormat =
      '/organizationMembershipPackages/<organizationId>';
  static const organizations = '/organizations';
  static const organizationsOrganizationFormat = '/organizations/<organizationId>';
  static const organizationsOrganizationDocumentSubscriptionsFormat =
      '/organizations/<organizationId>/documentSubscriptions';
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

/// Provides support for adding common query string parameters.  Values are only included if they
/// are not null.
class StandardQueryParams {
  final _map = <String, dynamic>{};

  /// Builds a map containing query string parameters.
  ///
  /// [callbacks]: A list of standard query parameters to include in the map.
  static Map<String, dynamic> get({
    List<void Function(StandardQueryParams sqp)>? callbacks,
  }) {
    final sqp = StandardQueryParams();
    if (callbacks != null) {
      for (var cb in callbacks) {
        cb(sqp);
      }
    }
    return sqp._map;
  }

  /// Contains core logic for setting a map parameter's value.
  ///
  /// [name]: The parameter's name.
  ///
  /// [value]: The parameter's value.
  void _setMapParam<T>(String name, T? value) {
    if (value != null) {
      _map[name] = value;
    }
  }

  /// If not null, includes the 'sortDescending' parameter in the map.
  ///
  /// [sortDescending]: Whether to sort in descending order.
  void sortDescending(bool? sortDescending) => _setMapParam('sortDescending', sortDescending);

  /// If not null, includes the 'sortType' parameter in the map.
  ///
  /// [sortType]: The type of sorting to apply.
  void sortType(String? sortType) => _setMapParam('sortType', sortType);

  /// If not null, includes the 'offset' parameter in the map.
  ///
  /// [offset]: The offset at which to start the returned results.  Used for paging results.
  void offset(int? offset) => _setMapParam('offset', offset);

  /// If not null, includes the 'sortDescending' parameter in the map.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  void cursor(String? cursor) => _setMapParam('cursor', cursor);
}

/// The exception thrown when an HTTP-related error occurs while calling the Nucleus One API.
@immutable
class NucleusOneHttpException implements Exception {
  /// The error message.
  final String? message;

  /// The HTTP status code.
  final int status;

  /// Creates an instance of the [NucleusOneHttpException] class.
  ///
  /// [status]: The HTTP status code.
  ///
  /// [message]: The error message.
  NucleusOneHttpException({
    required this.status,
    this.message,
  });

  /// Creates an instance of the [NucleusOneHttpException] class.  The [message] field's value is
  /// set by decoding a JSON string and extracting its "message" field.  If an error occurs during
  /// this process, [message] is set to the [json] parameter's value.
  ///
  /// [status]: The HTTP status code.
  ///
  /// [json]: The JSON string to extract "message" field from.
  factory NucleusOneHttpException.fromJsonSafe(int status, String json) {
    String? message;
    try {
      message = (jsonDecode(json) as Map)['message'];
    } catch (e) {
      // The above logic assumes a standard error response from the API, if that wasn't received,
      // then just set the "json" as the message
      message = json;
    }
    return NucleusOneHttpException(status: status, message: message);
  }

  @override
  String toString() {
    return message ?? '';
  }
}
