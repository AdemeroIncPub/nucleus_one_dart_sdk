import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/user_preferences.dart';

void main() {
  group('NucleusOneAppProjects class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getPreferences method tests', () async {
      final expectedUrlPath = http.apiPaths.userPreferences;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<UserPreferences>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).getPreferences(),
        responseBody: userPreferencesJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('setSmsNumber method tests', () async {
      final expectedUrlPath = http.apiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).setSmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"SMSNumber":"123"}',
      );
    });

    test('verifySmsNumber method tests', () async {
      final expectedUrlPath =
          http.apiPaths.userSmsNumbersSmsChangeCodeFormat.replaceFirst('<smsChangeCode>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).verifySmsNumber('123'),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('deleteSmsNumber method tests', () async {
      final expectedUrlPath = http.apiPaths.userSmsNumbers;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => NucleusOneAppUsers(app: n1App).deleteSmsNumber(),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
