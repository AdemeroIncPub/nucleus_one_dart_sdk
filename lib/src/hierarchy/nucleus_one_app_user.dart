import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;

import '../api_model/user_preferences.dart' as api_mod_ups;
import '../api_model/user_preference.dart' as api_mod_up;
import '../api_model/user_organization.dart' as api_mod_uo;
import '../api_model/user_organization_project.dart' as api_mod_uop;
import '../common/get_it.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/user_organization.dart';
import '../model/user_organization_project.dart';
import '../model/user_preferences.dart';
import '../model/user_preference.dart';
import '../nucleus_one.dart';
import '../user.dart';

/// Performs operations for the current user.
class NucleusOneAppUser with NucleusOneAppDependent {
  /// Creates an instance of the [NucleusOneAppUser] class.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  NucleusOneAppUser({
    NucleusOneApp? app,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  /// Updates a user's preference.
  Future<void> updateUserPreference(UserPreference userPreference) async {
    await http.executePutRequest(
      apiRelativeUrlPath: http.ApiPaths.userPreferences,
      app: app,
      body: jsonEncode(userPreference.toApiModel()),
    );
  }

  /// Updates a preference of the current user by its preference ID.
  ///
  /// [singleUserPreferenceId]: The ID of the user preference to be updated.
  Future<void> updateUserPreferenceByUserPreferenceId(
      UserPreference userPreference, String singleUserPreferenceId) async {
    final qp = http.StandardQueryParams.get();
    qp['singleUserPreferenceId'] = singleUserPreferenceId;

    await http.executePutRequest(
      apiRelativeUrlPath: http.ApiPaths.userPreferenceFormat
          .replaceFirst('<singleUserPreferenceId>', singleUserPreferenceId),
      app: app,
      body: jsonEncode(userPreference.toApiModel()),
      queryParams: qp,
    );
  }

  /// Gets the organizations that the current user has access to.
  Future<UserOrganizationCollection> getOrganizations() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.userOrganizations,
      app: app,
    );
    final apiModel =
        api_mod_uo.UserOrganizationCollection.fromJson(jsonDecodeListOfMap(responseBody));

    return await defineN1AppInScope(app, () {
      return UserOrganizationCollection.fromApiModel(apiModel);
    });
  }

  /// Gets projects in which the current user has work assigned.
  ///
  /// [organizationId]: The ID of the organization.
  Future<UserOrganizationProjectCollection> getProjects({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath:
          http.ApiPaths.userOrganizationsProjectsFormat.replaceOrgIdPlaceholder(organizationId),
      app: app,
    );
    final apiModel =
        api_mod_uop.UserOrganizationProjectCollection.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return UserOrganizationProjectCollection.fromApiModel(apiModel);
    });
  }

  /// Gets the current user's preferences.
  Future<UserPreferences> getPreferences() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.userPreferences,
      app: app,
    );
    final apiModel = api_mod_ups.UserPreferences.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return UserPreferences.fromApiModel(apiModel);
    });
  }

  /// Gets the current user's preference by its ID.
  ///
  /// [id]: The ID of the field.
  Future<UserPreference> getPreferencesById(String id) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath:
          http.ApiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', id),
      app: app,
    );
    final apiModel = api_mod_up.UserPreference.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return UserPreference.fromApiModel(apiModel);
    });
  }

  /// Sets the current user's SMS number.
  ///
  /// [smsNumber]: The SMS number, including the beginning "+" and country code.
  Future<void> setSmsNumber(String smsNumber) async {
    final reqBody = {
      'SMSNumber': smsNumber,
    };
    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.userSmsNumbers,
      app: app,
      body: jsonEncode(reqBody),
    );
  }

  /// Verifies the changing of the current user's SMS number.
  ///
  /// [smsNumber]: The verification code received via text message.
  Future<void> verifySmsNumber(String verificationCode) async {
    await http.executePutRequest(
      apiRelativeUrlPath: http.ApiPaths.userSmsNumbersSmsChangeCodeFormat
          .replaceFirst('<smsChangeCode>', verificationCode),
      app: app,
    );
  }

  /// Deletes the current user's SMS number.
  Future<void> deleteSmsNumber() async {
    await http.executeDeleteRequest(
      apiRelativeUrlPath: http.ApiPaths.userSmsNumbers,
      app: app,
    );
  }

  /// Logs in to Nucleus One using Google Sign-In.  A result is returned, regardless of success.
  ///
  /// [oauthIdToken]: The OAuth2 ID token.
  ///
  /// [browserFingerprint]: The browser's fingerprint.  Used to identify this specific browser on
  /// the current device.
  Future<LoginResult> loginGoogle({
    required String oauthIdToken,
    required int browserFingerprint,
  }) async {
    final signInPackage = <String, Object>{
      'BrowserFingerprint': browserFingerprint,
      'UserProvider': 'google',
      'OAuthIdToken': oauthIdToken,
    };

    return await _loginInternal(signInPackage);
  }

  /// Logs in to Nucleus One using an email and a one-time passcode.  A result is returned,
  /// regardless of success.
  ///
  /// [email]: The user's email address.
  ///
  /// [oneTimePasscode]: The one-time passcode received on the user's external device.
  ///
  /// [browserFingerprint]: The browser's fingerprint.  Used to identify this specific browser on
  /// the current device.
  Future<LoginResult> loginEmailAndOTP({
    required String email,
    required String oneTimePasscode,
    required int browserFingerprint,
  }) async {
    final signInPackage = {
      'AuthType': 'email',
      'BrowserFingerprint': browserFingerprint,
      'Email': email,
      'OTP': oneTimePasscode,
      'UserProvider': 'email',
    };

    return await _loginInternal(signInPackage);
  }

  Future<LoginResult> _loginInternal(Map<String, Object> signInPackage) async {
    final resp = await http.executePostRequest(
      authenticated: false,
      app: app,
      apiRelativeUrlPath: http.ApiPaths.userLogin,
      body: jsonEncode(signInPackage),
    );

    final ret = resp.cookies.firstWhereOrNull(
      (element) => element.name == 'session_v1',
    );

    final sessionId = ret?.value;
    final success = (sessionId != null) && sessionId.isNotEmpty;

    return LoginResult(
      success: success,
      sessionId: success ? sessionId : null,
      user: User(app: app),
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
