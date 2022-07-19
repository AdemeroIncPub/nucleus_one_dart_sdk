import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/folder_hierarchies.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/folder_hierarchies.dart';

void main() {
  group('FolderHierarchy tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.FolderHierarchy apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2019-08-27T15:21:24.267312Z');
        expect(apiModel.name, 'B');
        expect(apiModel.nameLower, 'C');
      }

      final apiModelOrig = api_mod.FolderHierarchy.fromJson(jsonDecode(folderHierarchyJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FolderHierarchy.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('FolderHierarchyCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.FolderHierarchyCollection> apiModel) {
        expect(apiModel.results!.folderHierarchies!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.FolderHierarchyCollection>.fromJson(
          jsonDecode(folderHierarchyCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppAndProjectInScope(getStandardN1Project(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.FolderHierarchyCollection> apiModelCycled =
            FolderHierarchyCollectionQueryResult.fromApiModelFolderHierarchyCollection(apiModelOrig)
                .toApiModel<api_mod.FolderHierarchyCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('FolderHierarchyItemCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.FolderHierarchyItemCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.FolderHierarchyItemCollection.fromJson(
          jsonDecode(folderHierarchyItemCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppAndProjectInScope(getStandardN1Project(), () {
        // Convert it to a model class then back again
        final api_mod.FolderHierarchyItemCollection apiModelCycled =
            FolderHierarchyItemCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
