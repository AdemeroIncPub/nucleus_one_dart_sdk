import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_signature_form_field.dart';

void main() {
  group('DocumentSignatureFormField tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureFormField), 7);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureFormField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-06-22T17:56:43.765773Z');
        expect(apiModel.type, 'B');
        expect(apiModel.pageIndex, 0);
        expect(apiModel.documentSignatureSessionRecipientID, 'C');
        expect(apiModel.x, 1.23);
        expect(apiModel.y, 2.34);
      }

      final apiModelOrig =
          api_mod.DocumentSignatureFormField.fromJson(jsonDecode(documentSignatureFormFieldJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentSignatureFormField.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('createNew method test', () {
      for (var i = 0; i < 3; ++i) {
        final id = (i == 0) ? null : ((i == 1) ? '' : 'C');
        final epochBefore = DateTime.now().millisecondsSinceEpoch;
        final n1App = getStandardN1App();

        var m = DocumentSignatureFormField.createNew(
          app: n1App,
          id: id,
          createdOn: 'A',
          type: 'B',
          pageIndex: 0,
          documentSignatureSessionRecipientID: 'C',
          x: 1.23,
          y: 2.34,
        );

        // If the id was not provided, ensure that it was correctly defaulted
        if (i < 2) {
          final epochAfter = DateTime.now().millisecondsSinceEpoch;
          final idAsInt = int.parse(m.id);
          expect(idAsInt >= epochBefore, isTrue);
          expect(idAsInt <= epochAfter, isTrue);
        } else {
          expect(m.id, id);
        }

        expect(m.createdOn, 'A');
        expect(m.type, 'B');
        expect(m.pageIndex, 0);
        expect(m.documentSignatureSessionRecipientID, 'C');
        expect(m.x, 1.23);
        expect(m.y, 2.34);
      }
    });
  });

  group('DocumentSignatureFormFieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureFormFieldCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureFormFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureFormFieldCollection.fromJson(
          jsonDecode(documentSignatureFormFieldCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureFormFieldCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
