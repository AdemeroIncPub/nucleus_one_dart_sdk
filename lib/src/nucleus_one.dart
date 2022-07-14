import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'hierarchy/nucleus_one_app_approvals.dart';
import 'hierarchy/nucleus_one_app_forms.dart';
import 'hierarchy/nucleus_one_app_project.dart';
import 'user.dart';

import 'hierarchy/nucleus_one_app_subscriptions.dart';
import 'hierarchy/nucleus_one_app_documents.dart';
import 'api_model/email_login_options.dart' as api_mod;
import 'hierarchy/nucleus_one_app_organization.dart';
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
  final String? apiKey;

  NucleusOneOptions({
    required this.baseUrl,
    this.apiKey,
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

  /// Folder Hierarchies
  FolderHierarchyCollection folderHierarchies() {
    return FolderHierarchyCollection(app: this as NucleusOneAppInternal);
  }

  /// Folder Hierarchy Items
  FolderHierarchyItemCollection folderHierarchyItems() {
    return FolderHierarchyItemCollection(app: this as NucleusOneAppInternal);
  }

  /// FormTemplates
  FormTemplateCollection formTemplates() {
    return FormTemplateCollection(app: this as NucleusOneAppInternal);
  }

  /// Organization
  NucleusOneAppOrganization organization(String organizationId) {
    return NucleusOneAppOrganization(
      app: this as NucleusOneAppInternal,
      id: organizationId,
    );
  }

  /// Users
  NucleusOneAppUsers users() {
    return NucleusOneAppUsers(app: this as NucleusOneAppInternal);
  }
}
