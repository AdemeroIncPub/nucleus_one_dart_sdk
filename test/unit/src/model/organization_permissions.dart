import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_permissions.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_permissions.dart';

void main() {
  group('OrganizationPermissions class tests', () {
    performStandardModelTests<api_mod.OrganizationPermissions, OrganizationPermissions>(
      apiModelJson: organizationPermissionsJson,
      expectedPublicFieldCount: 6,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.organizationID: 'A',
        apiModel.organizationName: 'B',
        apiModel.userID: 'C',
        apiModel.userName: 'D',
        apiModel.userEmail: 'E',
        apiModel.isAdmin: true,
      },
    );
  });
}
