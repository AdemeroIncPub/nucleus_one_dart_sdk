import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/support_organization.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/support_organization.dart';

void main() {
  group('SupportOrganization tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.SupportOrganization apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:01Z');
        expect(apiModel.name, 'B');
        expect(apiModel.creatingUserName, 'C');
        expect(apiModel.creatingUserEmail, 'D');
        expect(apiModel.subscriptionRequired, false);
        expect(apiModel.subscriptionFreeUsers, 0);
        expect(apiModel.subscriptionExpiration, '0001-01-01T00:00:01Z');
        expect(apiModel.uniqueNonReadOnlyTenantMembers, 1);
        expect(apiModel.uniqueReadOnlyTenantMembers, 2);
      }

      final apiModelOrig =
          api_mod.SupportOrganization.fromJson(jsonDecode(supportOrganizationJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SupportOrganization.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
  group('SupportOrganizationCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.SupportOrganizationCollection> apiModel) {
        expect(apiModel.results!.supportOrganizations!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.SupportOrganizationCollection>.fromJson(
          jsonDecode(supportOrganizationCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.SupportOrganizationCollection> apiModelCycled =
            SupportOrganizationCollectionQueryResult.fromApiModelSupportOrganizationCollection(
                    apiModelOrig)
                .toApiModel<api_mod.SupportOrganizationCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
