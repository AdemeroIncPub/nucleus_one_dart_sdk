import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_permissions.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/organization_permissions.dart';

void main() {
  group('OrganizationPermissions class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationPermissions), 6);
    });

    test('Serialization test', () async {
      void performTests(api_mod.OrganizationPermissions apiModel) {
        expect(apiModel.organizationID, 'A');
        expect(apiModel.organizationName, 'B');
        expect(apiModel.userID, 'C');
        expect(apiModel.userName, 'D');
        expect(apiModel.userEmail, 'E');
        expect(apiModel.isAdmin, true);
      }

      final apiModelOrig =
          api_mod.OrganizationPermissions.fromJson(jsonDecode(organizationPermissionsJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = OrganizationPermissions.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
