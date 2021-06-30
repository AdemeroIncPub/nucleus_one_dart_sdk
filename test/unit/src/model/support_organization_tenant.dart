import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_organization_tenant.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization_tenant.dart';
import 'package:test/test.dart';

import '../api_model/support_organization_tenant.dart';

void main() {
  group('SupportOrganizationTenant tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.SupportOrganizationTenant apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:01Z');
        expect(apiModel.name, 'B');
        expect(apiModel.creatingUserName, 'C');
        expect(apiModel.creatingUserEmail, 'D');
        expect(apiModel.crmAccountId, 'E');
        expect(apiModel.organizationID, 'F');
        expect(apiModel.organizationName, 'G');
        expect(apiModel.organizationSubscriptionRequired, false);
        expect(apiModel.organizationSubscriptionExpiration, '0001-01-01T00:00:01Z');
        expect(apiModel.searchIndexID, 'H');
        expect(apiModel.bucketName, 'I');
        expect(apiModel.disabled, false);
        expect(apiModel.isMarkedForPurge, false);
        expect(apiModel.purgeDate, '0001-01-01T00:00:01Z');
        expect(apiModel.documentCount, 0);
      }

      final apiModelOrig =
          api_mod.SupportOrganizationTenant.fromJson(jsonDecode(supportOrganizationTenantJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = SupportOrganizationTenant.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
  group('SupportOrganizationTenantCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.SupportOrganizationTenantCollection> apiModel) {
        expect(apiModel.results!.supportOrganizationTenants!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.SupportOrganizationTenantCollection>.fromJson(
              jsonDecode(supportOrganizationTenantCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.SupportOrganizationTenantCollection> apiModelCycled =
          SupportOrganizationTenantCollectionQueryResult
                  .fromApiModelSupportOrganizationTenantCollection(apiModelOrig)
              .toApiModel<api_mod.SupportOrganizationTenantCollection>();
      performTests(apiModelCycled);
    });
  });
}
