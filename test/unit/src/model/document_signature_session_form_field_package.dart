import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_recipient_form_field.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_form_field_package.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session_form_field_package.dart';

void main() {
  group('DocumentSignatureSessionFormFieldPackage class tests', () {
    performStandardModelTests<DocumentSignatureSessionFormFieldPackage,
        api_mod.DocumentSignatureSessionFormFieldPackage>(
      apiModelJson: documentSignatureSessionFormFieldPackageJson,
      expectedPublicFieldCount: 7,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.formDesignType: 'A',
        apiModel.quickDesignPlaceInitials: true,
        apiModel.quickDesignPlaceFullName: false,
        apiModel.quickDesignPlaceEmail: true,
        apiModel.quickDesignPlaceTitle: false,
        apiModel.formFields: isA<List<api_mod.DocumentSignatureSessionRecipientFormField>>(),
        apiModel.completedFormFields:
            isA<List<api_mod.DocumentSignatureSessionRecipientFormField>>(),
      },
    );
  });
}
