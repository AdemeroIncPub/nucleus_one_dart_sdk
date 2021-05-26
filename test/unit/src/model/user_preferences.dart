import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preferences.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_users.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../api_model/user_preferences.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('UserPreferences class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.UserPreferences apiModel) {
        expect(apiModel.userID, 'A');
        expect(apiModel.userName, 'B');
        expect(apiModel.userEmail, 'C');
        expect(apiModel.activeOrganizationID, 'D');
        expect(apiModel.activeOrganizationName, 'E');
        expect(apiModel.activeTenantID, 'F');
        expect(apiModel.activeTenantName, 'G');
        expect(apiModel.viewType, 'H');
        expect(apiModel.documentPropertiesOpen, false);
        expect(apiModel.documentCommentsOpen, false);
        expect(apiModel.singlePagePreview, false);
        expect(apiModel.selectedTwainDevice, isNotNull);
        expect(apiModel.disableTwainDeviceSoftware, false);
      }

      final apiModelOrig = api_mod.UserPreferences.fromJson(jsonDecode(userPreferencesJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = UserPreferences.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.userPreferences;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserPreferences>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).get(),
        responseBody: userPreferencesJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
