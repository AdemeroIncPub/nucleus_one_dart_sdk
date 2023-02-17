import 'dart:convert';

import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_submission_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_submission_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';

import '../../../src/common.dart';
import '../api_model/form_submission_field.dart';
import '../api_model/form_submission_package.dart';

void main() {
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
}
