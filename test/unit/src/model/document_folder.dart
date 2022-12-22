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
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentFolder), 22);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentFolder apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.uniqueID, 'B');
        expect(apiModel.parentID, 'C');
        expect(apiModel.ancestorIDs, isA<List<String>>());
        expect(apiModel.ancestorIDs!.length, 1);
        expect(apiModel.ancestorIDs![0], 'D');
        expect(apiModel.organizationID, 'E');
        expect(apiModel.projectID, 'F');
        expect(apiModel.projectName, 'G');
        expect(apiModel.projectAccessType, 'H');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserEmail, 'I');
        expect(apiModel.createdByUserName, 'J');
        expect(apiModel.createdByUserID, 'K');
        expect(apiModel.modifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.modifiedByUserEmail, 'L');
        expect(apiModel.modifiedByUserName, 'M');
        expect(apiModel.modifiedByUserID, 'N');
        expect(apiModel.name, 'O');
        expect(apiModel.nameLower, 'P');
        expect(apiModel.depth, 1);
        expect(apiModel.ancestorAssignmentUserEmails, isA<List<String>>());
        expect(apiModel.ancestorAssignmentUserEmails!.length, 1);
        expect(apiModel.ancestorAssignmentUserEmails![0], 'Q');
        expect(apiModel.assignmentUserEmails, isA<List<String>>());
        expect(apiModel.assignmentUserEmails!.length, 1);
        expect(apiModel.assignmentUserEmails![0], 'R');
        expect(apiModel.hexColor, 'S');
      }

      final apiModelOrig = api_mod.DocumentFolder.fromJson(jsonDecode(documentFolderJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentFolder.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentFolderCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

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
      await DefineN1AppInScope(n1App, () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.DocumentFolderCollection> apiModelCycled =
            DocumentFolderCollectionQueryResult.fromApiModelDocumentFolderCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentFolderCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
