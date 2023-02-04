import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/folder_hierarchies.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/folder_hierarchies.dart';

void main() {
  group('FolderHierarchy tests', () {
    performStandardModelTests<api_mod.FolderHierarchy, FolderHierarchy>(
      apiModelJson: folderHierarchyJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2019-08-27T15:21:24.267312Z',
        apiModel.name: 'B',
        apiModel.nameLower: 'C',
      },
    );
  });

  group('FolderHierarchyCollection tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FolderHierarchyCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.FolderHierarchyCollection> apiModel) {
        expect(apiModel.results!.folderHierarchies!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.FolderHierarchyCollection>.fromJson(
          jsonDecode(folderHierarchyCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppAndProjectInScope(getStandardN1Project(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.FolderHierarchyCollection> apiModelCycled =
            FolderHierarchyCollectionQueryResult.fromApiModelFolderHierarchyCollection(apiModelOrig)
                .toApiModel<api_mod.FolderHierarchyCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('FolderHierarchyItemCollection tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FolderHierarchyItemCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FolderHierarchyItemCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.FolderHierarchyItemCollection.fromJson(
          jsonDecode(folderHierarchyItemCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppAndProjectInScope(getStandardN1Project(), () {
        // Convert it to a model class then back again
        final api_mod.FolderHierarchyItemCollection apiModelCycled =
            FolderHierarchyItemCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
