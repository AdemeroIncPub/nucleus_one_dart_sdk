import 'package:nucleus_one_dart_sdk/src/api_model/form_template_field.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/mirrors.dart';
import 'field.dart';

const formTemplateFieldJson =
    '{"ID":"A","FormTemplateID":"B","FormTemplateName":"C","FormTemplateNameLower":"D","TenantID":"E","UniqueID":"F","CreatedOn":"2020-09-23T04:58:06.215898Z","Type":"G","FieldID":"H","Field":$fieldJson,"PageIndex":1,"X":2.00,"Y":3.0,"Width":4.0,"FontSize":5,"UseColumnLayout":true,"AssetBucketName":"I","AssetObjectName":"J","AssetContentType":"K","AssetSignedUrl":"L","DefaultValue":"M","DefaultValues":"N","PossibleValues":["Yes","No"],"Value":"O","Values":"P"}';
const formTemplateFieldCollectionJson = '[$formTemplateFieldJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */

  group('FormTemplateField class tests', () {
    test('Inherits from FormTemplateFieldMixin', () {
      expect(classIsSubtypeOf<api_mod.FormTemplateField, api_mod.FormTemplateFieldMixin>(), isTrue);
    });
  });
}
