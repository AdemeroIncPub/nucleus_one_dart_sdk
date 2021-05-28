import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/document_field.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_fields.dart';
import 'package:test/test.dart';

import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../../../src/common.dart';
import '../api_model/document_field.dart';

void main() {
  group('DocumentField tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.fieldID, 'B');
        expect(apiModel.documentID, 'C');
        expect(apiModel.classificationID, 'D');
        expect(apiModel.value, 'E');
        expect(apiModel.uniqueTextValue, 'F');
        expect(apiModel.uniqueFirst1, 'G');
        expect(apiModel.uniqueFirst2, 'H');
        expect(apiModel.uniqueFirst3, 'I');
        expect(apiModel.uniqueFloatValue, 0.1);
        expect(apiModel.uniqueTimeValue, '2021-02-09T05:23:35.496635Z');
        expect(apiModel.uniqueYear, 'J');
        expect(apiModel.uniqueYearMonth, 'K');
      }

      final apiModelOrig = api_mod.DocumentField.fromJson(jsonDecode(documentFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('DocumentFieldCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.DocumentFieldCollection> apiModel) {
        expect(apiModel.results!.documentFields!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.DocumentFieldCollection>.fromJson(
          jsonDecode(documentFieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.DocumentFieldCollection> apiModelCycled =
          DocumentFieldCollectionQueryResult.fromApiModelFieldCollection(apiModelOrig)
              .toApiModel<api_mod.DocumentFieldCollection>();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.documentFields;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<DocumentFieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getDocumentFields(),
        responseBody: documentFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<DocumentFieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getDocumentFields(
          fieldId: 'A',
          fieldValueType: 'B',
          classificationId: 'C',
          cursor: 'D',
          fieldFilters: [
            FieldFilter('fi0', 'fv0', 'ft0', 'fvt0'),
            FieldFilter('fi1', 'fv1', 'ft1', 'fvt1'),
          ],
        ),
        responseBody: documentFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'fieldID=A',
          'fieldValueType=B',
          'classificationID=C',
          'cursor=D',
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
