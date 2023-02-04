import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_package.dart';

void main() {
  group('OrganizationPackage class tests', () {
    performStandardModelTests<api_mod.OrganizationPackage, OrganizationPackage>(
      apiModelJson: organizationPackageJson,
      expectedPublicFieldCount: 7,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.organization: isA<api_mod.Organization>(),
        apiModel.userID: 'A',
        apiModel.isMember: true,
        apiModel.isExpiringSoon: false,
        apiModel.expiration: '0001-01-01T00:00:00Z',
        apiModel.freeUsers: 0,
        apiModel.isExpired: true,
      },
    );
  });

  group('OrganizationPackageCollection class tests', () {
    // !~!~!
    // OrganizationPackageCollection
    // 1

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.OrganizationPackageCollection> apiModel) {
        expect(apiModel.results!.organizationPackages!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.OrganizationPackageCollection>.fromJson(
          jsonDecode(organizationPackageCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.OrganizationPackageCollection> apiModelCycled =
            OrganizationPackageCollectionQueryResult.fromApiModelOrganizationPackageCollection(
                    apiModelOrig)
                .toApiModel<api_mod.OrganizationPackageCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
