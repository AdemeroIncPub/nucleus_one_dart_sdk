import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

final getIt = GetIt.instance;

/// The entry point for accessing Nucleus One.
abstract class NucleusOne {
  static NucleusOneApp app() {
    return getIt<NucleusOneApp>();
  }

  /// Initializes the SDK.  This must be called prior to calling any other SDK methods.
  static Future<void> intializeSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    getIt.registerSingleton<NucleusOneApp>(NucleusOneAppUninitialized());
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

    getIt.unregister<NucleusOneApp>(instance: app);

    app = NucleusOneApp._(options: options);
    getIt.registerSingleton<NucleusOneApp>(app);
    return app;
  }
}

class NucleusOneOptions {
  final String baseUrl;

  NucleusOneOptions({
    @required this.baseUrl,
  }) : assert(baseUrl != null);
}

class NucleusOneAppUninitialized extends NucleusOneApp {
  NucleusOneAppUninitialized() : super(options: NucleusOneOptions(baseUrl: ''));
}

class NucleusOneApp {
  @visibleForTesting
  static const String apiBaseUrlPath = '/api/v1';
  final NucleusOneOptions options;
  final String _baseUrlWithApi;

  @visibleForTesting
  NucleusOneApp({
    NucleusOneOptions options,
  }) : this._(options: options);

  NucleusOneApp._({
    @required this.options,
  })  : assert(options != null),
        _baseUrlWithApi = options.baseUrl + apiBaseUrlPath;

  String _sessionId;
  AuthProvider _authProvider;

  /// Internal use only.
  @visibleForTesting
  String get sessionId => _sessionId;

  /// Internal use only.
  @visibleForTesting
  AuthProvider get authProvider => _authProvider;

  // static HttpClient _getHttpClientWithProxy() {
  //   final client = HttpClient();
  //   client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  //   client.findProxy = (uri) {
  //     return 'PROXY 192.168.1.105:8888;';
  //   };
  //   return client;
  // }

  HttpClient _getStandardHttpClient() {
    return HttpClient();
  }

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
  }

  /// Internal use only.
  @visibleForTesting
  void setAuthProvider(AuthProvider authProvider, String sessionId) {
    _authProvider = authProvider;
    _sessionId = sessionId;
  }

  /// Internal use only.
  @visibleForTesting
  String getFullUrl(String urlPath) {
    return _baseUrlWithApi + urlPath;
  }

  /// Authentication and authorization
  Auth auth() {
    return Auth(app: this);
  }

  /// Documents
  Document document() {
    return Document(app: this);
  }

  void _setRequestHeadersCommon(HttpClientRequest request) {
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

  void _setRequestHeadersAuthCookie(HttpClientRequest request) {
    //'Cookie': 'LoginUserName=ssouser@qwertyuiop.com; G_AUTHUSER_H=1; session_v1=IPY07xOR9mycvzscLy-yZTY5n3YqBqlqKNZ8Vg6aHlI',
    final headers = request.headers;

    if (_sessionId != null) {
      // headers.set('Cookie',
      //     'LoginUserName=ssouser@qwertyuiop.com; G_AUTHUSER_H=1; session_v1=IPY07xOR9mycvzscLy-yZTY5n3YqBqlqKNZ8Vg6aHlI');

      switch (_authProvider) {
        case AuthProvider.google:
          headers.set('Cookie', 'G_AUTHUSER_H=1; session_v1=${_sessionId}');
          break;
        default:
          throw 'Invalid auth provider: _authProvider';
      }
    }
  }
}

class Auth {
  final NucleusOneApp app;

  Auth({
    @required this.app,
  }) : assert(app != null);

  /// Logs in to Nucleus One using Google Sign-In.  If successful, the session information is stored
  /// internally, for use in future requests.
  /// A result is returned, regardless of success.
  Future<LoginResult> loginGoogle(int browserFingerprint, String oauthIdToken) async {
    final signInPackage = {
      'BrowserFingerprint': browserFingerprint,
      'UserProvider': 'google',
      'OAuthIdToken': oauthIdToken,
    };

    final client = app._getStandardHttpClient();
    final clientReq = await client.postUrl(Uri.parse(app.getFullUrl('/user/login')));
    app._setRequestHeadersCommon(clientReq);

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
    );
  }
}

class Document {
  final NucleusOneApp app;

  Document({
    @required this.app,
  }) : assert(app != null);

  /// This is the getCount method.
  Future<int> getCount(bool ignoreInbox, bool ignoreRecycleBin) async {
    ignoreInbox ??= false;
    ignoreRecycleBin ??= false;

    final fullUrl = app.getFullUrl('/documentCounts') +
        '?ignoreInbox=' +
        ignoreInbox.toString() +
        '&ignoreRecycleBin=' +
        ignoreRecycleBin.toString();
    final client = app._getStandardHttpClient();
    final clientReq = await client.getUrl(Uri.parse(fullUrl));
    app._setRequestHeadersCommon(clientReq);
    app._setRequestHeadersAuthCookie(clientReq);

    final clientResponse = await clientReq.close();
    final responseBody = await clientResponse.transform(utf8.decoder).join();
    return int.parse(responseBody);
  }
}

enum AuthProvider { google }

class LoginResult {
  final bool success;
  final String sessionId;

  LoginResult({
    @required this.success,
    this.sessionId,
  })  : assert(success != null),
        assert((!success) || ((sessionId != null) && sessionId.isNotEmpty));
}
