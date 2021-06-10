import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import '../api_model/field.dart';

void main() {
  group('Field class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Field apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-02-09T05:23:35.496635Z');
        expect(apiModel.parentFieldID, 'B');
        expect(apiModel.name, 'C');
        expect(apiModel.nameLower, 'D');
        expect(apiModel.label, 'E');
        expect(apiModel.labelLower, 'F');
        expect(apiModel.labelOrName, 'G');
        expect(apiModel.labelOrNameLower, 'H');
        expect(apiModel.type, 'I');
        expect(apiModel.displaySelectionList, true);
        expect(apiModel.allowMultipleLines, false);
        expect(apiModel.rows, 1);
        expect(apiModel.allowMultipleValues, true);
        expect(apiModel.allowNewSelectionListItems, false);
        expect(apiModel.saveNewSelectionListItems, true);
        expect(apiModel.decimalPlaces, 0);
        expect(apiModel.mask, 'J');
        expect(apiModel.required, false);
        expect(apiModel.sensitive, true);
        expect(apiModel.useCreationDate, false);
        expect(apiModel.textMatchType, 'K');
      }

      final apiModelOrig = api_mod.Field.fromJson(jsonDecode(fieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Field.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.FieldCollection> apiModel) {
        expect(apiModel.results!.fields!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.FieldCollection>.fromJson(jsonDecode(fieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.FieldCollection> apiModelCycled =
          FieldCollectionQueryResult.fromApiModelFieldCollection(apiModelOrig)
              .toApiModel<api_mod.FieldCollection>();
      performTests(apiModelCycled);
    });
  });
}
