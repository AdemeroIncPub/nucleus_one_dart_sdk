import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
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
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getApprovals method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsApprovalsFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      // Test with default parameters
      await performHttpTest<QueryResult<ApprovalCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).getApprovals(
          processElementId: 'A',
          sortDescending: false,
          processId: 'B',
          sortType: 'C',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processElementID=A',
          'sortDescending=false',
          'processID=B',
          'sortType=C',
        ],
      );

      project = getStandardN1Project();
      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<ApprovalCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).getApprovals(
          processElementId: 'A',
          sortDescending: true,
          processId: 'B',
          sortType: 'C',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processElementID=A',
          'sortDescending=true',
          'processID=B',
          'sortType=C',
        ],
      );
    });

    test('approveDocument method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsApprovalActionsApproveFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).approveDocument(
          ids: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('declineDocument method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsApprovalActionsDeclineFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).declineDocument(
          ids: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('denyDocument method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsApprovalActionsDenyFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppApprovals(project: project).denyDocument(
          ids: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });
  });
}
