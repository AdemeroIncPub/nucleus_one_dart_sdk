import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_organization_project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/user_organization_project.dart';

void main() {
  group('UserOrganizationProject tests', () {
    performStandardModelTests<api_mod.UserOrganizationProject, UserOrganizationProject>(
      apiModelJson: userOrganizationProjectJson,
      expectedPublicFieldCount: 9,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.userEmail: 'A',
        apiModel.organizationID: 'B',
        apiModel.organizationName: 'C',
        apiModel.projectID: 'D',
        apiModel.projectName: 'E',
        apiModel.projectAccessType: 'F',
        apiModel.projectIsDisabled: false,
        apiModel.assignmentTypes: ['G'],
        apiModel.hasAssignment: false,
      },
    );
  });

  group('UserOrganizationProjectCollection class tests', () {
    performStandardQueryResultModelTests<
        UserOrganizationProjectCollection,
        api_mod.UserOrganizationProjectCollection,
        QueryResult<UserOrganizationProjectCollection, api_mod.UserOrganizationProjectCollection>,
        api_mod.QueryResult<api_mod.UserOrganizationProjectCollection>>(
      apiModelJson: userOrganizationProjectCollectionJson,
    );
  });
}
