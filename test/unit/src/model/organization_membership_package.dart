import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_member.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_membership_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_membership_package.dart';

void main() {
  group('OrganizationMembershipPackage class tests', () {
    performStandardModelTests<api_mod.OrganizationMembershipPackage, OrganizationMembershipPackage>(
      apiModelJson: organizationMembershipPackageJson,
      expectedPublicFieldCount: 8,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.organization is api_mod.Organization: true,
        apiModel.organizationMember is api_mod.OrganizationMember: true,
        apiModel.userID: 'A',
        apiModel.isAdmin: true,
        apiModel.isExpiringSoon: false,
        apiModel.expiration: '0001-01-01T00:00:00Z',
        apiModel.freeUsers: 1,
        apiModel.isExpired: true,
      },
    );
  });

  group('OrganizationMembershipPackageCollection class tests', () {
    performStandardQueryResultModelTests<
        OrganizationMembershipPackageCollection,
        api_mod.OrganizationMembershipPackageCollection,
        QueryResult<OrganizationMembershipPackageCollection,
            api_mod.OrganizationMembershipPackageCollection>,
        api_mod.QueryResult<api_mod.OrganizationMembershipPackageCollection>>(
      apiModelJson: organizationMembershipPackageCollectionJson,
    );
  });
}
