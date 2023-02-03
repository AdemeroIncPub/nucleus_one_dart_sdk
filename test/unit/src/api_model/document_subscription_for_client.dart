const documentSubscriptionForClientJson =
    r'{"ID":"A","Subscribed":true,"Notify":false,"CreatedOn":"0001-01-01T00:00:00Z","OrganizationID":"B","ProjectID":"C","ProjectName":"D","ProjectAccessType":"E","DocumentID":"F","DocumentCreatedOn":"0001-01-01T00:00:00Z","DocumentName":"G","DocumentPageCount":0,"DocumentFileSize":1,"DocumentPreviewMetadata":[{"A":"A"}],"DocumentIsSigned":true,"DocumentThumbnailUrl":"H"}';
const documentSubscriptionForClientCollectionJson =
    '{"DocumentSubscriptions":[$documentSubscriptionForClientJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
