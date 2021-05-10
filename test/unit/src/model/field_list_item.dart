import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field_list_item.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/field_list_item.dart';

void main() {
  group('FieldListItem tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FieldListItem apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.parentValue, 'B');
        expect(apiModel.value, 'C');
      }

      final apiModelOrig = api_mod.FieldListItem.fromJson(jsonDecode(fieldListItemJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FieldListItem.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FieldListItemCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FieldListItemCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig =
          api_mod.FieldListItemCollection.fromJson(jsonDecode(fieldListItemCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FieldListItemCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
