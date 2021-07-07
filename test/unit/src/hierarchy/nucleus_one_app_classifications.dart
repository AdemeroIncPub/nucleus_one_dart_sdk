import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/classification.dart';

void main() {
  group('NucleusOneAppClassifications class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.classifications;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<ClassificationCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppClassifications(app: n1App).get(),
        responseBody: classificationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<ClassificationCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppClassifications(app: n1App).get(
          cursor: 'A',
          getAll: true,
          includeDisabled: false,
          filter: 'B',
          fieldFilters: [
            FieldFilter('fi0', 'fv0', 'ft0', 'fvt0'),
            FieldFilter('fi1', 'fv1', 'ft1', 'fvt1'),
          ],
          includeClassificationIds: ['cA', 'cB'],
        ),
        responseBody: classificationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
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
          'includeClassificationIds_json=%5B%22cA%22%2C%22cB%22%5D', // Encoded JSON
        ],
      );
    });

    test('getFields method tests', () async {
      final n1App = getStandardN1App();

      try {
        await performHttpTest<ClassificationFieldCollection>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppClassifications(app: n1App).getFields(''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'classificationId');
      }

      final expectedUrlPath =
          http.apiPaths.classificationFieldsFormat.replaceFirst('<classificationId>', '123');

      await performHttpTest<ClassificationFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppClassifications(app: n1App).getFields('123'),
        responseBody: classificationFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
