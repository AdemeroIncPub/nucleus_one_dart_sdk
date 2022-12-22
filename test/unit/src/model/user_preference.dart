import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_preference.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/mirrors.dart';
import '../api_model/user_preference.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('UserPreference class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserPreference), 9);
    });

    test('Serialization test', () async {
      void performTests(api_mod.UserPreference apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.userID, 'B');
        expect(apiModel.userName, 'C');
        expect(apiModel.userEmail, 'D');
        expect(apiModel.stringValue, 'E');
        expect(apiModel.boolValue, false);
        expect(apiModel.intValue, 0);
        expect(apiModel.floatValue, 0.1);
        expect(apiModel.mapValue, '[{"0":"A","1":"B","2":"C"}]');
      }

      final apiModelOrig = api_mod.UserPreference.fromJson(jsonDecode(userPreferenceJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserPreference.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('getById method tests', () async {
      final expectedUrlPath =
          http.apiPaths.userPreferenceFormat.replaceFirst('<singleUserPreferenceId>', 'ABC');
      final n1App = getStandardN1App();
      await performHttpTest<UserPreference>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUser(app: n1App).getPreferencesById('ABC'),
        responseBody: userPreferenceJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
