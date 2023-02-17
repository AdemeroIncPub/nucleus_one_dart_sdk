import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session_signing_recipient.dart';

void main() {
  group('DocumentSignatureSessionSigningRecipient class tests', () {
    performStandardModelTests<DocumentSignatureSessionSigningRecipient,
        api_mod.DocumentSignatureSessionSigningRecipient>(
      apiModelJson: documentSignatureSessionSigningRecipientJson,
      expectedPublicFieldCount: 2,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.email: 'A',
        apiModel.fullName: 'B',
      },
    );
  });
}
