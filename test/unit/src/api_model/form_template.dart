const formTemplateJson =
    '{"ID":"A","TenantID":"B","UniqueID":"C","CreatedOn":"2021-03-29T13:53:08.461698Z","Name":"D","NameLower":"E","PageCount":1,"IsPublic":false,"ClassificationID":"F","ClassificationName":"G","ClassificationNameLower":"H","Aspect":1.234}';
const formTemplateCollectionJson =
    '{"FormTemplates":[$formTemplateJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
