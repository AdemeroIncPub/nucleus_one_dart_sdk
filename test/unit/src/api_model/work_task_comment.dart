const workTaskEventJson =
    r'{"ID":"A","WorkTaskID":"B","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"C","CreatedByUserName":"D","CreatedByUserEmail":"E","ModifiedOn":"0001-01-01T00:00:00Z","Type":"Comment","WorkTaskRevision": 0,"DetailJson":"F"}';
const workTaskCommentsJson = r'{"WorkTaskEvents":[' +
    workTaskEventJson +
    r'],"Cursor":"QueryResultA","ReverseCursor":"QueryResultB","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
