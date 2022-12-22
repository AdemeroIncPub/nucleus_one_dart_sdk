import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field_list_item.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/field_list_item.dart';

void main() {
  group('FieldListItem tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FieldListItem), 3);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FieldListItem apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.parentValue, 'B');
        expect(apiModel.value, 'C');
      }

      final apiModelOrig = api_mod.FieldListItem.fromJson(jsonDecode(fieldListItemJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FieldListItem.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('FieldListItemCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FieldListItemCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FieldListItemCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig =
          api_mod.FieldListItemCollection.fromJson(jsonDecode(fieldListItemCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FieldListItemCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
