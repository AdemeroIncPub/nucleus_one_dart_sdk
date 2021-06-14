import 'package:file/memory.dart' as file;
import 'package:file/file.dart' as file;
import 'package:get_it/get_it.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/document_field.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_fields.dart';
import 'package:test/test.dart';

import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../../../src/common.dart';
import '../api_model/document_field.dart';
import '../api_model/field.dart';
import '../api_model/field_list_item.dart';

void main() {
  group('NucleusOneAppFields class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.documentFields;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<DocumentFieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getDocumentFields(
          fieldId: 'A',
          fieldValueType: 'B',
        ),
        responseBody: documentFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'fieldID=A',
          'fieldValueType=B',
        ],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<DocumentFieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getDocumentFields(
          fieldId: 'A',
          fieldValueType: 'B',
          cursor: 'C',
          classificationId: 'D',
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
          'cursor=C',
          'classificationID=D',
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

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.fields;
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<QueryResult<FieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getFields(),
        responseBody: fieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FieldCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getFields(
          cursor: 'A',
          getAll: true,
          filter: 'B',
          includeClassificationIds: ['cA', 'cB'],
        ),
        responseBody: fieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'getAll=true',
          'filter=B',
          'classificationIDs_json_base64=WyJjQSIsImNCIl0%3D', // Base-64 Encoded JSON
        ],
      );
    });

    test('getById method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      // Test with cursor and optional arguments
      await performHttpTest<Field>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getFieldById('123'),
        responseBody: fieldJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      // Test with default arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).getFieldListItems(id: '123'),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with optional arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppFields(app: n1App)
            .getFieldListItems(id: '123', parentValue: '234', valueFilter: '345'),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'parentValue=234',
          'valueFilter=345',
        ],
      );
    });

    test('downloadFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      const outputFileName = '123.csv';
      const responseBody = 'abc';

      try {
        await performHttpTest(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppFields(app: n1App)
              .downloadFieldListItems(id: '', destinationFilePath: ''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'id');
      }

      Future<void> performTests(Future<void> Function() callback) async {
        file.FileSystem? fsPrev;
        try {
          fsPrev = GetIt.instance.get<file.FileSystem>();
          GetIt.instance.unregister(instance: fsPrev);

          final mfs = file.MemoryFileSystem();
          GetIt.instance.registerSingleton<file.FileSystem>(mfs);

          await callback();

          // Read the output from the memory stream
          final pipedOutput = await mfs.file(outputFileName).readAsString();
          expect(pipedOutput, responseBody);
        } finally {
          if (fsPrev != null) {
            GetIt.instance.unregister<file.FileSystem>();
            GetIt.instance.registerSingleton<file.FileSystem>(fsPrev);
          }
        }
      }

      await performTests(() async {
        // Test with default arguments
        await performHttpTest<void>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppFields(app: n1App)
              .downloadFieldListItems(id: '123', destinationFilePath: outputFileName),
          responseBody: responseBody,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [
            'getAllAsFlatFile=true',
          ],
        );
      });

      await performTests(() async {
        // Test with optional arguments
        await performHttpTest<void>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppFields(app: n1App).downloadFieldListItems(
            id: '123',
            destinationFilePath: outputFileName,
            parentValue: 'A',
            valueFilter: 'B',
            cursor: 'C',
          ),
          responseBody: responseBody,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [
            'getAllAsFlatFile=true',
            'parentValue=A',
            'valueFilter=B',
            'cursor=C',
          ],
        );
      });
    });

    test('addFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () => NucleusOneAppFields(app: n1App)
              .addFieldListItems(id: '', items: FieldListItemCollection()),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'id');
      }

      final newListItems = FieldListItemCollection(
        items: [FieldListItem.createNew(parentValue: 'LI_A', value: 'LI_B')],
      );
      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppFields(app: n1App).addFieldListItems(
          id: '123',
          items: newListItems,
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '[{"ID":"","ParentValue":"LI_A","Value":"LI_B"}]',
      );
    });

    test('setFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () =>
              NucleusOneAppFields(app: n1App).setFieldListItems(id: '', values: []),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'id');
      }

      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            NucleusOneAppFields(app: n1App).setFieldListItems(id: '123', values: ['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'type=file',
        ],
        expectedRequestBody: 'A\nB\n',
      );
    });
  });
}
