import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document_package_field.dart';

import 'package:test/test.dart';

import '../api_model/document_package_field.dart';

void main() {
  group('DocumentPackageField class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentPackageField apiModel) {
        expect(apiModel.classificationFieldID, 'A');
        expect(apiModel.classificationFieldRank, 0);
        expect(apiModel.fieldID, 'B');
        expect(apiModel.parentFieldID, 'C');
        expect(apiModel.name, 'D');
        expect(apiModel.labelOrName, 'E');
        expect(apiModel.type, 'F');
        expect(apiModel.displaySelectionList, false);
        expect(apiModel.allowMultipleLines, false);
        expect(apiModel.rows, 1);
        expect(apiModel.allowMultipleValues, false);
        expect(apiModel.allowNewSelectionListItems, false);
        expect(apiModel.saveNewSelectionListItems, false);
        expect(apiModel.decimalPlaces, 2);
        expect(apiModel.mask, 'G');
        expect(apiModel.required, false);
        expect(apiModel.value, 'H');
        expect(apiModel.values, 'I');
        expect(apiModel.useCreationDate, false);
        expect(apiModel.textMatchType, 'J');
      }

      final apiModelOrig =
          api_mod.DocumentPackageField.fromJson(jsonDecode(documentPackageFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentPackageField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
