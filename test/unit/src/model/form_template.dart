import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/field_list_item.dart';
import '../api_model/form_template.dart';

void main() {
  group('FormTemplate class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FormTemplate apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.tenantID, 'B');
        expect(apiModel.uniqueID, 'C');
        expect(apiModel.createdOn, '2021-03-29T13:53:08.461698Z');
        expect(apiModel.name, 'D');
        expect(apiModel.nameLower, 'E');
        expect(apiModel.pageCount, 1);
        expect(apiModel.isPublic, false);
        expect(apiModel.classificationID, 'F');
        expect(apiModel.classificationName, 'G');
        expect(apiModel.classificationNameLower, 'H');
        expect(apiModel.aspect, 1.234);
      }

      final apiModelOrig = api_mod.FormTemplate.fromJson(jsonDecode(formTemplateJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FormTemplate.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FormTemplateCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.FormTemplateCollection> apiModel) {
        expect(apiModel.results!.formTemplates!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.FormTemplateCollection>.fromJson(
          jsonDecode(formTemplateCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.FormTemplateCollection> apiModelCycled =
          FormTemplateCollectionQueryResult.fromApiModelFormTemplateCollection(apiModelOrig)
              .toApiModel<api_mod.FormTemplateCollection>();
      performTests(apiModelCycled);
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplates;

      // Test with default parameters
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().get(),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'sortDescending=false',
        ],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().get(
          cursor: 'A',
          sortDescending: true,
        ),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'sortDescending=true',
        ],
      );
    });

    test('getById method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFormat.replaceFirst('<formTemplateId>', '123');

      await performHttpTest<FormTemplate>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().getById('123', '456'),
        responseBody: formTemplateJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=456',
        ],
      );
    });

    test('getFields method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFieldsFormat.replaceFirst('<formTemplateId>', '123');

      await performHttpTest<FormTemplateFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().getFields('123', '456'),
        responseBody: formTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=456',
        ],
      );
    });

    test('getFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');

      // Test with default parameters
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().getFieldListItems('123', '234', '345'),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=345',
        ],
      );

      // Test with cursor and optional arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => FormTemplateCollection().getFieldListItems(
          '123',
          '234',
          '345',
          parentValue: '456',
          valueFilter: '567',
        ),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=345',
          'parentValue=456',
          'valueFilter=567',
        ],
      );
    });

    // Build a data set of the combinations of data that should throw an error, an the argument
    // on which the error should be thrown
    final addAndSetErrorDataSet = [
      {
        'formTemplateId': '',
        'formTemplateFieldId': '',
        'projectId': '',
        'expectedErrorField': 'formTemplateId',
      },
      {
        'formTemplateId': '123',
        'formTemplateFieldId': '',
        'projectId': '',
        'expectedErrorField': 'formTemplateFieldId',
      },
      {
        'formTemplateId': '123',
        'formTemplateFieldId': '234',
        'projectId': '',
        'expectedErrorField': 'projectId',
      },
    ];

    test('addListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => FormTemplateCollection().addListItems(
              formTemplateId: item['formTemplateId']!,
              formTemplateFieldId: item['formTemplateFieldId']!,
              projectId: item['projectId']!,
              items: FieldListItemCollection(),
            ),
            responseBody: '',
            expectedRequestUrlPath: '',
            expectedRequestQueryParams: [],
          );
          fail('An error should have been thrown.');
        } on ArgumentError catch (e) {
          expect(e.name, item['expectedErrorField']);
        }
      }

      final newListItems = FieldListItemCollection(
        items: [FieldListItem.createNew(parentValue: 'LI_A', value: 'LI_B')],
      );
      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => FormTemplateCollection().addListItems(
          formTemplateId: '123',
          formTemplateFieldId: '234',
          projectId: '345',
          items: newListItems,
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=345',
        ],
        expectedRequestBody: '[{"ID":"","ParentValue":"LI_A","Value":"LI_B"}]',
      );
    });

    test('setListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => FormTemplateCollection().setListItems(
              formTemplateId: item['formTemplateId']!,
              formTemplateFieldId: item['formTemplateFieldId']!,
              projectId: item['projectId']!,
              values: [],
            ),
            responseBody: '',
            expectedRequestUrlPath: '',
            expectedRequestQueryParams: [],
          );
          fail('An error should have been thrown.');
        } on ArgumentError catch (e) {
          expect(e.name, item['expectedErrorField']);
        }
      }

      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => FormTemplateCollection().setListItems(
          formTemplateId: '123',
          formTemplateFieldId: '234',
          projectId: '345',
          values: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'type=file',
          'tenantId=345',
        ],
        expectedRequestBody: 'A\nB\n',
      );
    });
  });

  group('FormTemplateFieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FormTemplateFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig =
          api_mod.FormTemplateFieldCollection.fromJson(jsonDecode(formTemplateFieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FormTemplateFieldCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FormTemplateFieldItem class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FormTemplateFieldItem apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.formTemplateID, 'B');
        expect(apiModel.formTemplateName, 'C');
        expect(apiModel.formTemplateNameLower, 'D');
        expect(apiModel.tenantID, 'E');
        expect(apiModel.uniqueID, 'F');
        expect(apiModel.createdOn, '2020-09-23T04:58:06.215898Z');
        expect(apiModel.type, 'G');
        expect(apiModel.fieldID, 'H');
        expect(apiModel.field, isA<api_mod.FormTemplateField>());
        expect(apiModel.pageIndex, 1);
        expect(apiModel.x, 2.00);
        expect(apiModel.y, 3.0);
        expect(apiModel.width, 4.0);
        expect(apiModel.fontSize, 5);
        expect(apiModel.useColumnLayout, true);
        expect(apiModel.assetBucketName, 'I');
        expect(apiModel.assetObjectName, 'J');
        expect(apiModel.assetContentType, 'K');
        expect(apiModel.assetSignedUrl, 'L');
        expect(apiModel.defaultValue, 'M');
        expect(apiModel.defaultValues, 'N');
        expect(apiModel.possibleValues, ['Yes', 'No']);
        expect(apiModel.value, 'O');
        expect(apiModel.values, 'P');
      }

      final apiModelOrig =
          api_mod.FormTemplateFieldItem.fromJson(jsonDecode(formTemplateFieldItemJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FormTemplateFieldItem.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('FormTemplateField tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.FormTemplateField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
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
        expect(apiModel.decimalPlaces, 2);
        expect(apiModel.mask, 'J');
        expect(apiModel.required, false);
        expect(apiModel.sensitive, true);
        expect(apiModel.useCreationDate, false);
        expect(apiModel.textMatchType, 'K');
      }

      final apiModelOrig = api_mod.FormTemplateField.fromJson(jsonDecode(formTemplateFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = FormTemplateField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
