import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/field.dart';

void main() {
  group('Field class tests', () {
    performStandardModelTests<api_mod.Field, Field>(
      apiModelJson: fieldJson,
      expectedPublicFieldCount: 22,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-02-09T05:23:35.496635Z',
        apiModel.parentFieldID: 'B',
        apiModel.name: 'C',
        apiModel.nameLower: 'D',
        apiModel.label: 'E',
        apiModel.labelLower: 'F',
        apiModel.labelOrName: 'G',
        apiModel.labelOrNameLower: 'H',
        apiModel.type: 'I',
        apiModel.displaySelectionList: true,
        apiModel.allowMultipleLines: false,
        apiModel.rows: 1,
        apiModel.allowMultipleValues: true,
        apiModel.allowNewSelectionListItems: false,
        apiModel.saveNewSelectionListItems: true,
        apiModel.decimalPlaces: 0,
        apiModel.mask: 'J',
        apiModel.required: false,
        apiModel.sensitive: true,
        apiModel.useCreationDate: false,
        apiModel.textMatchType: 'K',
      },
    );
  });

  group('FieldCollection class tests', () {
    // !~!~!
    // FieldCollection
    // 1

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.FieldCollection> apiModel) {
        expect(apiModel.results!.fields!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.FieldCollection>.fromJson(jsonDecode(fieldCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.FieldCollection> apiModelCycled =
            FieldCollectionQueryResult.fromApiModelFieldCollection(apiModelOrig)
                .toApiModel<api_mod.FieldCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
