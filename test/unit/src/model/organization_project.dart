import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/organization_project.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/organization_project.dart';

void main() {
  group('OrganizationProjectCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.OrganizationProjectCollection> apiModel) {
        expect(apiModel.results!.projects!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.OrganizationProjectCollection>.fromJson(
          jsonDecode(organizationProjectCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            OrganizationProjectCollectionQueryResult.fromApiModelOrganizationProjectCollection(
                    apiModelOrig)
                .toApiModel<api_mod.OrganizationProjectCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('OrganizationProject tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.OrganizationProject apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.accessType, 'C');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'D');
        expect(apiModel.createdByUserEmail, 'E');
        expect(apiModel.createdByUserName, 'F');
        expect(apiModel.name, 'G');
        expect(apiModel.nameLower, 'H');
        expect(apiModel.disabled, true);
        expect(apiModel.isMarkedForPurge, false);
        expect(apiModel.purgeMarkedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.purgeMarkedByUserID, 'I');
        expect(apiModel.purgeMarkedByUserName, 'J');
        expect(apiModel.purgeMarkedByUserEmail, 'K');
      }

      final apiModelOrig =
          api_mod.OrganizationProject.fromJson(jsonDecode(organizationProjectJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = OrganizationProject.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
