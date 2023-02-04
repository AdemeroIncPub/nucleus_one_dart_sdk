import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_folder.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
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
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentFolderCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.DocumentFolderCollection> apiModel) {
        expect(apiModel.results!.documentFolders!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.DocumentFolderCollection>.fromJson(
          jsonDecode(documentFolderCollectionJson));
      performTests(apiModelOrig);

      final n1App = getStandardN1App();
      await defineN1AppInScope(n1App, () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.DocumentFolderCollection> apiModelCycled =
            DocumentFolderCollectionQueryResult.fromApiModelDocumentFolderCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentFolderCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
