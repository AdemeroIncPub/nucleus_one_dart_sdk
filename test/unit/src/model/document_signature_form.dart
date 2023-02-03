import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_signature_form.dart';

void main() {
  group('DocumentSignatureForm class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureForm), 13);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureForm apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.signatureFormTemplateID, 'B');
        expect(apiModel.createdOn, '2021-06-21T14:38:42.159832299Z');
        expect(apiModel.tenantID, 'C');
        expect(apiModel.documentID, 'D');
        expect(apiModel.documentClassificationID, 'E');
        expect(apiModel.documentClassificationName, 'F');
        expect(apiModel.documentClassificationNameLower, 'G');
        expect(apiModel.documentName, 'H');
        expect(apiModel.documentNameLower, 'I');
        expect(apiModel.hasFormFields, true);
        expect(apiModel.totalFormFields, 0);
        expect(apiModel.lastViewedPageIndex, 1);
      }

      final apiModelOrig =
          api_mod.DocumentSignatureForm.fromJson(jsonDecode(documentSignatureFormJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentSignatureForm.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureFormCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureFormCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureFormCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureFormCollection.fromJson(
          jsonDecode(documentSignatureFormCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.DocumentSignatureFormCollection apiModelCycled =
            DocumentSignatureFormCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
