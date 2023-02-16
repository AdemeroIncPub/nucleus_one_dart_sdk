import 'dart:convert';

import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_submission_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/field_list_item.dart';
import '../api_model/form_submission_package.dart';
import '../api_model/form_template.dart';
import '../api_model/form_template_field.dart';

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
      final expectedUrlPath = http.ApiPaths.organizationsProjectsFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(forms.project);

      // Test with default parameters
      await performHttpTest<QueryResult<FormTemplateCollection, api_mod.FormTemplateCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => forms.getFormTemplates(),
        responseBody: formTemplateCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      forms = getStandardN1Project().forms();
      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<FormTemplateCollection, api_mod.FormTemplateCollection>>(
        httpMethod: HttpMethods.get,
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
          http.ApiPaths.formTemplatesPublicFormat.replaceFormTemplateIdPlaceholder('123');

      await performHttpTest<FormTemplate>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => forms.getFormTemplateById(formTemplateById: '123', uniqueId: '456'),
        responseBody: formTemplateJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'uniqueId=456',
        ],
      );
    });

    test('getFormTemplateFields method tests', () async {
      final proj = getStandardN1Project();
      final forms = proj.forms();
      final expectedUrlPath =
          http.ApiPaths.formTemplatesPublicFieldsFormat.replaceFormTemplateIdPlaceholder('123');

      await performHttpTest<FormTemplateFieldCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => forms.getFormTemplateFields('123'),
        responseBody: formTemplateFieldCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=${proj.id}',
        ],
      );
    });

    test('getFormTemplateFieldListItems method tests', () async {
      var proj = getStandardN1Project();
      var forms = proj.forms();
      final expectedUrlPath = http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      // Test with default parameters
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => forms.getFormTemplateFieldListItems(
          formTemplateId: '123',
          formTemplateFieldId: '234',
        ),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=${proj.id}',
        ],
      );

      proj = getStandardN1Project();
      forms = getStandardN1Project().forms();
      // Test with cursor and optional arguments
      await performHttpTest<FieldListItemCollection>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => forms.getFormTemplateFieldListItems(
          formTemplateId: '123',
          formTemplateFieldId: '234',
          parentValue: '456',
          valueFilter: '567',
        ),
        responseBody: fieldListItemCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'tenantId=${proj.id}',
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
        'expectedErrorField': 'formTemplateId',
      },
      {
        'formTemplateId': '123',
        'formTemplateFieldId': '',
        'expectedErrorField': 'formTemplateFieldId',
      },
    ];

    test('addFormTemplateFieldListItems method tests', () async {
      var proj = getStandardN1Project();
      var forms = proj.forms();
      final expectedUrlPath = http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await defineN1AppInScopeAsync(forms.project.app, () async {
            return await performHttpTest(
              httpMethod: HttpMethods.post,
              httpCallCallback: () => forms.addFormTemplateFieldListItems(
                formTemplateId: item['formTemplateId']!,
                formTemplateFieldId: item['formTemplateFieldId']!,
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

      proj = getStandardN1Project();
      forms = proj.forms();
      await defineN1AppInScopeAsync(forms.project.app, () async {
        final newListItems = FieldListItemCollection(
          items: [FieldListItem.createNew(parentValue: 'LI_A', value: 'LI_B')],
        );
        // Test a successful operation
        return await performHttpTest(
          httpMethod: HttpMethods.post,
          httpCallCallback: () => forms.addFormTemplateFieldListItems(
            formTemplateId: '123',
            formTemplateFieldId: '234',
            items: newListItems,
          ),
          responseBody: '',
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [
            'tenantId=${proj.id}',
          ],
          expectedRequestBody: '[{"ID":"","ParentValue":"LI_A","Value":"LI_B"}]',
        );
      });
    });

    test('setFormTemplateFieldListItems method tests', () async {
      final expectedUrlPath = http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder('123')
          .replaceFormTemplateFieldIdPlaceholder('234');

      for (var item in addAndSetErrorDataSet) {
        try {
          await performHttpTest(
            httpMethod: HttpMethods.post,
            httpCallCallback: () => getStandardN1Project().forms().setFormTemplateFieldListItems(
              formTemplateId: item['formTemplateId']!,
              formTemplateFieldId: item['formTemplateFieldId']!,
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

      final proj = getStandardN1Project();
      final forms = proj.forms();
      // Test a successful operation
      await performHttpTest(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => forms.setFormTemplateFieldListItems(
          formTemplateId: '123',
          formTemplateFieldId: '234',
          values: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'type=file',
          'tenantId=${proj.id}',
        ],
        expectedRequestBody: 'A\nB\n',
      );
    });

    test('submitFormPackage method tests', () async {
      var forms = getStandardN1Project().forms();
      final expectedUrlPath =
          http.ApiPaths.formTemplatesPublicSubmissions.replaceFormTemplateIdPlaceholder('123');

      await defineN1AppInScopeAsync(forms.project.app, () async {
        final apiModel =
            api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
        final package = FormSubmissionPackage.fromApiModel(apiModel);

        try {
          await performHttpTest(
            httpMethod: HttpMethods.post,
            httpCallCallback: () => forms.submitFormPackage(formTemplateId: '', package: package),
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
      await defineN1AppInScopeAsync(forms.project.app, () async {
        final apiModel =
            api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
        final package = FormSubmissionPackage.fromApiModel(apiModel);

        return await defineN1AppInScopeAsync(forms.project.app, () async {
          return await performHttpTest(
            httpMethod: HttpMethods.post,
            httpCallCallback: () =>
                forms.submitFormPackage(formTemplateId: '123', package: package),
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
