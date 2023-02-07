const documentEventJson =
    r'{"ID":"A","DocumentID":"B","CreatedOn":"2020-09-10T18:55:56.901688Z","CreatedByUserID":"C","CreatedByUserName":"D","CreatedByUserEmail":"E","Type":"Comment","DetailJson":"F"}';
const documentEventCollectionJson =
    '{"DocumentEvents":[$documentEventJson],"Cursor":"QueryResultA","ReverseCursor":"QueryResultB","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
