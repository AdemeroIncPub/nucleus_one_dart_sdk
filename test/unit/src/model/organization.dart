import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_subscriptions.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/organization.dart';

void main() {
  group('Organization class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.Organization), 23);
    });

    test('Serialization test', () async {
      void performTests(api_mod.Organization apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-05-25T13:21:29.111348Z');
        expect(apiModel.bucketName, 'C');
        expect(apiModel.name, 'D');
        expect(apiModel.nameLower, 'E');
        expect(apiModel.creatingUserID, 'F');
        expect(apiModel.creatingUserName, 'G');
        expect(apiModel.creatingUserEmail, 'H');
        expect(apiModel.crmAccountId, 'I');
        expect(apiModel.crmLeadId, 'J');
        expect(apiModel.crmContactId, 'K');
        expect(apiModel.crmDealId, 'L');
        expect(apiModel.disabled, true);
        expect(apiModel.isMarkedForPurge, true);
        expect(apiModel.purgeMarkedOn, 'M');
        expect(apiModel.purgeMarkedByUserID, 'N');
        expect(apiModel.purgeMarkedByUserName, 'O');
        expect(apiModel.purgeMarkedByUserEmail, 'P');
        expect(apiModel.subscriptionRequired, true);
        expect(apiModel.subscriptionFreeUsers, 0);
        expect(apiModel.subscriptionExpiration, '0001-01-01T00:00:00Z');
        expect(apiModel.searchIndexRemovedForCostSavings, true);
        expect(apiModel.searchIndexRestoredAtLeastOnce, true);
      }

      final apiModelOrig = api_mod.Organization.fromJson(jsonDecode(organizationJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = Organization.fromApiModel(apiModelOrig).toApiModel();
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
}
