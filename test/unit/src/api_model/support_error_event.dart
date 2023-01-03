const supportErrorEventJson =
    '{"ID": "A","CreatedOn": "0001-01-01T00:00:01Z","TenantID": "B","TenantName": "C","TenantNameLower": "D","UserEmailLower": "E","UserID": "F","ServiceNameLower": "G","Level": "H","UniqueID": "I","RequestURI": "J","Header": "K","Message": "L","ClientMessage": "M","HttpStatus": 0,"OtherValues": ["A","B"],"WordsLower": ["A","B","C"]}';
const supportErrorEventCollectionJson =
    '{"ErrorEvents":[' + supportErrorEventJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
