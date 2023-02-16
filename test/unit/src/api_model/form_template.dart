import 'package:nucleus_one_dart_sdk/src/api_model/form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/form_template_field.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/mirrors.dart';
import 'field.dart';

const formTemplateJson =
    '{"ID":"A","TenantID":"B","UniqueID":"C","CreatedOn":"2021-03-29T13:53:08.461698Z","Name":"D","NameLower":"E","PageCount":1,"IsPublic":false,"ClassificationID":"F","ClassificationName":"G","ClassificationNameLower":"H","Aspect":1.234}';
const formTemplateCollectionJson =
    '{"FormTemplates":[$formTemplateJson],"Cursor":"QueryResultA","PageSize":24}';

const formSubmissionFieldJson =
    '{"ID":"B","FormTemplateID":"C","FormTemplateName":"D","FormTemplateNameLower":"E","TenantID":"F","UniqueID":"G","CreatedOn":"H","Type":"I","FieldID":"J","Field":$fieldJson,"PageIndex":0,"X":1.2,"Y":2.3,"Width":3.4,"FontSize":4,"UseColumnLayout":true,"AssetBucketName":"K","AssetObjectName":"L","AssetContentType":"M","AssetSignedUrl":"N","DefaultValue":"O","DefaultValues":"P","PossibleValues":["Q"],"Value":"R","Values":"S","FormTemplateFieldID":"A"}';
const formSubmissionPackageJson =
    '{"TenantID":"A","FormTemplateID":"B","FormSubmissionFields":[$formSubmissionFieldJson]}';
const formSubmissionPackageCollectionJson = '[$formSubmissionPackageJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */

  group('FormSubmissionField class tests', () {
    test('Inherits from FormTemplateFieldMixin', () {
      expect(
          classIsSubtypeOf<api_mod.FormSubmissionField, api_mod.FormTemplateFieldMixin>(), isTrue);
    });
  });
}
