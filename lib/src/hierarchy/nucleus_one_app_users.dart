import 'dart:convert';

import '../nucleus_one.dart';
import '../model/user_preferences.dart';
import '../model/user_preference.dart';
import '../http.dart' as http;
import '../api_model/user_preferences.dart' as api_mod_ups;
import '../api_model/user_preference.dart' as api_mod_up;

class NucleusOneAppUsers with NucleusOneAppDependent {
  NucleusOneAppUsers({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets UserPreferences.
  ///
  ///
  Future<UserPreferences> getPreferences() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.userPreferences,
      app,
    );
    final apiModel = api_mod_ups.UserPreferences.fromJson(jsonDecode(responseBody));
    return UserPreferences.fromApiModel(apiModel);
  }

  /// Gets a UserPreference by its id.
  ///
  /// [id]: The id of the field.
  Future<UserPreference> getPreferencesById(String id) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', id),
      app,
    );
    final apiModel = api_mod_up.UserPreference.fromJson(jsonDecode(responseBody));
    return UserPreference.fromApiModel(apiModel);
  }
}
