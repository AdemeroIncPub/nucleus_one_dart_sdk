import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_documents.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/document_package.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_subscription.dart';
import 'package:test/test.dart';

import '../api_model/document_package.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('DocumentPackage class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentPackage apiModel) {
        expect(apiModel.document is Document, true);
        expect(apiModel.documentSubscription is DocumentSubscription, true);
        expect(apiModel.approval is Approval, true);
        expect(apiModel.classificationField is DocumentPackageField, true);
        expect(apiModel.indexFields is List<DocumentPackageField>, true);
      }

      final apiModelOrig = api_mod.DocumentPackage.fromJson(jsonDecode(documentPackageJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentPackage.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.documentPackageFormat;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<DocumentPackage>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppDocuments(app: n1App).getDocumentPackageByDocumentId('ABC'),
        responseBody: documentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
