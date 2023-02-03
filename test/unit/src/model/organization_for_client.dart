import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_subscriptions.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/organization_for_client.dart';

void main() {
  group('OrganizationForClient class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationForClient), 13);
    });

    test('Serialization test', () async {
      void performTests(api_mod.OrganizationForClient apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.name, 'B');
        expect(apiModel.createdByUserID, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.createdByUserEmail, 'E');
        expect(apiModel.subscriptionRequired, true);
        expect(apiModel.subscriptionFreeUsers, 1);
        expect(apiModel.subscriptionExpiration, 'H');
        expect(apiModel.uniqueNonReadOnlyOrganizationMembers, 2);
        expect(apiModel.uniqueReadOnlyOrganizationMembers, 3);
        expect(apiModel.uniqueFreeOrganizationMembers, 4);
        expect(apiModel.uniqueBillableOrganizationMembers, 5);
      }

      final apiModelOrig =
          api_mod.OrganizationForClient.fromJson(jsonDecode(organizationForClientJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = OrganizationForClient.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('subscriptions method tests', () {
      final org = getStandardN1Org();

      final sub = org.subscriptions();
      expect(sub, isA<NucleusOneAppSubscriptions>());
      expect(sub.app, org.app);
    });
  });

  group('OrganizationForClientCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationForClientCollection), 1);
    });

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
