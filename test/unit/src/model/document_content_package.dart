import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/classification.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/classification.dart';
import '../api_model/document_content_package.dart';

void main() {
  group('DocumentContentPackage tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentContentPackage apiModel) {
        expect(apiModel.url, 'https://a.b.c/d');
        expect(apiModel.contentType, 'A');
        expect(apiModel.name, 'B');
        expect(apiModel.pageIndex, 0);
        expect(apiModel.pageCount, 1);
      }

      final apiModelOrig =
          api_mod.DocumentContentPackage.fromJson(jsonDecode(documentContentPackageJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentContentPackage.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('ClassificationCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.ClassificationCollection> apiModel) {
        expect(apiModel.results!.classifications!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.ClassificationCollection>.fromJson(
          jsonDecode(classificationCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.ClassificationCollection> apiModelCycled =
          ClassificationCollectionQueryResult.fromApiModelClassificationCollection(apiModelOrig)
              .toApiModel<api_mod.ClassificationCollection>();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.classifications;

      // Test with default parameters
      await performHttpTest<QueryResult<ClassificationCollection>>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => ClassificationCollection().get(),
          responseBody: classificationCollectionJson,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (x) {
            expect(x.results.items.length, 1);
          });

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<ClassificationCollection>>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              ClassificationCollection().get(cursor: 'A', getAll: true, includeDisabled: false),
          responseBody: classificationCollectionJson,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: ['cursor=A', 'getAll=true', 'includeDisabled=false'],
          additionalValidationsCallback: (x) {
            expect(x.results.items.length, 1);
          });
    });
  });
}
