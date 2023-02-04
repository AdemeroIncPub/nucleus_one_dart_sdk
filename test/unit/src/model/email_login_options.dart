import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/email_login_options.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/email_login_options.dart';

void main() {
  group('EmailLoginOptions tests', () {
    performStandardModelTests<api_mod.EmailLoginOptions, EmailLoginOptions>(
      apiModelJson: emailLoginOptionsJson,
      expectedPublicFieldCount: 2,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.userExists: true,
        apiModel.smsNumberLast2: '12',
      },
    );
  });
}
