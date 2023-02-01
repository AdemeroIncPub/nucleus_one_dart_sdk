import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_member.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_membership_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/organization_membership_package.dart';

void main() {
  group('OrganizationMembershipPackage class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationMembershipPackage), 8);
    });

    test('Serialization test', () async {
      void performTests(api_mod.OrganizationMembershipPackage apiModel) {
        expect(apiModel.organization is api_mod.Organization, true);
        expect(apiModel.organizationMember is api_mod.OrganizationMember, true);
        expect(apiModel.userID, 'A');
        expect(apiModel.isAdmin, true);
        expect(apiModel.isExpiringSoon, false);
        expect(apiModel.expiration, '0001-01-01T00:00:00Z');
        expect(apiModel.freeUsers, 1);
        expect(apiModel.isExpired, true);
      }

      final apiModelOrig = api_mod.OrganizationMembershipPackage.fromJson(
          jsonDecode(organizationMembershipPackageJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            OrganizationMembershipPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('OrganizationMembershipPackageCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationMembershipPackageCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(
          api_mod.QueryResult<api_mod.OrganizationMembershipPackageCollection> apiModel) {
        expect(apiModel.results!.membershipPackages!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.OrganizationMembershipPackageCollection>.fromJson(
              jsonDecode(organizationMembershipPackageCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.OrganizationMembershipPackageCollection> apiModelCycled =
            OrganizationMembershipPackageCollectionQueryResult
                    .fromApiModelOrganizationMembershipPackageCollection(apiModelOrig)
                .toApiModel<api_mod.OrganizationMembershipPackageCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
