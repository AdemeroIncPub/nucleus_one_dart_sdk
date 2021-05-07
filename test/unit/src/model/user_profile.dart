import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_profile.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/user_profile.dart';

void main() {
  group('UserProfile tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.UserProfile apiModel) {
        expect(apiModel.userProvider, 'google');
        expect(apiModel.userEmail, 'A');
        expect(apiModel.userName, 'B');
        expect(apiModel.otpsmsNumber, 'C');
      }

      final apiModelOrig = api_mod.UserProfile.fromJson(jsonDecode(userProfileJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = UserProfile.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
