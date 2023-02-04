import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_signature_form.dart';

void main() {
  group('DocumentSignatureForm class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureForm, DocumentSignatureForm>(
      apiModelJson: documentSignatureFormJson,
      expectedPublicFieldCount: 13,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.signatureFormTemplateID: 'B',
        apiModel.createdOn: '2021-06-21T14:38:42.159832299Z',
        apiModel.tenantID: 'C',
        apiModel.documentID: 'D',
        apiModel.documentClassificationID: 'E',
        apiModel.documentClassificationName: 'F',
        apiModel.documentClassificationNameLower: 'G',
        apiModel.documentName: 'H',
        apiModel.documentNameLower: 'I',
        apiModel.hasFormFields: true,
        apiModel.totalFormFields: 0,
        apiModel.lastViewedPageIndex: 1,
      },
    );
  });

  group('DocumentSignatureFormCollection class tests', () {
    // !~!~!
    // DocumentSignatureFormCollection
    // 1

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
