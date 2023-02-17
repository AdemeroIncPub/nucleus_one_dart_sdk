import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_recipient_form_field.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session_recipient_form_field.dart';

void main() {
  group('DocumentSignatureSessionRecipientFormField class tests', () {
    performStandardModelTests<DocumentSignatureSessionRecipientFormField,
        api_mod.DocumentSignatureSessionRecipientFormField>(
      apiModelJson: documentSignatureSessionRecipientFormFieldJson,
      expectedPublicFieldCount: 11,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.documentSignatureFormFieldID: 'B',
        apiModel.documentSignatureSessionRecipientID: 'C',
        apiModel.documentSignatureSessionRecipientRank: 0,
        apiModel.isComplete: true,
        apiModel.type: 'D',
        apiModel.pageIndex: 1,
        apiModel.x: 2.34,
        apiModel.y: 3.45,
        apiModel.value: 'E',
        apiModel.placementRank: 4,
      },
    );
  });

  group('DocumentSignatureSessionRecipientFormFieldCollection class tests', () {
    performStandardModelTests<DocumentSignatureSessionRecipientFormFieldCollection,
        api_mod.DocumentSignatureSessionRecipientFormFieldCollection>(
      apiModelJson: documentSignatureSessionRecipientFormFieldCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
