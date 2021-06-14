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

  /// Gets the current user's preferences.
  Future<UserPreferences> getPreferences() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.userPreferences,
      app,
    );
    final apiModel = api_mod_ups.UserPreferences.fromJson(jsonDecode(responseBody));
    return UserPreferences.fromApiModel(apiModel);
  }

  /// Gets the current user's preference by its id.
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

  /// Sets the current user's SMS number.
  ///
  /// [smsNumber] The SMS number, including the beginning "+" and country code.
  Future<void> setSmsNumber(String smsNumber) async {
    final reqBody = {
      'SMSNumber': smsNumber,
    };
    await http.executePostRequest(
      http.apiPaths.userSmsNumbers,
      app,
      body: jsonEncode(reqBody),
    );
  }

  /// Verifies the changing of the current user's SMS number.
  ///
  /// [smsNumber] The verification code received via text message.
  Future<void> verifySmsNumber(String verificationCode) async {
    await http.executePutRequest(
      http.apiPaths.userSmsNumbersSmsChangeCodeFormat
          .replaceFirst('<smsChangeCode>', verificationCode),
      app,
    );
  }

  /// Deletes the current user's SMS number.
  Future<void> deleteSmsNumber() async {
    await http.executeDeleteRequest(
      http.apiPaths.userSmsNumbers,
      app,
    );
  }
}
