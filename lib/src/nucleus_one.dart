import 'dart:async';
import 'dart:convert';

import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:meta/meta.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';

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

/// Options for configuring a connection to Nucleus One (e.g. base URL, API key).
/// 
/// [app]: The application to use when connecting to Nucleus One.
class NucleusOneOptions {
  final String apiBaseUrl;
  final String? apiKey;

  static const String _defaultApiBaseUrl = 'https://client-api.nucleus.one';
  static const uploadChunkSize = 1024 * 1024;

  /// Creates an instance of the [NucleusOneOptions] class.
  ///
  /// [apiBaseUrl]: The base URL for the Nucleus One API.  Note that this is different from the
  /// Nucleus One app URL.
  ///
  /// [apiKey]: The API key to use when connecting.  This can be created by visiting your User
  /// Profile in Nucleus One then clicking "API Keys".
  NucleusOneOptions({
    String? apiBaseUrl,
    this.apiKey,
  }) : apiBaseUrl = (apiBaseUrl == null) ? _defaultApiBaseUrl : apiBaseUrl;
}

/// Classes deriving from this class require an instance of the [NucleusOneApp] class in order to
/// function.
abstract class NucleusOneAppDependent {
  NucleusOneApp? _app;

  /// The Nucleus One application object.  This controls API configuration.  See the [NucleusOneApp]
  /// class for details.
  NucleusOneApp get app => _app!;

  /// Sets the Nucleus One application object.
  @protected
  set app(NucleusOneApp app) => _app = app;
}

/// Classes deriving from this class require an instance of the [NucleusOneAppProject] class in
/// order to function.
abstract class NucleusOneAppProjectDependent {
  NucleusOneAppProject? _project;

  /// The Nucleus One project object.  This controls which project child methods use when calling
  /// the API.  See the [NucleusOneAppProject] class for details.
  NucleusOneAppProject get project => _project!;

  /// Sets the Nucleus One project.
  @protected
  set project(NucleusOneAppProject project) => _project = project;
}

/// The Nucleus One application.  This is a core class needed for most operations.
class NucleusOneApp {
  @visibleForTesting
  static const String apiBaseUrlPath = '/api/v1';
  final NucleusOneOptions options;
  final String _baseUrlWithApi;

  /// Creates an instance of the [NucleusOneApp] class.
  ///
  /// [options]: The options to use when connecting to Nucleus One.
  NucleusOneApp({
    required this.options,
  }) : _baseUrlWithApi = options.apiBaseUrl + apiBaseUrlPath;

  /// Internal use only.
  String getFullUrl(String apiRelativeUrlPath) {
    return _baseUrlWithApi + apiRelativeUrlPath;
  }

  /// Creates a [NucleusOneAppOrganization] object, which can be used to perform operations specific
  /// to this organization.
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
      apiRelativeUrlPath: apiRelativeUrlPath: http.apiPaths.organizationsOrganizationFormat.replaceOrgIdPlaceholder(organizationId),
      this,
      queryParams: qpms: qp,
    );
    final apiModel = api_mod.OrganizationForClient.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(this, () {
      return OrganizationForClient.fromApiModel(apiModel);
    });
    */

    final orgs = await getOrganizations();
    return orgs.results.items.firstWhere(
      (x) => x.id == organizationId,
      orElse: () => throw NucleusOneHttpException(status: 404),
    );
  }

  /// Gets organizations that the current user is a member of, by page.
  Future<QueryResult<OrganizationForClientCollection>> getOrganizations({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizations,
      app: this,
      queryParams: qp,
    );

    final apiModel = api_mod.QueryResult<api_mod.OrganizationForClientCollection>.fromJson(
        jsonDecode(responseBody));

    return await defineN1AppInScope(this, () {
      return OrganizationForClientCollectionQueryResult.fromApiModelOrganizationForClientCollection(
          apiModel);
    });
  }

  /// Creates a [NucleusOneAppUser] object, which can be used to perform operations specific to the
  /// current user.
  NucleusOneAppUser user() {
    return NucleusOneAppUser(app: this);
  }
}
