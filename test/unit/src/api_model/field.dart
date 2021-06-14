const fieldJson =
    '{"ID":"A","CreatedOn":"2021-02-09T05:23:35.496635Z","ParentFieldID":"B","Name":"C","NameLower":"D","Label":"E","LabelLower":"F","LabelOrName":"G","LabelOrNameLower":"H","Type":"I","DisplaySelectionList":true,"AllowMultipleLines":false,"Rows":1,"AllowMultipleValues":true,"AllowNewSelectionListItems":false,"SaveNewSelectionListItems":true,"DecimalPlaces":0,"Mask":"J","Required":false,"Sensitive":true,"UseCreationDate":false,"TextMatchType":"K"}';
const fieldCollectionJson = '{"Fields":[' + fieldJson + '],"Cursor":"QueryResultA","PageSize":24}';

const fieldSelectionListItemJson = '{"ID":"A","ParentValue":"B","Value":"C"}';
const fieldSelectionListItemCollectionJson = '[$fieldSelectionListItemJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
