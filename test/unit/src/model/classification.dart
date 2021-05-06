import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/classification.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/classification.dart';

void main() {
  group('Classification tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Classification apiModel) {
        expect(apiModel.createdOn, '2020-09-03T20:03:35.964878Z');
        expect(apiModel.id, 'B');
        expect(apiModel.name, 'C');
        expect(apiModel.nameLower, 'D');
        expect(apiModel.isActive, true);
      }

      final apiModelOrig = api_mod.Classification.fromJson(jsonDecode(classificationJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Classification.fromApiModel(apiModelOrig).toApiModel();
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
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<ClassificationCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => ClassificationCollection().get(
          cursor: 'A',
          getAll: true,
          includeDisabled: false,
          filter: 'B',
          fieldFilters: [
            FieldFilter(0, 'fi0', 'fv0', 'ft0', 'fvt0'),
            FieldFilter(1, 'fi1', 'fv1', 'ft1', 'fvt1'),
          ],
        ),
        responseBody: classificationCollectionJson,
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [
          'cursor=A',
          'getAll=true',
          'includeDisabled=false',
          'filter=B',
          'fieldID0=fi0',
          'fieldValue0=fv0',
          'fieldType0=ft0',
          'fieldValueType0=fvt0',
          'fieldID1=fi1',
          'fieldValue1=fv1',
          'fieldType1=ft1',
          'fieldValueType1=fvt1',
        ],
      );
    });
  });
}
