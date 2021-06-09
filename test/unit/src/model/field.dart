import 'dart:async';
import 'dart:convert';

import 'package:file/memory.dart' as file;
import 'package:file/file.dart' as file;
import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_fields.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/field.dart';
import '../api_model/field_list_item.dart';

void main() {
  group('Field tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Field apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-02-09T05:23:35.496635Z');
        expect(apiModel.parentFieldID, 'B');
        expect(apiModel.name, 'C');
        expect(apiModel.nameLower, 'D');
        expect(apiModel.label, 'E');
        expect(apiModel.labelLower, 'F');
        expect(apiModel.labelOrName, 'G');
        expect(apiModel.labelOrNameLower, 'H');
        expect(apiModel.type, 'I');
        expect(apiModel.displaySelectionList, true);
        expect(apiModel.allowMultipleLines, false);
        expect(apiModel.rows, 1);
        expect(apiModel.allowMultipleValues, true);
        expect(apiModel.allowNewSelectionListItems, false);
        expect(apiModel.saveNewSelectionListItems, true);
        expect(apiModel.decimalPlaces, 0);
        expect(apiModel.mask, 'J');
        expect(apiModel.required, false);
        expect(apiModel.sensitive, true);
        expect(apiModel.useCreationDate, false);
        expect(apiModel.textMatchType, 'K');
      }

      final apiModelOrig = api_mod.Field.fromJson(jsonDecode(fieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Field.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FieldCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.FieldCollection> apiModel) {
        expect(apiModel.results!.fields!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.FieldCollection>.fromJson(jsonDecode(fieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.FieldCollection> apiModelCycled =
          FieldCollectionQueryResult.fromApiModelFieldCollection(apiModelOrig)
              .toApiModel<api_mod.FieldCollection>();
      performTests(apiModelCycled);
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

    test('getListItems method tests', () async {
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

    test('downloadListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', '123');
      final n1App = getStandardN1App();
      const outputFileName = '123.csv';
      const responseBody = 'abc';

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

    test('addListItems method tests', () async {
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

      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () => NucleusOneAppFields(app: n1App)
              .addFieldListItems(id: '123', items: FieldListItemCollection()),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'items');
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
        expectedRequestBody: '[{"ParentValue":"LI_A","Value":"LI_B"}]',
      );
    });

    test('setListItems method tests', () async {
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

      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () =>
              NucleusOneAppFields(app: n1App).setFieldListItems(id: '123', values: []),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'values');
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
