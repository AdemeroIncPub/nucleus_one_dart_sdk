import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_package_field.dart';

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_package_field.dart';

void main() {
  group('DocumentPackageField class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentPackageField apiModel) {
        expect(apiModel.fieldID, 'A');
        expect(apiModel.fieldRank, 0);
        expect(apiModel.parentFieldID, 'B');
        expect(apiModel.name, 'C');
        expect(apiModel.labelOrName, 'D');
        expect(apiModel.type, 'E');
        expect(apiModel.displaySelectionList, false);
        expect(apiModel.allowMultipleLines, false);
        expect(apiModel.rows, 1);
        expect(apiModel.allowMultipleValues, false);
        expect(apiModel.allowNewSelectionListItems, false);
        expect(apiModel.saveNewSelectionListItems, false);
        expect(apiModel.decimalPlaces, 0);
        expect(apiModel.mask, 'F');
        expect(apiModel.required, false);
        expect(apiModel.value, 'G');
        expect(apiModel.values, 'H');
        expect(apiModel.useCreationDate, false);
        expect(apiModel.textMatchType, 'I');
      }

      final apiModelOrig =
          api_mod.DocumentPackageField.fromJson(jsonDecode(documentPackageFieldJson));
      performTests(apiModelOrig);

      final n1App = getStandardN1App();
      await DefineN1AppInScope(n1App, () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentPackageField.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
