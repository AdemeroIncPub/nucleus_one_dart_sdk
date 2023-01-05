import 'dart:convert';

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

class NucleusOneAppUser with NucleusOneAppDependent {
  NucleusOneAppUser({
    NucleusOneApp? app,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  /// Updates a User Preference.
  Future<void> updateUserPreference(UserPreference userPreference) async {
    await http.executePutRequest(
      http.ApiPaths.userPreferences,
      app,
      body: jsonEncode(userPreference.toApiModel()),
    );
  }

  /// Updates User Preferences by User Preference Id.
  ///
  /// [singleUserPreferenceId] The id of the User Preference to be updated.
  Future<void> updateUserPreferenceByUserPreferenceId(
      UserPreference userPreference, String singleUserPreferenceId) async {
    final qp = http.StandardQueryParams.get();
    qp['singleUserPreferenceId'] = singleUserPreferenceId;

    await http.executePutRequest(
      http.ApiPaths.userPreferenceFormat
          .replaceFirst('<singleUserPreferenceId>', singleUserPreferenceId),
      app,
      body: jsonEncode(userPreference.toApiModel()),
      query: qp,
    );
  }

  /// Gets the current user's organizations.
  Future<UserOrganizationCollection> getOrganizations() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.userOrganizations,
      app,
    );
    final apiModel = api_mod_uo.UserOrganizationCollection.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return UserOrganizationCollection.fromApiModel(apiModel);
    });
  }

  /// Gets projects in which the current user has work assigned.
  ///
  /// [organizationId]: The id of the organization.
  Future<UserOrganizationProjectCollection> getProjects({
    required String organizationId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.userOrganizationsProjectsFormat.replaceOrgIdPlaceholder(organizationId),
      app,
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
      http.ApiPaths.userPreferences,
      app,
    );
    final apiModel = api_mod_ups.UserPreferences.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return UserPreferences.fromApiModel(apiModel);
    });
  }

  /// Gets the current user's preference by its id.
  ///
  /// [id]: The id of the field.
  Future<UserPreference> getPreferencesById(String id) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.ApiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', id),
      app,
    );
    final apiModel = api_mod_up.UserPreference.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
      return UserPreference.fromApiModel(apiModel);
    });
  }

  /// Sets the current user's SMS number.
  ///
  /// [smsNumber] The SMS number, including the beginning "+" and country code.
  Future<void> setSmsNumber(String smsNumber) async {
    final reqBody = {
      'SMSNumber': smsNumber,
    };
    await http.executePostRequest(
      http.ApiPaths.userSmsNumbers,
      app: app,
      body: jsonEncode(reqBody),
    );
  }

  /// Verifies the changing of the current user's SMS number.
  ///
  /// [smsNumber] The verification code received via text message.
  Future<void> verifySmsNumber(String verificationCode) async {
    await http.executePutRequest(
      http.ApiPaths.userSmsNumbersSmsChangeCodeFormat
          .replaceFirst('<smsChangeCode>', verificationCode),
      app,
    );
  }

  /// Deletes the current user's SMS number.
  Future<void> deleteSmsNumber() async {
    await http.executeDeleteRequest(
      http.ApiPaths.userSmsNumbers,
      app: app,
    );
  }
}
