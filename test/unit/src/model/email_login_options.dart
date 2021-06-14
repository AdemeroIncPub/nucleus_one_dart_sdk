import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/email_login_options.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/email_login_options.dart';

void main() {
  group('EmailLoginOptions tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.EmailLoginOptions apiModel) {
        expect(apiModel.userExists, true);
        expect(apiModel.smsNumberLast2, '12');
      }

      final apiModelOrig =
          api_mod.EmailLoginOptions.fromJson(jsonDecode(emailLoginOptionsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = EmailLoginOptions.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
