import 'dart:async';
import 'dart:convert';

import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:meta/meta.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/string.dart';

import 'common/get_it.dart';
import 'common/model.dart';
import 'common/util.dart';
import 'http.dart' as http;
import 'api_model/organization_for_client.dart' as api_mod;
import 'api_model/query_result.dart' as api_mod;

/// The entry point for accessing Nucleus One.
abstract class NucleusOne {
  static bool _sdkInitialized = false;

  /// Initializes the SDK.  This must be called prior to calling any other SDK methods.
  /// See also: [resetSdk].
  static Future<void> initializeSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    if (_sdkInitialized) {
      throw 'The SDK is already initialized.';
    }

    getIt.registerSingleton<file.FileSystem>(const file.LocalFileSystem());
    _sdkInitialized = true;
  }

  /// Resets the SDK to its initial state.
  /// See also: [initializeSdk].
  static Future<void> resetSdk() async {
    // This method is intentionally async, even though we don't currently make use of it.  This is
    // because of the high likelihood that it will be needed in the near future.  By making it async
    // now, it won't be a breaking change when we do introduce the need to await within this method.

    if (!_sdkInitialized) {
      return;
    }
    getIt.unregister<file.FileSystem>();
    _sdkInitialized = false;
  }
}

class NucleusOneOptions {
  final String apiBaseUrl;
  final String? apiKey;

  static const String _DefaultApiBaseUrl = 'https://client-api.nucleus.one';
  static const uploadChunkSize = 1024 * 1024;

  NucleusOneOptions({
    String? apiBaseUrl,
    this.apiKey,
  }) : apiBaseUrl = (apiBaseUrl == null) ? _DefaultApiBaseUrl : apiBaseUrl;
}

abstract class NucleusOneAppDependent {
  NucleusOneApp? _app;
  NucleusOneApp get app => _app!;
  @protected
  set app(NucleusOneApp app) => _app = app;
}

abstract class NucleusOneAppProjectDependent {
  NucleusOneAppProject? _project;
  NucleusOneAppProject get project => _project!;
  @protected
  set project(NucleusOneAppProject project) => _project = project;
}

class NucleusOneApp {
  @visibleForTesting
  static const String apiBaseUrlPath = '/api/v1';
  final NucleusOneOptions options;
  final String _baseUrlWithApi;

  NucleusOneApp({
    required this.options,
  }) : _baseUrlWithApi = options.apiBaseUrl + apiBaseUrlPath;

  /// Internal use only.
  String getFullUrl(String apiRelativeUrlPath) {
    return _baseUrlWithApi + apiRelativeUrlPath;
  }

  /// Organization
  NucleusOneAppOrganization organization(String organizationId) {
    return NucleusOneAppOrganization(
      app: this,
      id: organizationId,
    );
  }

  /// Gets an organization by ID.
  ///
  /// [organizationId]: The organization ID.
  Future<OrganizationForClient> getOrganization({
    required String organizationId,
  }) async {
    // This will be the correct implementation when the GET operation is implemented in the API
    /*
    final qp = http.StandardQueryParams.get();

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsOrganizationFormat.replaceOrgIdPlaceholder(organizationId),
      this,
      query: qp,
    );
    final apiModel = api_mod.OrganizationForClient.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(this, () {
      return OrganizationForClient.fromApiModel(apiModel);
    });
    */
    
    final orgs = await getOrganizations();
    return orgs.results.items.firstWhere(
      (x) => x.id == organizationId,
      orElse: () => throw NucleusOneHttpException(404),
    );
  }

  /// Gets organizations that the current user is a member of, by page.
  Future<QueryResult<OrganizationForClientCollection>> getOrganizations({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizations,
      this,
      query: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.OrganizationForClientCollection>.fromJson(
        jsonDecode(responseBody));

    return await DefineN1AppInScope(this, () {
      return OrganizationForClientCollectionQueryResult.fromApiModelOrganizationForClientCollection(
          apiModel);
    });
  }

  /// User
  NucleusOneAppUser user() {
    return NucleusOneAppUser(app: this);
  }
}
