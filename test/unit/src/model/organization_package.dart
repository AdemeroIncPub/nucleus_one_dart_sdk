import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_package.dart';

void main() {
  group('OrganizationPackage class tests', () {
    performStandardModelTests<OrganizationPackage, api_mod.OrganizationPackage>(
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
    performStandardQueryResultModelTests<
        OrganizationPackageCollection,
        api_mod.OrganizationPackageCollection,
        QueryResult<OrganizationPackageCollection, api_mod.OrganizationPackageCollection>,
        api_mod.QueryResult<api_mod.OrganizationPackageCollection>>(
      apiModelJson: organizationPackageCollectionJson,
    );
  });
}
