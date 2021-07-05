import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/field_list_item.dart';
import '../api_model/form_template.dart';

void main() {
  group('NucleusOneAppForms class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getFormTemplates method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplates;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppForms(app: n1App).getFormTemplates(),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'sortDescending=false',
        ],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppForms(app: n1App).getFormTemplates(
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

    test('getFormTemplateById method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFormat.replaceFirst('<formTemplateId>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<FormTemplate>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppForms(app: n1App).getFormTemplateById('123', '456'),
        responseBody: formTemplateJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=456',
        ],
      );
    });

    test('getFormTemplateFields method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFieldsFormat.replaceFirst('<formTemplateId>', '123');
      final n1App = getStandardN1App();

      await performHttpTest<FormTemplateFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppForms(app: n1App).getFormTemplateFields('123', '456'),
        responseBody: formTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=456',
        ],
      );
    });

    test('getFormTemplateFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppForms(app: n1App).getFormTemplateFieldListItems('123', '234', '345'),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=345',
        ],
      );

      // Test with cursor and optional arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppForms(app: n1App).getFormTemplateFieldListItems(
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

    test('addFormTemplateFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');
      final n1App = getStandardN1App();

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => NucleusOneAppForms(app: n1App).addFormTemplateFieldListItems(
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
        httpCallCallback: () => NucleusOneAppForms(app: n1App).addFormTemplateFieldListItems(
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

    test('setFormTemplateFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', '123')
          .replaceFirst('<formTemplateFieldId>', '234');
      final n1App = getStandardN1App();

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => NucleusOneAppForms(app: n1App).setFormTemplateFieldListItems(
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
        httpCallCallback: () => NucleusOneAppForms(app: n1App).setFormTemplateFieldListItems(
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

    test('submitForm method tests', () async {
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicSubmissions.replaceFirst('<formTemplateId>', '123');
      final n1App = getStandardN1App();
      final apiModel =
          api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
      final package = FormSubmissionPackage.fromApiModel(apiModel);

      try {
        await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () =>
              NucleusOneAppForms(app: n1App).submitForm(formTemplateId: '', package: package),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'formTemplateId');
      }

      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            NucleusOneAppForms(app: n1App).submitForm(formTemplateId: '123', package: package),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
