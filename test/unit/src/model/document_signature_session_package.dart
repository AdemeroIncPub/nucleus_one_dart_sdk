// ignore_for_file: unused_import

import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_package.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_recipient.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session.dart';
import '../api_model/document_signature_session_package.dart';

void main() {
  group('DocumentSignatureSessionPackage class tests', () {
    performStandardModelTests<DocumentSignatureSessionPackage,
        api_mod.DocumentSignatureSessionPackage>(
      apiModelJson: documentSignatureSessionPackageJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.session: isA<api_mod.DocumentSignatureSession>(),
        apiModel.recipients: isA<List<api_mod.DocumentSignatureSessionRecipient>>(),
        apiModel.recipients!.length: 1,
        apiModel.beginSession: true,
        apiModel.resetSession: false,
      },
    );
  });

  group('DocumentSignatureSessionPackageCollection class tests', () {
    performStandardModelTests<DocumentSignatureSessionPackageCollection,
        api_mod.DocumentSignatureSessionPackageCollection>(
      apiModelJson: documentSignatureSessionPackageCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
