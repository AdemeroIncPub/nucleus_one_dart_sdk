import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_signature_session_signing_recipient_package.dart';

void main() {
  group('DocumentSignatureSessionRecipientFormFieldCollection class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionRecipientFormFieldCollection,
        DocumentSignatureSessionRecipientFormFieldCollection>(
      apiModelJson: documentSignatureSessionRecipientFormFieldCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });

  group('DocumentSignatureSessionRecipientFormField class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionRecipientFormField,
        DocumentSignatureSessionRecipientFormField>(
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

  group('DocumentSignatureSessionFormFieldPackage class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionFormFieldPackage,
        DocumentSignatureSessionFormFieldPackage>(
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

  group('DocumentSignatureSessionSigningRecipient class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionSigningRecipient,
        DocumentSignatureSessionSigningRecipient>(
      apiModelJson: documentSignatureSessionSigningRecipientJson,
      expectedPublicFieldCount: 2,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.email: 'A',
        apiModel.fullName: 'B',
      },
    );
  });

  group('DocumentSignatureSessionSigningRecipientPackage class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionSigningRecipientPackage,
        DocumentSignatureSessionSigningRecipientPackage>(
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
