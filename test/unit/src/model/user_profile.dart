import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_profile.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/user_profile.dart';

void main() {
  group('UserProfile tests', () {
    performStandardModelTests<UserProfile, api_mod.UserProfile>(
      apiModelJson: userProfileJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.userProvider: 'google',
        apiModel.userEmail: 'A',
        apiModel.userName: 'B',
        apiModel.otpsmsNumber: 'C',
      },
    );
  });
}
