import 'dart:convert';

import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_submission_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template_field.dart' as api_mod;

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/form_submission_field.dart';
import '../api_model/form_template_field.dart';
import 'form_template_field.dart';

void main() {
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
}
