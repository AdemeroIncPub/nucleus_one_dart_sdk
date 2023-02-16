import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/folder_hierarchy.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/folder_hierarchy.dart';

void main() {
  group('FolderHierarchy tests', () {
    performStandardModelTests<FolderHierarchy, api_mod.FolderHierarchy>(
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

  group('FolderHierarchyCollection class tests', () {
    performStandardQueryResultModelTests<
        FolderHierarchyCollection,
        api_mod.FolderHierarchyCollection,
        QueryResult<FolderHierarchyCollection, api_mod.FolderHierarchyCollection>,
        api_mod.QueryResult<api_mod.FolderHierarchyCollection>>(
      requiresAppAndProjectInScope: true,
      apiModelJson: folderHierarchyCollectionJson,
    );
  });
}
