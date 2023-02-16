import 'package:nucleus_one_dart_sdk/src/api_model/folder_hierarchy_item.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/folder_hierarchy_item.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/folder_hierarchy_item.dart';

void main() {
  group('FolderHierarchyItem tests', () {
    performStandardModelTests<FolderHierarchyItem, api_mod.FolderHierarchyItem>(
      apiModelJson: folderHierarchyItemJson,
      expectedPublicFieldCount: 9,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.folderHierarchyID: 'B',
        apiModel.folderHierarchyName: 'C',
        apiModel.rank: 0,
        apiModel.type: 'D',
        apiModel.fieldID: 'E',
        apiModel.fieldName: 'F',
        apiModel.fieldType: 'G',
        apiModel.fieldValueType: 'H',
      },
    );
  });

  group('FolderHierarchyItemCollection class tests', () {
    performStandardModelTests<FolderHierarchyItemCollection, api_mod.FolderHierarchyItemCollection>(
      requiresAppAndProjectInScope: true,
      apiModelJson: folderHierarchyItemCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
