const documentFieldJson =
    '{"ID": "A","FieldID": "B","DocumentID": "C","ClassificationID": "D","Value": "E","UniqueTextValue": "F","UniqueFirst1": "G","UniqueFirst2": "H","UniqueFirst3": "I","UniqueFloatValue": 0.1,"UniqueTimeValue": "2021-02-09T05:23:35.496635Z","UniqueYear": "J","UniqueYearMonth": "K"}';
const documentFieldCollectionJson =
    '{"DocumentFields":[' + documentFieldJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
