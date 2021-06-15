import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_upload.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_documents.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_upload.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document_upload.dart';

void main() {
  group('DocumentUpload class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
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

      // Convert it to a model class then back again
      final apiModelCycled = DocumentUpload.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.documentUploads;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<DocumentUpload>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getDocumentUpload(),
        responseBody: documentUploadJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
