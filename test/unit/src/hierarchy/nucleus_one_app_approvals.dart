import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../api_model/approval.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('NucleusOneAppApprovals class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getApprovals method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsApprovalsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<QueryResult<ApprovalCollection, api_mod.ApprovalCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).getApprovals(
          processId: 'A',
          sortType: 'B',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processID=A',
          'sortType=B',
        ],
      );

      project = getStandardN1Project();
      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<ApprovalCollection, api_mod.ApprovalCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).getApprovals(
          processId: 'A',
          sortType: 'B',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processID=A',
          'sortType=B',
        ],
      );
    });

    test('approveDocuments method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsApprovalActionsApproveFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).approveDocuments(
          documentIds: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('declineDocuments method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsApprovalActionsDeclineFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).declineDocuments(
          documentIds: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('denyDocuments method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsApprovalActionsDenyFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).denyDocuments(
          documentIds: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });
  });
}
