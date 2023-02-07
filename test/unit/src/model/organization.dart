import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_subscriptions.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization.dart';

void main() {
  group('Organization class tests', () {
    performStandardModelTests<Organization, api_mod.Organization>(
      apiModelJson: organizationJson,
      expectedPublicFieldCount: 23,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-05-25T13:21:29.111348Z',
        apiModel.bucketName: 'C',
        apiModel.name: 'D',
        apiModel.nameLower: 'E',
        apiModel.creatingUserID: 'F',
        apiModel.creatingUserName: 'G',
        apiModel.creatingUserEmail: 'H',
        apiModel.crmAccountId: 'I',
        apiModel.crmLeadId: 'J',
        apiModel.crmContactId: 'K',
        apiModel.crmDealId: 'L',
        apiModel.disabled: true,
        apiModel.isMarkedForPurge: true,
        apiModel.purgeMarkedOn: 'M',
        apiModel.purgeMarkedByUserID: 'N',
        apiModel.purgeMarkedByUserName: 'O',
        apiModel.purgeMarkedByUserEmail: 'P',
        apiModel.subscriptionRequired: true,
        apiModel.subscriptionFreeUsers: 0,
        apiModel.subscriptionExpiration: '0001-01-01T00:00:00Z',
        apiModel.searchIndexRemovedForCostSavings: true,
        apiModel.searchIndexRestoredAtLeastOnce: true,
      },
    );

    test('subscriptions method tests', () {
      final org = getStandardN1Org();

      final sub = org.subscriptions();
      expect(sub, isA<NucleusOneAppSubscriptions>());
      expect(sub.app, org.app);
    });
  });
}
