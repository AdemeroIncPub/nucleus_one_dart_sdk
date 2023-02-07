import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;

import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_package_field.dart';

void main() {
  group('DocumentPackageField class tests', () {
    performStandardModelTests<DocumentPackageField, api_mod.DocumentPackageField>(
      apiModelJson: documentPackageFieldJson,
      expectedPublicFieldCount: 19,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.fieldID: 'A',
        apiModel.fieldRank: 0,
        apiModel.parentFieldID: 'B',
        apiModel.name: 'C',
        apiModel.labelOrName: 'D',
        apiModel.type: 'E',
        apiModel.displaySelectionList: false,
        apiModel.allowMultipleLines: false,
        apiModel.rows: 1,
        apiModel.allowMultipleValues: false,
        apiModel.allowNewSelectionListItems: false,
        apiModel.saveNewSelectionListItems: false,
        apiModel.decimalPlaces: 0,
        apiModel.mask: 'F',
        apiModel.required: false,
        apiModel.value: 'G',
        apiModel.values: 'H',
        apiModel.useCreationDate: false,
        apiModel.textMatchType: 'I',
      },
    );
  });
}
