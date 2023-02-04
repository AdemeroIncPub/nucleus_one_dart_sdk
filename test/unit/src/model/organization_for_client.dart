import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_subscriptions.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_for_client.dart';

void main() {
  group('OrganizationForClient class tests', () {
    performStandardModelTests<api_mod.OrganizationForClient, OrganizationForClient>(
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
    // !~!~!
    // OrganizationForClientCollection
    // 1

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.OrganizationForClientCollection> apiModel) {
        expect(apiModel.results!.organizations!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.OrganizationForClientCollection>.fromJson(
          jsonDecode(organizationForClientCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.OrganizationForClientCollection> apiModelCycled =
            OrganizationForClientCollectionQueryResult.fromApiModelOrganizationForClientCollection(
                    apiModelOrig)
                .toApiModel<api_mod.OrganizationForClientCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
