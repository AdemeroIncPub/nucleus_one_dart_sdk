import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/field_list_item.dart';
import '../api_model/form_template.dart';

void main() {
  group('NucleusOneAppForms class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getFormTemplates method tests', () async {
      var forms = getStandardN1Project().forms();
      final expectedUrlPath = http.apiPaths.organizationsProjectsFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(forms.project);

      // Test with default parameters
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplates(),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      forms = getStandardN1Project().forms();
      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FormTemplateCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplates(
          cursor: 'A',
        ),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
        ],
      );
    });

    test('getFormTemplateById method tests', () async {
      final forms = getStandardN1Project().forms();
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFormat.replaceFormTemplateIdPlaceholder('123');

      await performHttpTest<FormTemplate>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplateById('123', '456'),
        responseBody: formTemplateJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=456',
        ],
      );
    });

    test('getFormTemplateFields method tests', () async {
      final forms = getStandardN1Project().forms();
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicFieldsFormat.replaceFormTemplateIdPlaceholder('123');

      await performHttpTest<FormTemplateFieldCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplateFields('123', '456'),
        responseBody: formTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=456',
        ],
      );
    });

    test('getFormTemplateFieldListItems method tests', () async {
      var forms = getStandardN1Project().forms();
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      // Test with default parameters
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplateFieldListItems('123', '234', '345'),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=345',
        ],
      );

      forms = getStandardN1Project().forms();
      // Test with cursor and optional arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => forms.getFormTemplateFieldListItems(
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
      var forms = getStandardN1Project().forms();
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await DefineN1AppInScopeAsync(forms.project.app, () async {
            return await performHttpTest(
              httpMethod: HttpMethods.POST,
              httpCallCallback: () => forms.addFormTemplateFieldListItems(
                formTemplateId: item['formTemplateId']!,
                formTemplateFieldId: item['formTemplateFieldId']!,
                projectId: item['projectId']!,
                items: FieldListItemCollection(),
              ),
              responseBody: '',
              expectedRequestUrlPath: '',
              expectedRequestQueryParams: [],
            );
          });
          fail('An error should have been thrown.');
        } on ArgumentError catch (e) {
          expect(e.name, item['expectedErrorField']);
        }
      }

      forms = getStandardN1Project().forms();
      await DefineN1AppInScopeAsync(forms.project.app, () async {
        final newListItems = FieldListItemCollection(
          items: [FieldListItem.createNew(parentValue: 'LI_A', value: 'LI_B')],
        );
        // Test a successful operation
        return await performHttpTest(
          httpMethod: HttpMethods.POST,
          httpCallCallback: () => forms.addFormTemplateFieldListItems(
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
    });

    test('setFormTemplateFieldListItems method tests', () async {
      final expectedUrlPath = http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => getStandardN1Project().forms().setFormTemplateFieldListItems(
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

      final forms = getStandardN1Project().forms();
      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => forms.setFormTemplateFieldListItems(
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
      var forms = getStandardN1Project().forms();
      final expectedUrlPath =
          http.apiPaths.formTemplatesPublicSubmissions.replaceFormTemplateIdPlaceholder('123');

      await DefineN1AppInScopeAsync(forms.project.app, () async {
        final apiModel =
            api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
        final package = FormSubmissionPackage.fromApiModel(apiModel);

        try {
          await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => forms.submitForm(formTemplateId: '', package: package),
            responseBody: '',
            expectedRequestUrlPath: '',
            expectedRequestQueryParams: [],
          );
          fail('An error should have been thrown.');
        } on ArgumentError catch (e) {
          expect(e.name, 'formTemplateId');
        }
      });

      forms = getStandardN1Project().forms();
      await DefineN1AppInScopeAsync(forms.project.app, () async {
        final apiModel =
            api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
        final package = FormSubmissionPackage.fromApiModel(apiModel);

        return await DefineN1AppInScopeAsync(forms.project.app, () async {
          return await performHttpTest(
            httpMethod: HttpMethods.POST,
            httpCallCallback: () => forms.submitForm(formTemplateId: '123', package: package),
            expectedRequestBody: formSubmissionPackageCollectionJson,
            responseBody: '',
            expectedRequestUrlPath: expectedUrlPath,
            expectedRequestQueryParams: [],
          );
        });
      });
    });
  });
}
