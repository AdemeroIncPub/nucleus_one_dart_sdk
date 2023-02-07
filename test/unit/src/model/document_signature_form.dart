import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form.dart' as api_mod;
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
    performStandardModelTests<api_mod.DocumentSignatureFormCollection,
        DocumentSignatureFormCollection>(
      apiModelJson: documentSignatureFormCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
