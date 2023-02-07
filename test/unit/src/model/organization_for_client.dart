import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_subscriptions.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_for_client.dart';

void main() {
  group('OrganizationForClient class tests', () {
    performStandardModelTests<OrganizationForClient, api_mod.OrganizationForClient>(
      apiModelJson: organizationForClientJson,
      expectedPublicFieldCount: 13,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.name: 'B',
        apiModel.createdByUserID: 'C',
        apiModel.createdByUserName: 'D',
        apiModel.createdByUserEmail: 'E',
        apiModel.subscriptionRequired: true,
        apiModel.subscriptionFreeUsers: 1,
        apiModel.subscriptionExpiration: 'H',
        apiModel.uniqueNonReadOnlyOrganizationMembers: 2,
        apiModel.uniqueReadOnlyOrganizationMembers: 3,
        apiModel.uniqueFreeOrganizationMembers: 4,
        apiModel.uniqueBillableOrganizationMembers: 5,
      },
    );

    test('subscriptions method tests', () {
      final org = getStandardN1Org();

      final sub = org.subscriptions();
      expect(sub, isA<NucleusOneAppSubscriptions>());
      expect(sub.app, org.app);
    });
  });

  group('OrganizationForClientCollection class tests', () {
    performStandardQueryResultModelTests<
        OrganizationForClientCollection,
        api_mod.OrganizationForClientCollection,
        QueryResult<OrganizationForClientCollection, api_mod.OrganizationForClientCollection>,
        api_mod.QueryResult<api_mod.OrganizationForClientCollection>>(
      apiModelJson: organizationForClientCollectionJson,
    );
  });
}
