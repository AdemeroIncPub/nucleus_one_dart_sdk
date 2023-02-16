import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/form_template.dart';
import '../api_model/form_template_field.dart';

void main() {
  group('FormTemplate class tests', () {
    performStandardModelTests<FormTemplate, api_mod.FormTemplate>(
      apiModelJson: formTemplateJson,
      expectedPublicFieldCount: 12,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.tenantID: 'B',
        apiModel.uniqueID: 'C',
        apiModel.createdOn: '2021-03-29T13:53:08.461698Z',
        apiModel.name: 'D',
        apiModel.nameLower: 'E',
        apiModel.pageCount: 1,
        apiModel.isPublic: false,
        apiModel.classificationID: 'F',
        apiModel.classificationName: 'G',
        apiModel.classificationNameLower: 'H',
        apiModel.aspect: 1.234,
      },
    );
  });

  group('FormTemplateCollection class tests', () {
    performStandardQueryResultModelTests<
        FormTemplateCollection,
        api_mod.FormTemplateCollection,
        QueryResult<FormTemplateCollection, api_mod.FormTemplateCollection>,
        api_mod.QueryResult<api_mod.FormTemplateCollection>>(
      requiresAppAndProjectInScope: true,
      apiModelJson: formTemplateCollectionJson,
    );
  });

  group('FormTemplateFieldCollection class tests', () {
    performStandardModelTests<FormTemplateFieldCollection, api_mod.FormTemplateFieldCollection>(
      apiModelJson: formTemplateFieldCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });

  group('FormTemplateFieldMixin mixin tests', () {
    // The tests for this mixin are effectively conducted in the FormTemplateField class tests,
    // since that class is simply the "instantiable" extension of this mixin
  });

  Map<dynamic, dynamic> formTemplateFieldFieldsAndExpectedValues(dynamic object) {
    final isApiModel = (object is api_mod.FormTemplateField);
    return <dynamic, dynamic>{
      object.id: 'A',
      object.formTemplateID: 'B',
      object.formTemplateName: 'C',
      object.formTemplateNameLower: 'D',
      object.tenantID: 'E',
      object.uniqueID: 'F',
      object.createdOn: '2020-09-23T04:58:06.215898Z',
      object.type: 'G',
      object.fieldID: 'H',
      object.field: isApiModel ? isA<api_mod.Field>() : isA<Field>(),
      object.pageIndex: 1,
      object.x: 2.00,
      object.y: 3.0,
      object.width: 4.0,
      object.fontSize: 5,
      object.useColumnLayout: true,
      object.assetBucketName: 'I',
      object.assetObjectName: 'J',
      object.assetContentType: 'K',
      object.assetSignedUrl: 'L',
      object.defaultValue: 'M',
      object.defaultValues: 'N',
      object.possibleValues: ['Yes', 'No'],
      object.value: 'O',
      object.values: 'P',
    };
  }

  group('FormTemplateField class tests', () {
    test('Inherits from FormTemplateFieldMixin', () {
      expect(classIsSubtypeOf<FormTemplateField, FormTemplateFieldMixin>(), isTrue);
    });

    performStandardModelTests<FormTemplateField, api_mod.FormTemplateField>(
      apiModelJson: formTemplateFieldJson,
      expectedPublicFieldCount: 25,
      fieldsAndExpectedValues: formTemplateFieldFieldsAndExpectedValues,
    );
  });

  group('FormSubmissionField class tests', () {
    test('Inherits from FormTemplateFieldMixin', () {
      expect(classIsSubtypeOf<FormSubmissionField, FormTemplateFieldMixin>(), isTrue);
    });

    performStandardModelTests<FormSubmissionField, api_mod.FormSubmissionField>(
      apiModelJson: formSubmissionFieldJson,
      expectedPublicFieldCount: 26,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.formTemplateFieldID: 'A',
        apiModel.id: 'B',
        apiModel.formTemplateID: 'C',
        apiModel.formTemplateName: 'D',
        apiModel.formTemplateNameLower: 'E',
        apiModel.tenantID: 'F',
        apiModel.uniqueID: 'G',
        apiModel.createdOn: 'H',
        apiModel.type: 'I',
        apiModel.fieldID: 'J',
        apiModel.field: isA<api_mod.Field>(),
        apiModel.pageIndex: 0,
        apiModel.x: 1.2,
        apiModel.y: 2.3,
        apiModel.width: 3.4,
        apiModel.fontSize: 4,
        apiModel.useColumnLayout: true,
        apiModel.assetBucketName: 'K',
        apiModel.assetObjectName: 'L',
        apiModel.assetContentType: 'M',
        apiModel.assetSignedUrl: 'N',
        apiModel.defaultValue: 'O',
        apiModel.defaultValues: 'P',
        apiModel.possibleValues!.length: 1,
        apiModel.possibleValues![0]: 'Q',
        apiModel.value: 'R',
        apiModel.values: 'S',
      },
    );

    test('FormSubmissionField.fromFormTemplateField factory constructor test', () {
      final n1App = getStandardN1App();
      final apiModelFtf = FormTemplateField.fromApiModel(
        api_mod.FormTemplateField.fromJson(jsonDecode(formTemplateFieldJson)),
        app: n1App,
      );
      final fsf = FormSubmissionField.fromFormTemplateField(apiModelFtf);

      testObjectFieldValues(
        object: fsf,
        fieldsAndExpectedValues: formTemplateFieldFieldsAndExpectedValues,
      );
    });
  });

  group('FormSubmissionPackageCollection class tests', () {
    performStandardModelTests<FormSubmissionPackageCollection,
        api_mod.FormSubmissionPackageCollection>(
      apiModelJson: formSubmissionPackageCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });

  group('FormSubmissionPackage class tests', () {
    performStandardModelTests<FormSubmissionPackage, api_mod.FormSubmissionPackage>(
      apiModelJson: formSubmissionPackageJson,
      expectedPublicFieldCount: 3,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.tenantID: 'A',
        apiModel.formTemplateID: 'B',
        apiModel.formSubmissionFields: isA<List<api_mod.FormSubmissionField>>(),
        apiModel.formSubmissionFields!.length: 1,
      },
    );

    test('createNew method test', () async {
      try {
        FormSubmissionPackage.createNew(
          tenantID: '',
          formTemplateID: '',
          formSubmissionFields: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'tenantID');
      }

      try {
        FormSubmissionPackage.createNew(
          tenantID: 'A',
          formTemplateID: '',
          formSubmissionFields: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'formTemplateID');
      }

      await defineN1AppInScope(getStandardN1App(), () {
        final fsf = FormSubmissionField.fromApiModel(
            api_mod.FormSubmissionField.fromJson(jsonDecode(formSubmissionFieldJson)));
        final m = FormSubmissionPackage.createNew(
          tenantID: 'A',
          formTemplateID: 'B',
          formSubmissionFields: [fsf],
        );

        expect(m.tenantID, 'A');
        expect(m.formTemplateID, 'B');
        expect(m.formSubmissionFields.length, 1);
        expect(m.formSubmissionFields[0], isA<FormSubmissionField>());
      });
    });
  });
}
