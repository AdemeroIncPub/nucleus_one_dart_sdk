import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/approval.dart';

void main() {
  group('Approval class tests', () {
    performStandardModelTests<Approval, api_mod.Approval>(
      apiModelJson: approvalJson,
      expectedPublicFieldCount: 36,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-06-04T16:49:04.317582Z',
        apiModel.roleID: 'B',
        apiModel.roleName: 'C',
        apiModel.processID: 'D',
        apiModel.processName: 'E',
        apiModel.processElementID: 'F',
        apiModel.processElementName: 'G',
        apiModel.participationType: 'H',
        apiModel.approvingTenantMemberIDs: {'0': false, '1': false, '2': false},
        apiModel.result: 'J',
        apiModel.itemType: 'K',
        apiModel.itemID: 'L',
        apiModel.itemCreatedOn: '2021-06-04T16:49:05.317582Z',
        apiModel.itemCreatedByUserID: 'M',
        apiModel.itemCreatedByUserEmail: 'N',
        apiModel.itemCreatedByUserName: 'O',
        apiModel.itemCompletedOn: '0001-01-01T00:00:01Z',
        apiModel.itemCompletedByUserID: 'P',
        apiModel.itemCompletedByUserEmail: 'Q',
        apiModel.itemCompletedByUserName: 'R',
        apiModel.itemName: 'S',
        apiModel.itemDescription: 'T',
        apiModel.documentName: 'U',
        apiModel.documentCreatedOn: '2021-06-04T16:49:06.317582Z',
        apiModel.documentCreatedByUserID: 'V',
        apiModel.documentCreatedByUserEmail: 'W',
        apiModel.documentCreatedByUserName: 'X',
        apiModel.documentPageCount: 0,
        apiModel.documentFileSize: 1,
        apiModel.documentClassificationID: 'Y',
        apiModel.documentClassificationName: 'Z',
        apiModel.documentPreviewMetadata: isNotNull,
        apiModel.documentPreviewMetadata!.length: 1,
        apiModel.documentIsSigned: false,
        apiModel.taskDueOn: '0001-01-01T00:00:01Z',
        apiModel.thumbnailUrl: 'AA',
      },
    );
  });

  group('ApprovalCollection class tests', () {
    performStandardQueryResultModelTests<
        ApprovalCollection,
        api_mod.ApprovalCollection,
        QueryResult<ApprovalCollection, api_mod.ApprovalCollection>,
        api_mod.QueryResult<api_mod.ApprovalCollection>>(
      apiModelJson: approvalCollectionJson,
    );
  });
}
