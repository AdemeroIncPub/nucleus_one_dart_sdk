import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_organization_project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/user_organization_project.dart';

void main() {
  group('UserOrganizationProjectCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserOrganizationProjectCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.UserOrganizationProjectCollection> apiModel) {
        expect(apiModel.results!.userOrganizationProjects!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.UserOrganizationProjectCollection>.fromJson(
          jsonDecode(userOrganizationProjectCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserOrganizationProjectCollectionQueryResult
                .fromApiModelUserOrganizationProjectCollection(apiModelOrig)
            .toApiModel<api_mod.UserOrganizationProjectCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('UserOrganizationProject tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.UserOrganizationProject), 9);
    });

    test('Serialization test', () async {
      void performTests(api_mod.UserOrganizationProject apiModel) {
        expect(apiModel.userEmail, 'A');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.organizationName, 'C');
        expect(apiModel.projectID, 'D');
        expect(apiModel.projectName, 'E');
        expect(apiModel.projectAccessType, 'F');
        expect(apiModel.projectIsDisabled, false);
        expect(apiModel.assignmentTypes, ['G']);
        expect(apiModel.hasAssignment, false);
      }

      final apiModelOrig =
          api_mod.UserOrganizationProject.fromJson(jsonDecode(userOrganizationProjectJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = UserOrganizationProject.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
