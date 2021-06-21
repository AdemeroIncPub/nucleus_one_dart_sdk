import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/document_signature_form_field.dart';

void main() {
  group('DocumentSignatureFormField tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentSignatureFormField apiModel) {
        expect(apiModel.type, 'A');
        expect(apiModel.label, 'B');
        expect(apiModel.widthPercent, 0.00);
        expect(apiModel.sortRank, 1);
        expect(apiModel.id, 'C');
        expect(apiModel.documentSignatureSessionRecipientID, 'D');
        expect(apiModel.x, 2.34);
        expect(apiModel.y, 3.45);
        expect(apiModel.pageIndex, 4);
      }

      final apiModelOrig =
          api_mod.DocumentSignatureFormField.fromJson(jsonDecode(documentSignatureFormFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentSignatureFormField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('createNew method test', () {
      final m = DocumentSignatureFormField.createNew(
        type: 'A',
        label: 'B',
        widthPercent: 0.00,
        sortRank: 1,
        id: 'C',
        documentSignatureSessionRecipientID: 'D',
        x: 2.34,
        y: 3.45,
        pageIndex: 4,
      );

      expect(m.type, 'A');
      expect(m.label, 'B');
      expect(m.widthPercent, 0.00);
      expect(m.sortRank, 1);
      expect(m.id, 'C');
      expect(m.documentSignatureSessionRecipientID, 'D');
      expect(m.x, 2.34);
      expect(m.y, 3.45);
      expect(m.pageIndex, 4);
    });
  });

  group('DocumentSignatureFormFieldCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentSignatureFormFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureFormFieldCollection.fromJson(
          jsonDecode(documentSignatureFormFieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled =
          DocumentSignatureFormFieldCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
