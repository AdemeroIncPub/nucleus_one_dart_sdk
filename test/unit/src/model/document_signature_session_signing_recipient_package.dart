import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_signing_recipient_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_signature_session_signing_recipient_package.dart';

void main() {
  group('DocumentSignatureSessionRecipientFormFieldCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionRecipientFormFieldCollection),
          1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionRecipientFormFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionRecipientFormFieldCollection.fromJson(
          jsonDecode(documentSignatureSessionRecipientFormFieldCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(apiModelOrig)
                .toApiModel();
        performTests(apiModelCycled);
      });
    });
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
