const classificationJson =
    '{"ID":"B","CreatedOn":"2020-09-03T20:03:35.964878Z","Name":"C","NameLower":"D","IsActive":true}';
const classificationCollectionJson =
    '{"Classifications":[$classificationJson],"Cursor":"A","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
