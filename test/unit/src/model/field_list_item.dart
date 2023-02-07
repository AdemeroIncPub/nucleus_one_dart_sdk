import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field_list_item.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/field_list_item.dart';

void main() {
  group('FieldListItem tests', () {
    performStandardModelTests<api_mod.FieldListItem, FieldListItem>(
      apiModelJson: fieldListItemJson,
      expectedPublicFieldCount: 3,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.parentValue: 'B',
        apiModel.value: 'C',
      },
    );
  });

  group('FieldListItemCollection class tests', () {
    performStandardModelTests<api_mod.FieldListItemCollection, FieldListItemCollection>(
      apiModelJson: fieldListItemCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
