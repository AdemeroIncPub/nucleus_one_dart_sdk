import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import '../api_model/organization_package.dart';

void main() {
  group('OrganizationPackage class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.OrganizationPackage apiModel) {
        expect(apiModel.organization, isA<api_mod.Organization>());
        expect(apiModel.userID, 'A');
        expect(apiModel.isMember, true);
        expect(apiModel.isExpiringSoon, false);
        expect(apiModel.expiration, '0001-01-01T00:00:00Z');
        expect(apiModel.freeUsers, 0);
        expect(apiModel.isExpired, true);
      }

      final apiModelOrig =
          api_mod.OrganizationPackage.fromJson(jsonDecode(organizationPackageJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = OrganizationPackage.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('OrganizationPackageCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.OrganizationPackageCollection> apiModel) {
        expect(apiModel.results!.organizationPackages!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.OrganizationPackageCollection>.fromJson(
          jsonDecode(organizationPackageCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.OrganizationPackageCollection> apiModelCycled =
          OrganizationPackageCollectionQueryResult.fromApiModelOrganizationPackageCollection(
                  apiModelOrig)
              .toApiModel<api_mod.OrganizationPackageCollection>();
      performTests(apiModelCycled);
    });
  });
}
