import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_approvals.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_project.dart';
import 'package:nucleus_one_dart_sdk/src/user.dart';

import 'hierarchy/nucleus_one_app_documents.dart';
import 'hierarchy/nucleus_one_app_fields.dart';
import 'api_model/email_login_options.dart' as api_mod;
import 'hierarchy/nucleus_one_app_users.dart';
import '../nucleus_one_dart_sdk.dart';
import 'http.dart' as http;
import 'model/email_login_options.dart';

final _getIt = GetIt.instance;

/// The entry point for accessing Nucleus One.
abstract class NucleusOne {
  static bool _sdkInitialized = false;

  static NucleusOneApp app() {
    return _getIt<NucleusOneApp>();
  }

  /// Initializes the SDK.  This must be called prior to calling any other SDK methods.
  /// See also: [resetSdk].
  static Future<void> intializeSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    if (_sdkInitialized) {
      throw 'The SDK is already initialized.';
    }

    _getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
    _getIt.registerSingleton<file.FileSystem>(const file.LocalFileSystem());
    _sdkInitialized = true;
  }

  /// Resets the SDK to its initial state.
  /// See also: [intializeSdk].
  static Future<void> resetSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    if (!_sdkInitialized) {
      return;
    }
    _getIt.unregister<NucleusOneApp>();
    _getIt.unregister<file.FileSystem>();
    _sdkInitialized = false;
  }

  /// Initializes a new [NucleusOneApp] instance with [options] and returns the created app.
  /// This method should be called before any usage of any Nucleus One components.
  static Future<NucleusOneApp> initializeApp({
    required NucleusOneOptions options,
  }) async {
    var app = NucleusOne.app();
    if (!(app is NucleusOneAppUninitialized)) {
      throw 'The app is already initialized.';
    }

    // This is effectively the same as "_getIt.unregister<NucleusOneApp>()".
    // We already have the app though, so use it, instead
    _getIt.unregister(instance: app);

    app = NucleusOneAppInternal._(options: options);
    _getIt.registerSingleton<NucleusOneApp>(app);
    return app;
  }
}

class NucleusOneOptions {
  final String baseUrl;
  final int browserFingerprint;

  NucleusOneOptions({
    required this.baseUrl,
    required this.browserFingerprint,
  });
}

abstract class NucleusOneAppDependent {
  NucleusOneAppInternal? _app;
  NucleusOneAppInternal get app {
    _app ??= GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
    return _app!;
  }

  @protected
  set app(NucleusOneAppInternal app) {
    _app = app;
  }
}

class NucleusOneAppUninitialized extends NucleusOneAppInternal {
  NucleusOneAppUninitialized()
      : super(
          options: NucleusOneOptions(
            baseUrl: '',
            browserFingerprint: 0,
          ),
        );
}

class NucleusOneAppInternal extends NucleusOneApp {
  @visibleForTesting
  NucleusOneAppInternal({
    required NucleusOneOptions options,
  }) : this._(options: options);

  NucleusOneAppInternal._({
    required NucleusOneOptions options,
  }) : super(options: options);

  /// Internal use only.
  void setAuthenticationState(String? sessionId) {
    _authenticated = (sessionId != null) && sessionId.isNotEmpty;
    _sessionId = sessionId;
  }

  /// Internal use only.
  bool get authenticated => _authenticated;

  /// Internal use only.
  String? get sessionId => _sessionId;

  /// Internal use only.
  String getFullUrl(String apiRelativeUrlPath) {
    return _baseUrlWithApi + apiRelativeUrlPath;
  }
}

abstract class NucleusOneApp {
  @visibleForTesting
  static const String apiBaseUrlPath = '/api/v1';
  final NucleusOneOptions options;
  final String _baseUrlWithApi;

  @visibleForTesting
  NucleusOneApp({
    required this.options,
  }) : _baseUrlWithApi = options.baseUrl + apiBaseUrlPath;

  bool _authenticated = false;
  String? _sessionId;

  /// Authentication and authorization
  Auth auth() {
    return Auth(app: this as NucleusOneAppInternal);
  }

  /// Documents
  NucleusOneAppDocuments documents() {
    return NucleusOneAppDocuments(app: this as NucleusOneAppInternal);
  }

  /// Classifications
  ClassificationCollection classifications() {
    return ClassificationCollection(app: this as NucleusOneAppInternal);
  }

  /// Fields
  NucleusOneAppFields fields() {
    return NucleusOneAppFields(app: this as NucleusOneAppInternal);
  }

  /// Folder Hierarchies
  FolderHierarchyCollection folderHierarchies() {
    return FolderHierarchyCollection(app: this as NucleusOneAppInternal);
  }

  /// Folder Hierarchy Items
  FolderHierarchyItemCollection folderHierarchyItems() {
    return FolderHierarchyItemCollection(app: this as NucleusOneAppInternal);
  }

  /// FormTemplates
  FormTemplateCollection forms() {
    return FormTemplateCollection(app: this as NucleusOneAppInternal);
  }

  /// Users
  NucleusOneAppUsers users() {
    return NucleusOneAppUsers(app: this as NucleusOneAppInternal);
  }

  /// Approvals
  NucleusOneAppApprovals approvals() {
    return NucleusOneAppApprovals(app: this as NucleusOneAppInternal);
  }

  /// Projects
  NucleusOneAppProjects projects() {
    return NucleusOneAppProjects(app: this as NucleusOneAppInternal);
  }
}

class Auth with NucleusOneAppDependent {
  Auth({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Reestablishes the authentication state to be with the provided auth provider and session id.
  ///
  /// [authProvider]: The authentication provider.
  ///
  /// [sessionId]: An existing session id with the authentication provider.
  LoginResult reestablishExistingSession(String sessionId) {
    app.setAuthenticationState(sessionId);

    return LoginResult(
      success: true,
      sessionId: sessionId,
      user: User(app: app),
    );
  }

  /// Logs in to Nucleus One using Google Sign-In.  If successful, the session information is stored
  /// internally, for use in future requests.
  /// A result is returned, regardless of success.
  Future<LoginResult> loginGoogle(String oauthIdToken) async {
    final signInPackage = {
      'BrowserFingerprint': _getIt.get<NucleusOneApp>().options.browserFingerprint,
      'UserProvider': 'google',
      'OAuthIdToken': oauthIdToken,
    };

    return await _loginInternal(signInPackage);
  }

  /// Logs in to Nucleus One using an email and a one-time passcode.  If successful, the session
  /// information is stored internally, for use in future requests.
  /// A result is returned, regardless of success.
  Future<LoginResult> loginEmailAndOTP(String email, String otp) async {
    final signInPackage = {
      'AuthType': 'email',
      'BrowserFingerprint': _getIt.get<NucleusOneApp>().options.browserFingerprint,
      'Email': email,
      'OTP': otp,
      'UserProvider': 'email',
    };

    return await _loginInternal(signInPackage);
  }

  Future<LoginResult> _loginInternal(Map<String, Object> signInPackage) async {
    final client = http.getStandardHttpClient();
    final clientReq = await client.postUrl(Uri.parse(app.getFullUrl(http.apiPaths.userLogin)));
    http.setRequestHeadersCommon(clientReq);

    clientReq.write(jsonEncode(signInPackage));

    final clientResponse = await clientReq.close();

    final ret = clientResponse.cookies.firstWhereOrNull(
      (element) => element.name == 'session_v1',
    );

    final sessionId = ret?.value;
    final success = (sessionId != null) && sessionId.isNotEmpty;

    if (success) {
      app.setAuthenticationState(sessionId);
    }

    return LoginResult(
      success: success,
      sessionId: success ? sessionId : null,
      user: User(app: app),
    );
  }

  Future<void> logout() async {
    await http.executeGetRequest(
      http.apiPaths.userLogout,
      app,
    );

    app.setAuthenticationState(null);
  }

  /// Verifies whether the provided email address is valid for login.
  ///
  /// [email] The email address.
  Future<EmailLoginOptions> verifyEmailLogin(String email) async {
    final reqBody = {
      'BrowserFingerprint': _getIt.get<NucleusOneApp>().options.browserFingerprint,
      'Email': email,
      'UserProvider': 'email',
    };

    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.userEmailLoginVerify,
      app,
      body: jsonEncode(reqBody),
    );

    final apiModel = api_mod.EmailLoginOptions.fromJson(jsonDecode(responseBody));
    return EmailLoginOptions.fromApiModel(apiModel);
  }

  /// Causes a one-time passcode to be sent to the provided email address.
  ///
  /// [email] The email address.
  Future<void> emailLoginSendOneTimePasscode(String email) async {
    final reqBody = {
      'BrowserFingerprint': _getIt.get<NucleusOneApp>().options.browserFingerprint,
      'UserProvider': 'email',
      'Email': email,
      'AuthType': 'email'
    };

    await http.executePostRequest(
      http.apiPaths.userEmailLoginOTPSend,
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Verifies whether the current email user's email address can be changed to a given email address.
  /// If not, an exception is thrown.
  ///
  /// [newEmail] The new email address to check.
  Future<void> emailLoginVerifyIfAddressCanBeChangedTo(String newEmail) async {
    final reqBody = {
      'Email': newEmail,
    };

    await http.executePostRequest(
      http.apiPaths.userEmailAddressVerifications,
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Changes the current email user's email address.  If successful, a confirmation email will be
  /// sent to the new email address, which must be confirmed before the email address change will
  /// become valid.
  ///
  /// [newEmail] The new email address.
  Future<void> emailLoginChangeAddress(String newEmail) async {
    final reqBody = {
      'Email': newEmail,
    };

    await http.executePostRequest(
      http.apiPaths.userEmailAddresses,
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Completes an email address change request by providing the emailed confirmation code.
  ///
  /// [confirmationCode] The confirmation code provided in the change-confirmation email.
  Future<void> emailLoginConfirmAddressChange(String confirmationCode) async {
    await http.executePutRequest(
      http.apiPaths.userEmailAddressesEmailChangeCodeFormat
          .replaceFirst('<emailChangeCode>', confirmationCode),
      app,
    );
  }
}

class LoginResult {
  final bool success;
  final String? sessionId;
  final User? user;

  LoginResult({
    required this.success,
    this.sessionId,
    this.user,
  }) : assert((!success) || ((sessionId != null) && sessionId.isNotEmpty));
}
