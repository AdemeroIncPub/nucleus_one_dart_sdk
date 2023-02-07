import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_folder.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_folder.dart';

void main() {
  group('DocumentFolder class tests', () {
    performStandardModelTests<api_mod.DocumentFolder, DocumentFolder>(
      apiModelJson: documentFolderJson,
      expectedPublicFieldCount: 22,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.uniqueID: 'B',
        apiModel.parentID: 'C',
        apiModel.ancestorIDs: isA<List<String>>(),
        apiModel.ancestorIDs!.length: 1,
        apiModel.ancestorIDs![0]: 'D',
        apiModel.organizationID: 'E',
        apiModel.projectID: 'F',
        apiModel.projectName: 'G',
        apiModel.projectAccessType: 'H',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.createdByUserEmail: 'I',
        apiModel.createdByUserName: 'J',
        apiModel.createdByUserID: 'K',
        apiModel.modifiedOn: '0001-01-01T00:00:00Z',
        apiModel.modifiedByUserEmail: 'L',
        apiModel.modifiedByUserName: 'M',
        apiModel.modifiedByUserID: 'N',
        apiModel.name: 'O',
        apiModel.nameLower: 'P',
        apiModel.depth: 1,
        apiModel.ancestorAssignmentUserEmails: isA<List<String>>(),
        apiModel.ancestorAssignmentUserEmails!.length: 1,
        apiModel.ancestorAssignmentUserEmails![0]: 'Q',
        apiModel.assignmentUserEmails: isA<List<String>>(),
        apiModel.assignmentUserEmails!.length: 1,
        apiModel.assignmentUserEmails![0]: 'R',
        apiModel.hexColor: 'S',
      },
    );
  });

  group('DocumentFolderCollection class tests', () {
    performStandardQueryResultModelTests<
        DocumentFolderCollection,
        api_mod.DocumentFolderCollection,
        QueryResult<DocumentFolderCollection, api_mod.DocumentFolderCollection>,
        api_mod.QueryResult<api_mod.DocumentFolderCollection>>(
      apiModelJson: documentFolderCollectionJson,
    );
  });
}
