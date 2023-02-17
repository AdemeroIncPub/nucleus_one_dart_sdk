import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_form_field_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session_signing_recipient_package.dart';

void main() {
  group('DocumentSignatureSessionSigningRecipientPackage class tests', () {
    performStandardModelTests<DocumentSignatureSessionSigningRecipientPackage,
        api_mod.DocumentSignatureSessionSigningRecipientPackage>(
      apiModelJson: documentSignatureSessionSigningRecipientPackageJson,
      expectedPublicFieldCount: 5,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.requireAccessCode: false,
        apiModel.signingRecipient: isA<api_mod.DocumentSignatureSessionSigningRecipient>(),
        apiModel.formFieldPackage: isA<api_mod.DocumentSignatureSessionFormFieldPackage>(),
        apiModel.serverDate: '2021-06-23T15:56:33.360404143Z',
        apiModel.contentPackage: isA<api_mod.DocumentContentPackage>(),
      },
    );
  });
}
