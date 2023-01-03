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
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

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

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(apiModelOrig)
                .toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionRecipientFormField class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionRecipientFormField), 11);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionRecipientFormField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.documentSignatureFormFieldID, 'B');
        expect(apiModel.documentSignatureSessionRecipientID, 'C');
        expect(apiModel.documentSignatureSessionRecipientRank, 0);
        expect(apiModel.isComplete, true);
        expect(apiModel.type, 'D');
        expect(apiModel.pageIndex, 1);
        expect(apiModel.x, 2.34);
        expect(apiModel.y, 3.45);
        expect(apiModel.value, 'E');
        expect(apiModel.placementRank, 4);
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionRecipientFormField.fromJson(
          jsonDecode(documentSignatureSessionRecipientFormFieldJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionRecipientFormField.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionFormFieldPackage class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionFormFieldPackage), 7);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionFormFieldPackage apiModel) {
        expect(apiModel.formDesignType, 'A');
        expect(apiModel.quickDesignPlaceInitials, true);
        expect(apiModel.quickDesignPlaceFullName, false);
        expect(apiModel.quickDesignPlaceEmail, true);
        expect(apiModel.quickDesignPlaceTitle, false);
        expect(
            apiModel.formFields, isA<List<api_mod.DocumentSignatureSessionRecipientFormField>>());
        expect(apiModel.completedFormFields,
            isA<List<api_mod.DocumentSignatureSessionRecipientFormField>>());
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionFormFieldPackage.fromJson(
          jsonDecode(documentSignatureSessionFormFieldPackageJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionFormFieldPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionSigningRecipient class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionSigningRecipient), 2);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionSigningRecipient apiModel) {
        expect(apiModel.email, 'A');
        expect(apiModel.fullName, 'B');
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionSigningRecipient.fromJson(
          jsonDecode(documentSignatureSessionSigningRecipientJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionSigningRecipient.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionSigningRecipientPackage class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionSigningRecipientPackage), 5);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionSigningRecipientPackage apiModel) {
        expect(apiModel.requireAccessCode, false);
        expect(apiModel.signingRecipient, isA<api_mod.DocumentSignatureSessionSigningRecipient>());
        expect(apiModel.formFieldPackage, isA<api_mod.DocumentSignatureSessionFormFieldPackage>());
        expect(apiModel.serverDate, '2021-06-23T15:56:33.360404143Z');
        expect(apiModel.contentPackage, isA<api_mod.DocumentContentPackage>());
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionSigningRecipientPackage.fromJson(
          jsonDecode(documentSignatureSessionSigningRecipientPackageJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionSigningRecipientPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
