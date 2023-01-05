import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/form_template.dart';

void main() {
  group('FormTemplate class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormTemplate), 12);
    });

    test('Serialization test', () async {
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

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FormTemplate.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('FormTemplateCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormTemplateCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.FormTemplateCollection> apiModel) {
        expect(apiModel.results!.formTemplates!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.FormTemplateCollection>.fromJson(
          jsonDecode(formTemplateCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppAndProjectInScope(getStandardN1Project(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.FormTemplateCollection> apiModelCycled =
            FormTemplateCollectionQueryResult.fromApiModelFormTemplateCollection(apiModelOrig)
                .toApiModel<api_mod.FormTemplateCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('FormTemplateFieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormTemplateFieldCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FormTemplateFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig =
          api_mod.FormTemplateFieldCollection.fromJson(jsonDecode(formTemplateFieldCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FormTemplateFieldCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('FormTemplateFieldMixin mixin tests', () {
    // The tests for this mixin are effectively conducted in the FormTemplateField class tests,
    // since that class is simply the "instantiable" extension of this mixin
  });

  group('FormTemplateField class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Inherits from FormTemplateFieldMixin', () {
      expect(classIsSubtypeOf<FormTemplateField, FormTemplateFieldMixin>(), isTrue);
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormTemplateField), 25);
    });

    test('Serialization test', () async {
      void performFormTests(api_mod.FormTemplateField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.formTemplateID, 'B');
        expect(apiModel.formTemplateName, 'C');
        expect(apiModel.formTemplateNameLower, 'D');
        expect(apiModel.tenantID, 'E');
        expect(apiModel.uniqueID, 'F');
        expect(apiModel.createdOn, '2020-09-23T04:58:06.215898Z');
        expect(apiModel.type, 'G');
        expect(apiModel.fieldID, 'H');
        expect(apiModel.field, isA<api_mod.Field>());
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

      final apiModelOrig = api_mod.FormTemplateField.fromJson(jsonDecode(formTemplateFieldJson));
      performFormTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FormTemplateField.fromApiModel(apiModelOrig).toApiModel();
        performFormTests(apiModelCycled);
      });
    });
  });

  group('FormSubmissionField class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Inherits from FormTemplateFieldMixin', () {
      expect(classIsSubtypeOf<FormSubmissionField, FormTemplateFieldMixin>(), isTrue);
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormSubmissionField), 26);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FormSubmissionField apiModel) {
        expect(apiModel.formTemplateFieldID, 'A');
        expect(apiModel.id, 'B');
        expect(apiModel.formTemplateID, 'C');
        expect(apiModel.formTemplateName, 'D');
        expect(apiModel.formTemplateNameLower, 'E');
        expect(apiModel.tenantID, 'F');
        expect(apiModel.uniqueID, 'G');
        expect(apiModel.createdOn, 'H');
        expect(apiModel.type, 'I');
        expect(apiModel.fieldID, 'J');
        expect(apiModel.field, isA<api_mod.Field>());
        expect(apiModel.pageIndex, 0);
        expect(apiModel.x, 1.2);
        expect(apiModel.y, 2.3);
        expect(apiModel.width, 3.4);
        expect(apiModel.fontSize, 4);
        expect(apiModel.useColumnLayout, true);
        expect(apiModel.assetBucketName, 'K');
        expect(apiModel.assetObjectName, 'L');
        expect(apiModel.assetContentType, 'M');
        expect(apiModel.assetSignedUrl, 'N');
        expect(apiModel.defaultValue, 'O');
        expect(apiModel.defaultValues, 'P');
        expect(apiModel.possibleValues!.length, 1);
        expect(apiModel.possibleValues![0], 'Q');
        expect(apiModel.value, 'R');
        expect(apiModel.values, 'S');
      }

      final apiModelOrig =
          api_mod.FormSubmissionField.fromJson(jsonDecode(formSubmissionFieldJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FormSubmissionField.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('FormSubmissionField.fromFormTemplateField factory constructor test', () {
      final n1App = getStandardN1App();
      final ftf = FormTemplateField.fromApiModel(
        api_mod.FormTemplateField.fromJson(jsonDecode(formTemplateFieldJson)),
        app: n1App,
      );
      final fsf = FormSubmissionField.fromFormTemplateField(ftf, app: n1App);

      expect(fsf.id, 'A');
      expect(fsf.formTemplateID, 'B');
      expect(fsf.formTemplateName, 'C');
      expect(fsf.formTemplateNameLower, 'D');
      expect(fsf.tenantID, 'E');
      expect(fsf.uniqueID, 'F');
      expect(fsf.createdOn, '2020-09-23T04:58:06.215898Z');
      expect(fsf.type, 'G');
      expect(fsf.fieldID, 'H');
      expect(fsf.field, isA<Field>());
      expect(fsf.pageIndex, 1);
      expect(fsf.x, 2.00);
      expect(fsf.y, 3.0);
      expect(fsf.width, 4.0);
      expect(fsf.fontSize, 5);
      expect(fsf.useColumnLayout, true);
      expect(fsf.assetBucketName, 'I');
      expect(fsf.assetObjectName, 'J');
      expect(fsf.assetContentType, 'K');
      expect(fsf.assetSignedUrl, 'L');
      expect(fsf.defaultValue, 'M');
      expect(fsf.defaultValues, 'N');
      expect(fsf.possibleValues, ['Yes', 'No']);
      expect(fsf.value, 'O');
      expect(fsf.values, 'P');
    });
  });

  group('FormSubmissionPackageCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormSubmissionPackageCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FormSubmissionPackageCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.FormSubmissionPackageCollection.fromJson(
          jsonDecode(formSubmissionPackageCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            FormSubmissionPackageCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('FormSubmissionPackage class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.FormSubmissionPackage), 3);
    });

    test('Serialization test', () async {
      void performTests(api_mod.FormSubmissionPackage apiModel) {
        expect(apiModel.tenantID, 'A');
        expect(apiModel.formTemplateID, 'B');
        expect(apiModel.formSubmissionFields, isA<List<api_mod.FormSubmissionField>>());
        expect(apiModel.formSubmissionFields!.length, 1);
      }

      final apiModelOrig =
          api_mod.FormSubmissionPackage.fromJson(jsonDecode(formSubmissionPackageJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = FormSubmissionPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

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
