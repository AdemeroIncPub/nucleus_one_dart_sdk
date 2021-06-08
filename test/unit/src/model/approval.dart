import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_approvals.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/approval.dart';
import 'package:test/test.dart';

import '../api_model/approval.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('Approval class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Approval apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-06-04T16:49:04.317582Z');
        expect(apiModel.roleID, 'B');
        expect(apiModel.roleName, 'C');
        expect(apiModel.processID, 'D');
        expect(apiModel.processName, 'E');
        expect(apiModel.processElementID, 'F');
        expect(apiModel.processElementName, 'G');
        expect(apiModel.participationType, 'H');
        expect(apiModel.approvingTenantMemberIDs, '[{"0":false,"1":false,"2":false}]');
        expect(apiModel.result, 'J');
        expect(apiModel.itemType, 'K');
        expect(apiModel.itemID, 'L');
        expect(apiModel.itemCreatedOn, '2021-06-04T16:49:05.317582Z');
        expect(apiModel.itemCreatedByUserID, 'M');
        expect(apiModel.itemCreatedByUserEmail, 'N');
        expect(apiModel.itemCreatedByUserName, 'O');
        expect(apiModel.itemCompletedOn, '0001-01-01T00:00:02Z');
        expect(apiModel.itemCompletedByUserID, 'P');
        expect(apiModel.itemCompletedByUserEmail, 'Q');
        expect(apiModel.itemCompletedByUserName, 'R');
        expect(apiModel.itemName, 'S');
        expect(apiModel.itemDescription, 'T');
        expect(apiModel.documentName, 'U');
        expect(apiModel.documentCreatedOn, '2021-06-04T16:49:06.317582Z');
        expect(apiModel.documentCreatedByUserID, 'V');
        expect(apiModel.documentCreatedByUserEmail, 'W');
        expect(apiModel.documentCreatedByUserName, 'X');
        expect(apiModel.documentPageCount, 0);
        expect(apiModel.documentFileSize, 1);
        expect(apiModel.documentClassificationID, 'Y');
        expect(apiModel.documentClassificationName, 'Z');
        expect(apiModel.documentPreviewMetadata, [
          {'0': 'A', '1': 'B', '2': 'C'}
        ]);
        expect(apiModel.documentIsSigned, false);
        expect(apiModel.workTaskDueOn, '0001-01-01T00:00:01Z');
        expect(apiModel.thumbnailUrl, 'AA');
      }

      final apiModelOrig = api_mod.Approval.fromJson(jsonDecode(approvalJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Approval.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('ApprovalCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.ApprovalCollection> apiModel) {
        expect(apiModel.results!.approvals!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.ApprovalCollection>.fromJson(
          jsonDecode(approvalCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.ApprovalCollection> apiModelCycled =
          ApprovalCollectionQueryResult.fromApiModelApprovalCollection(apiModelOrig)
              .toApiModel<api_mod.ApprovalCollection>();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.approvals;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<ApprovalCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppApprovals(app: n1App).getApprovals(
          processElementId: 'A',
          sortDescending: false,
          processId: 'B',
          sortType: 'C',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processElementId=A',
          'sortDescending=false',
          'processId=B',
          'sortType=C',
        ],
      );
    });
  });
}
