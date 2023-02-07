import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_organization.dart' as api_mod;

import '../../../src/common.dart';
import '../api_model/user_organization.dart';

void main() {
  group('UserOrganization tests', () {
    performStandardModelTests<UserOrganization, api_mod.UserOrganization>(
      apiModelJson: userOrganizationJson,
      expectedPublicFieldCount: 6,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.userEmail: 'A',
        apiModel.organizationID: 'B',
        apiModel.organizationName: 'C',
        apiModel.assignmentTypes: ['D'],
        apiModel.hasAssignment: true,
        apiModel.isOrganizationMember: false,
      },
    );
  });

  group('UserOrganizationCollection class tests', () {
    performStandardModelTests<UserOrganizationCollection, api_mod.UserOrganizationCollection>(
      apiModelJson: userOrganizationCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
