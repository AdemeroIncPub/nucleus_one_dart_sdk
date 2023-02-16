const folderHierarchyJson =
    '{"ID":"A","CreatedOn":"2019-08-27T15:21:24.267312Z","Name":"B","NameLower":"C"}';
const folderHierarchyCollectionJson =
    '{"FolderHierarchies":[$folderHierarchyJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
