import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/project.dart';

void main() {
  group('Project class tests', () {
    performStandardModelTests<api_mod.Project, Project>(
      apiModelJson: projectJson,
      expectedPublicFieldCount: 21,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2019-08-27T15:21:23.90425Z',
        apiModel.organizationID: 'B',
        apiModel.organizationName: 'C',
        apiModel.organizationNameLower: 'D',
        apiModel.organizationSubscriptionRequired: true,
        apiModel.organizationSubscriptionFreeUsers: 0,
        apiModel.organizationSubscriptionExpiration: '2021-06-24T01:01:56Z',
        apiModel.bucketName: 'E',
        apiModel.name: 'F',
        apiModel.nameLower: 'G',
        apiModel.creatingUserID: 'H',
        apiModel.creatingUserName: 'I',
        apiModel.creatingUserEmail: 'J',
        apiModel.crmAccountId: 'K',
        apiModel.disabled: false,
        apiModel.isMarkedForPurge: true,
        apiModel.purgeMarkedOn: '0001-01-01T00:00:00Z',
        apiModel.purgeMarkedByUserID: 'L',
        apiModel.purgeMarkedByUserName: 'M',
        apiModel.purgeMarkedByUserEmail: 'N',
      },
    );

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
    performStandardModelTests<api_mod.ProjectMember, ProjectMember>(
      apiModelJson: projectMemberJson,
      expectedPublicFieldCount: 17,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.organizationMemberID: 'B',
        apiModel.organizationMemberIsAdmin: true,
        apiModel.organizationID: 'C',
        apiModel.organizationName: 'D',
        apiModel.projectID: 'E',
        apiModel.projectName: 'F',
        apiModel.projectIsDisabled: false,
        apiModel.projectAccessType: 'G',
        apiModel.userID: 'H',
        apiModel.userName: 'I',
        apiModel.userNameLower: 'J',
        apiModel.userEmail: 'K',
        apiModel.disabled: false,
        apiModel.isReadOnly: false,
        apiModel.isAdmin: true,
      },
    );
  });
}
