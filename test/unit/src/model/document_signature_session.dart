import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_signature_session.dart';

void main() {
  group('DocumentSignatureSession class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSession), 27);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSession apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-06-21T15:21:18.483838807Z');
        expect(apiModel.modifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'B');
        expect(apiModel.createdByUserEmail, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.lastModifiedByUserID, 'E');
        expect(apiModel.lastModifiedByUserEmail, 'F');
        expect(apiModel.lastModifiedByUserName, 'G');
        expect(apiModel.documentID, 'H');
        expect(apiModel.documentRevisionID, 'I');
        expect(apiModel.isActive, true);
        expect(apiModel.isComplete, false);
        expect(apiModel.wasStopped, true);
        expect(apiModel.completedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.isRendered, false);
        expect(apiModel.renderedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.formDesignType, 'J');
        expect(apiModel.useAccessCode, true);
        expect(apiModel.accessCode, 'K');
        expect(apiModel.useCustomSubjectAndBody, false);
        expect(apiModel.customSubject, 'L');
        expect(apiModel.customBody, 'M');
        expect(apiModel.quickDesignPlaceInitials, true);
        expect(apiModel.quickDesignPlaceFullName, false);
        expect(apiModel.quickDesignPlaceEmail, true);
        expect(apiModel.quickDesignPlaceTitle, false);
      }

      final apiModelOrig =
          api_mod.DocumentSignatureSession.fromJson(jsonDecode(documentSignatureSessionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentSignatureSession.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionRecipient class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      Function deepEq = const DeepCollectionEquality().equals;

      void performTests(api_mod.DocumentSignatureSessionRecipient apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.tenantID, 'B');
        expect(apiModel.documentID, 'C');
        expect(apiModel.documentCreatedOn, '2021-06-21T13:51:14.231757Z');
        expect(apiModel.documentBucketName, 'D');
        expect(apiModel.documentThumbnailObjectName, 'E');
        expect(apiModel.documentName, 'F');
        expect(apiModel.documentNameLower, 'G');
        expect(apiModel.documentPageCount, 0);
        expect(apiModel.documentFileSize, 1);
        expect(apiModel.documentClassificationID, 'H');
        expect(apiModel.documentClassificationName, 'I');
        expect(apiModel.documentClassificationNameLower, 'J');
        deepEq(apiModel.documentPreviewMetadata, [
          <String, String>{'K': 'L'}
        ]);
        expect(apiModel.documentSignatureSessionID, 'M');
        expect(apiModel.documentSignatureSessionIsActive, true);
        expect(apiModel.documentSignatureSessionIsComplete, false);
        expect(apiModel.uniqueID, 'N');
        expect(apiModel.rank, 2);
        expect(apiModel.email, 'O');
        expect(apiModel.fullName, 'P');
        expect(apiModel.type, 'Q');
        expect(apiModel.tenantMemberID, 'R');
        expect(apiModel.signingRequestSent, true);
        expect(apiModel.requestedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.isActive, false);
        expect(apiModel.isComplete, true);
        expect(apiModel.completedOn, '0002-01-01T00:00:00Z');
        expect(apiModel.ipAddress, 'S');
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionRecipient.fromJson(
          jsonDecode(documentSignatureSessionRecipientJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionRecipient.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionPackage class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionPackage), 4);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionPackage apiModel) {
        expect(apiModel.session, isA<api_mod.DocumentSignatureSession>());
        expect(apiModel.recipients, isA<List<api_mod.DocumentSignatureSessionRecipient>>());
        expect(apiModel.recipients!.length, 1);
        expect(apiModel.beginSession, true);
        expect(apiModel.resetSession, false);
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionPackage.fromJson(
          jsonDecode(documentSignatureSessionPackageJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentSignatureSessionPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentSignatureSessionPackageCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentSignatureSessionPackageCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionPackageCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
          jsonDecode(documentSignatureSessionPackageCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.DocumentSignatureSessionPackageCollection apiModelCycled =
            DocumentSignatureSessionPackageCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
