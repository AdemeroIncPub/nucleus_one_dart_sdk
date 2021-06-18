import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/tenant.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import '../api_model/tenant.dart';

void main() {
  group('Tenant class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Tenant apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2019-09-05T18:51:37.704127Z');
        expect(apiModel.name, 'B');
        expect(apiModel.creatingUserName, 'C');
        expect(apiModel.creatingUserEmail, 'D');
        expect(apiModel.crmAccountId, 'E');
        expect(apiModel.organizationID, 'F');
        expect(apiModel.organizationName, 'G');
        expect(apiModel.organizationSubscriptionRequired, true);
        expect(apiModel.organizationSubscriptionExpiration, '2021-07-24T01:01:56Z');
        expect(apiModel.searchIndexID, 'H');
        expect(apiModel.bucketName, 'I');
        expect(apiModel.disabled, false);
        expect(apiModel.isMarkedForPurge, true);
        expect(apiModel.purgeDate, '0001-04-01T00:00:00Z');
        expect(apiModel.documentCount, 0);
      }

      final apiModelOrig = api_mod.Tenant.fromJson(jsonDecode(tenantJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Tenant.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('TenantCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.TenantCollection> apiModel) {
        expect(apiModel.results!.tenants!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.TenantCollection>.fromJson(jsonDecode(tenantCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.TenantCollection> apiModelCycled =
          TenantCollectionQueryResult.fromApiModelTenantCollection(apiModelOrig)
              .toApiModel<api_mod.TenantCollection>();
      performTests(apiModelCycled);
    });
  });
}
