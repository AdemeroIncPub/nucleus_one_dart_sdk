import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template_field.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/form_template_field.dart';

void main() {
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
}
