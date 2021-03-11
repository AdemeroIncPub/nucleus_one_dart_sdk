import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:nucleus_one_dart_sdk/src/user.dart';

import '../nucleus_one_dart_sdk.dart';
import 'document.dart';
import 'http.dart' as http;

final _getIt = GetIt.instance;

/// The entry point for accessing Nucleus One.
abstract class NucleusOne {
  static NucleusOneApp app() {
    return _getIt<NucleusOneApp>();
  }

  /// Initializes the SDK.  This must be called prior to calling any other SDK methods.
  static Future<void> intializeSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    _getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
  }

  /// Initializes a new [NucleusOneApp] instance with [options] and returns the created app.
  /// This method should be called before any usage of any Nucleus One components.
  static Future<NucleusOneApp> initializeApp({
    NucleusOneOptions options,
  }) async {
    var app = NucleusOne.app();
    if (!(app is NucleusOneAppUninitialized)) {
      throw 'The app is already initialized.';
    }

    _getIt.unregister<NucleusOneApp>(instance: app);

    app = NucleusOneAppInternal._(options: options);
    _getIt.registerSingleton<NucleusOneApp>(app);
    return app;
  }
}

class NucleusOneOptions {
  final String baseUrl;

  NucleusOneOptions({
    @required this.baseUrl,
  }) : assert(baseUrl != null);
}

abstract class NucleusOneAppDependent {
  NucleusOneAppInternal _app;
  NucleusOneAppInternal get app => _app;
  @protected
  set app(NucleusOneAppInternal app) {
    assert(app != null);
    _app = app;
  }
}

class NucleusOneAppUninitialized extends NucleusOneAppInternal {
  NucleusOneAppUninitialized() : super(options: NucleusOneOptions(baseUrl: ''));
}

class NucleusOneAppInternal extends NucleusOneApp {
  @visibleForTesting
  NucleusOneAppInternal({
    NucleusOneOptions options,
  }) : this._(options: options);

  NucleusOneAppInternal._({
    @required NucleusOneOptions options,
  }) : super(options: options);

  /// Internal use only.
  void setAuthProvider(AuthProvider authProvider, String sessionId) {
    _authProvider = authProvider;
    _sessionId = sessionId;
  }

  /// Internal use only.
  String get sessionId => _sessionId;

  /// Internal use only.
  AuthProvider get authProvider => _authProvider;

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
  }

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
    @required this.options,
  })  : assert(options != null),
        _baseUrlWithApi = options.baseUrl + apiBaseUrlPath;

  String _sessionId;
  AuthProvider _authProvider;

  /// Authentication and authorization
  Auth auth() {
    return Auth(app: this);
  }

  /// Documents
  Document document() {
    return Document(app: this);
  }
}

class Auth with NucleusOneAppDependent {
  Auth({
    @required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Logs in to Nucleus One using Google Sign-In.  If successful, the session information is stored
  /// internally, for use in future requests.
  /// A result is returned, regardless of success.
  Future<LoginResult> loginGoogle(int browserFingerprint, String oauthIdToken) async {
    final signInPackage = {
      'BrowserFingerprint': browserFingerprint,
      'UserProvider': 'google',
      'OAuthIdToken': oauthIdToken,
    };

    final client = http.getStandardHttpClient();
    final clientReq = await client.postUrl(Uri.parse(app.getFullUrl('/user/login')));
    http.setRequestHeadersCommon(clientReq);

    clientReq.write(jsonEncode(signInPackage));

    final clientResponse = await clientReq.close();

    final ret = clientResponse.cookies.firstWhere(
      (element) => element.name == 'session_v1',
      orElse: () => null,
    );

    final sessionId = ret?.value;
    final success = (sessionId != null) && sessionId.isNotEmpty;

    if (success) {
      app.setAuthProvider(AuthProvider.google, sessionId);
    }

    return LoginResult(
      success: success,
      sessionId: success ? sessionId : null,
      user: User(app: app),
    );
  }
}

enum AuthProvider { google }

class LoginResult {
  final bool success;
  final String sessionId;
  final User user;

  LoginResult({
    @required this.success,
    this.sessionId,
    this.user,
  })  : assert(success != null),
        assert((!success) || ((sessionId != null) && sessionId.isNotEmpty));
}
