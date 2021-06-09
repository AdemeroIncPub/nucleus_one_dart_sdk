import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document.dart';

import 'package:test/test.dart';

import '../api_model/document.dart';

void main() {
  group('Document class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Document apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'B');
        expect(apiModel.createdByUserEmail, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.name, 'E');
        expect(apiModel.nameLower, 'F');
        expect(apiModel.origin, 'G');
        expect(apiModel.isActive, false);
        expect(apiModel.isClassified, false);
        expect(apiModel.isMarkedForPurge, false);
        expect(apiModel.isSigned, false);
        expect(apiModel.signatureSessionIsActive, false);
        expect(apiModel.hasSinglePageImages, false);
        expect(apiModel.signaturesCompletedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.purgeMarkedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.failedBuildAttempts, false);
        expect(apiModel.lastError, 'H');
        expect(apiModel.pageCount, 0);
        expect(apiModel.fileSize, 1);
        expect(apiModel.bucketName, 'I');
        expect(apiModel.sourceObjectName, 'J');
        expect(apiModel.thumbnailObjectName, 'K');
        expect(apiModel.classificationID, 'L');
        expect(apiModel.classificationName, 'M');
        expect(apiModel.classificationNameLower, 'N');
        expect(apiModel.previewMetadata, isNotNull);
        expect(apiModel.previewMetadata!.length, 1);
      }

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Document.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
