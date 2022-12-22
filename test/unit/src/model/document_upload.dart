import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_upload.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_upload.dart';

void main() {
  group('DocumentUpload class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentUpload), 7);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentUpload apiModel) {
        expect(apiModel.signedUrl, 'A');
        expect(apiModel.objectName, 'B');
        expect(apiModel.uniqueId, 'C');
        expect(apiModel.originalFilename, 'D');
        expect(apiModel.originalFileSize, 0);
        expect(apiModel.classificationID, 'E');
        expect(apiModel.fieldIDsAndValues, {
          'A': {'A', 'B'}
        });
      }

      final apiModelOrig = api_mod.DocumentUpload.fromJson(jsonDecode(documentUploadJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentUpload.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
