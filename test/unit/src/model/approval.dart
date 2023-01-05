import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/approval.dart';

void main() {
  group('Approval class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.Approval), 36);
    });

    test('Serialization test', () async {
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
        expect(apiModel.approvingTenantMemberIDs, {'0': false, '1': false, '2': false});
        expect(apiModel.result, 'J');
        expect(apiModel.itemType, 'K');
        expect(apiModel.itemID, 'L');
        expect(apiModel.itemCreatedOn, '2021-06-04T16:49:05.317582Z');
        expect(apiModel.itemCreatedByUserID, 'M');
        expect(apiModel.itemCreatedByUserEmail, 'N');
        expect(apiModel.itemCreatedByUserName, 'O');
        expect(apiModel.itemCompletedOn, '0001-01-01T00:00:01Z');
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
        expect(apiModel.documentPreviewMetadata, isNotNull);
        expect(apiModel.documentPreviewMetadata!.length, 1);
        expect(apiModel.documentIsSigned, false);
        expect(apiModel.taskDueOn, '0001-01-01T00:00:01Z');
        expect(apiModel.thumbnailUrl, 'AA');
      }

      final apiModelOrig = api_mod.Approval.fromJson(jsonDecode(approvalJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = Approval.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('ApprovalCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.ApprovalCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.ApprovalCollection> apiModel) {
        expect(apiModel.results!.approvals!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.ApprovalCollection>.fromJson(
          jsonDecode(approvalCollectionJson));
      performTests(apiModelOrig);

      final n1App = getStandardN1App();
      await defineN1AppInScope(n1App, () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.ApprovalCollection> apiModelCycled =
            ApprovalCollectionQueryResult.fromApiModelApprovalCollection(apiModelOrig)
                .toApiModel<api_mod.ApprovalCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
