import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/support_organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/query_result.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization.dart';

import '../../../src/common.dart';
import '../api_model/support_organization.dart';

void main() {
  group('SupportOrganization class tests', () {
    performStandardModelTests<api_mod.SupportOrganization, SupportOrganization>(
      apiModelJson: supportOrganizationJson,
      expectedPublicFieldCount: 10,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:01Z',
        apiModel.name: 'B',
        apiModel.creatingUserName: 'C',
        apiModel.creatingUserEmail: 'D',
        apiModel.subscriptionRequired: false,
        apiModel.subscriptionFreeUsers: 0,
        apiModel.subscriptionExpiration: '0001-01-01T00:00:01Z',
        apiModel.uniqueNonReadOnlyTenantMembers: 1,
        apiModel.uniqueReadOnlyTenantMembers: 2,
      },
    );
  });

  group('SupportOrganizationCollection class tests', () {
    performStandardQueryResultModelTests<
        SupportOrganizationCollection,
        api_mod.SupportOrganizationCollection,
        QueryResult<SupportOrganizationCollection, api_mod.SupportOrganizationCollection>,
        api_mod.QueryResult<api_mod.SupportOrganizationCollection>>(
      apiModelJson: supportOrganizationCollectionJson,
    );
  });
}
