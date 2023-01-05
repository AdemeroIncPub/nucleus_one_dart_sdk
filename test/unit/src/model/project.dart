import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/project.dart';

void main() {
  group('Project class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.Project), 21);
    });

    test('Serialization test', () async {
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

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = Project.fromApiModel(apiModelOrig).toApiModel();
        performTest(apiModelCycled);
      });
    });

    test('document method tests', () {
      final project = getStandardN1Project();

      final doc = project.document('123');
      expect(doc, isA<NucleusOneAppDocument>());
      expect(doc.id, '123');
      expect(doc.project, project);
    });

    test('documents method tests', () {
      final project = getStandardN1Project();

      final doc = project.documents();
      expect(doc, isA<NucleusOneAppDocuments>());
      expect(doc.project, project);
    });

    test('approvals method tests', () {
      final project = getStandardN1Project();

      final approvals = project.approvals();
      expect(approvals, isA<NucleusOneAppApprovals>());
      expect(approvals.project, project);
    });
  });

  group('ProjectMember class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.ProjectMember), 17);
    });

    test('Serialization test', () async {
      void performTest(api_mod.ProjectMember apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.organizationMemberID, 'B');
        expect(apiModel.organizationMemberIsAdmin, true);
        expect(apiModel.organizationID, 'C');
        expect(apiModel.organizationName, 'D');
        expect(apiModel.projectID, 'E');
        expect(apiModel.projectName, 'F');
        expect(apiModel.projectIsDisabled, false);
        expect(apiModel.projectAccessType, 'G');
        expect(apiModel.userID, 'H');
        expect(apiModel.userName, 'I');
        expect(apiModel.userNameLower, 'J');
        expect(apiModel.userEmail, 'K');
        expect(apiModel.disabled, false);
        expect(apiModel.isReadOnly, false);
        expect(apiModel.isAdmin, true);
      }

      final apiModelOrig = api_mod.ProjectMember.fromJson(jsonDecode(projectMemberJson));
      performTest(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = ProjectMember.fromApiModel(apiModelOrig).toApiModel();
        performTest(apiModelCycled);
      });
    });
  });
}
