import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/email_login_options.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/email_login_options.dart';

void main() {
  group('EmailLoginOptions tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.EmailLoginOptions), 2);
    });

    test('Serialization test', () async {
      void performTests(api_mod.EmailLoginOptions apiModel) {
        expect(apiModel.userExists, true);
        expect(apiModel.smsNumberLast2, '12');
      }

      final apiModelOrig = api_mod.EmailLoginOptions.fromJson(jsonDecode(emailLoginOptionsJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = EmailLoginOptions.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
