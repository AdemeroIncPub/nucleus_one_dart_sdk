const supportUserJson =
    '{"ID":"A","CreatedOn":"0001-01-01T00:00:01Z","LastSignIn":"0001-01-01T00:00:01Z","LastActivity":"0001-01-01T00:00:01Z","Email":"B","Provider":"C","Name":"D"}';
const supportUserCollectionJson =
    '{"Users":[$supportUserJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
