import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preferences.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/user_preferences.dart';

void main() {
  group('UserPreferences class tests', () {
    performStandardModelTests<UserPreferences, api_mod.UserPreferences>(
      apiModelJson: userPreferencesJson,
      expectedPublicFieldCount: 13,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.userID: 'A',
        apiModel.userName: 'B',
        apiModel.userEmail: 'C',
        apiModel.activeOrganizationID: 'D',
        apiModel.activeOrganizationName: 'E',
        apiModel.activeTenantID: 'F',
        apiModel.activeTenantName: 'G',
        apiModel.viewType: 'H',
        apiModel.documentPropertiesOpen: false,
        apiModel.documentCommentsOpen: false,
        apiModel.singlePagePreview: false,
        apiModel.selectedTwainDevice: isNotNull,
        apiModel.disableTwainDeviceSoftware: false,
      },
    );
  });
}
