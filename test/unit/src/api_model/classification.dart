const classificationJson =
    '{"ID":"B","CreatedOn":"2020-09-03T20:03:35.964878Z","Name":"C","NameLower":"D","IsActive":true}';
const classificationCollectionJson =
    '{"Classifications":[$classificationJson],"Cursor":"QueryResultA","PageSize":24}';
const classificationFieldJson =
    '{"ID":"A","ClassificationID":"B","ClassificationName":"C","FieldID":"D","FieldName":"E","FieldNameLower":"F","Rank":0.1,"Mapped":true}';
const classificationFieldCollectionJson = '[$classificationFieldJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
