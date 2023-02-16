import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/form_template.dart';

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
}
