import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preferences.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/user_preferences.dart';

void main() {
  group('UserPreferences class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserPreferences), 13);
    });

    test('Serialization test', () async {
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

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserPreferences.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
