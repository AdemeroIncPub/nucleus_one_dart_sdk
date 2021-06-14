import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/project.dart';

void main() {
  group('Project class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTest(api_mod.Project apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2019-08-27T15:21:23.90425Z');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.organizationName, 'C');
        expect(apiModel.organizationNameLower, 'D');
        expect(apiModel.organizationSubscriptionRequired, true);
        expect(apiModel.organizationSubscriptionFreeUsers, 0);
        expect(apiModel.organizationSubscriptionExpiration, '2021-06-24T01:01:56Z');
        expect(apiModel.bucketName, 'E');
        expect(apiModel.name, 'F');
        expect(apiModel.nameLower, 'G');
        expect(apiModel.creatingUserID, 'H');
        expect(apiModel.creatingUserName, 'I');
        expect(apiModel.creatingUserEmail, 'J');
        expect(apiModel.crmAccountId, 'K');
        expect(apiModel.disabled, false);
        expect(apiModel.isMarkedForPurge, true);
        expect(apiModel.purgeMarkedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.purgeMarkedByUserID, 'L');
        expect(apiModel.purgeMarkedByUserName, 'M');
        expect(apiModel.purgeMarkedByUserEmail, 'N');
      }

      final apiModelOrig = api_mod.Project.fromJson(jsonDecode(projectJson));
      performTest(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Project.fromApiModel(apiModelOrig).toApiModel();
      performTest(apiModelCycled);
    });
  });

  group('ProjectMember class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTest(api_mod.ProjectMember apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2020-02-27T21:59:56.028225Z');
        expect(apiModel.tenantID, 'B');
        expect(apiModel.tenantName, 'C');
        expect(apiModel.userID, 'D');
        expect(apiModel.userName, 'E');
        expect(apiModel.userNameLower, 'F');
        expect(apiModel.userEmail, 'G');
        expect(apiModel.disabled, true);
        expect(apiModel.isReadOnly, false);
        expect(apiModel.isAdmin, true);
        expect(apiModel.isOrganizationAdmin, false);
        expect(apiModel.isOrganizationOrTenantAdmin, true);
      }

      final apiModelOrig = api_mod.ProjectMember.fromJson(jsonDecode(projectMemberJson));
      performTest(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = ProjectMember.fromApiModel(apiModelOrig).toApiModel();
      performTest(apiModelCycled);
    });
  });
}
