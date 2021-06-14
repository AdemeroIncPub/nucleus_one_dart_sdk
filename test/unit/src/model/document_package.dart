import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document_package.dart';
import 'package:test/test.dart';

import '../api_model/document_package.dart';

void main() {
  group('DocumentPackage class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentPackage apiModel) {
        expect(apiModel.document, isA<api_mod.Document>());
        expect(apiModel.documentSubscription, isA<api_mod.DocumentSubscription>());
        expect(apiModel.approval, isA<api_mod.Approval>());
        expect(apiModel.classificationField, isA<api_mod.DocumentPackageField>());
        expect(apiModel.indexFields, isA<List<api_mod.DocumentPackageField>>());
      }

      final apiModelOrig = api_mod.DocumentPackage.fromJson(jsonDecode(documentPackageJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentPackage.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
