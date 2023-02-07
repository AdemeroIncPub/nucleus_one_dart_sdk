const folderHierarchyJson =
    '{"ID":"A","CreatedOn":"2019-08-27T15:21:24.267312Z","Name":"B","NameLower":"C"}';
const folderHierarchyCollectionJson =
    '{"FolderHierarchies":[$folderHierarchyJson],"Cursor":"QueryResultA","PageSize":24}';

const folderHierarchyItemJson =
    '{"ID":"A","FolderHierarchyID":"B","FolderHierarchyName":"C","Rank":0,"Type":"D","FieldID":"E","FieldName":"F","FieldType":"G","FieldValueType":"H"}';
const folderHierarchyItemCollectionJson = '[$folderHierarchyItemJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
