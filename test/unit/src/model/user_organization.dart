import 'dart:convert';

import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/user_organization.dart';

void main() {
  group('UserOrganizationCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserOrganizationCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.UserOrganizationCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.UserOrganizationCollection.fromJsonArray(
          jsonDecode(userOrganizationCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserOrganizationCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('UserOrganization tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserOrganization), 6);
    });

    test('Serialization test', () async {
      void performTests(api_mod.UserOrganization apiModel) {
        expect(apiModel.userEmail, 'A');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.organizationName, 'C');
        expect(apiModel.assignmentTypes, ['D']);
        expect(apiModel.hasAssignment, true);
        expect(apiModel.isOrganizationMember, false);
      }

      final apiModelOrig = api_mod.UserOrganization.fromJson(jsonDecode(userOrganizationJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserOrganization.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
