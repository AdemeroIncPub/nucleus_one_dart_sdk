import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_member.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_member.dart';

void main() {
  group('OrganizationMember class tests', () {
    performStandardModelTests<OrganizationMember, api_mod.OrganizationMember>(
      apiModelJson: organizationMemberJson,
      expectedPublicFieldCount: 11,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.organizationID: 'B',
        apiModel.organizationName: 'C',
        apiModel.userID: 'D',
        apiModel.userName: 'E',
        apiModel.userNameLower: 'F',
        apiModel.userEmail: 'G',
        apiModel.disabled: true,
        apiModel.isReadOnly: false,
        apiModel.isAdmin: true,
      },
    );
  });
}
