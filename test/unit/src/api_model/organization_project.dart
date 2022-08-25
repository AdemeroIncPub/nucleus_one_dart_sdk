const organizationProjectJson =
    r'{"ID":"A","OrganizationID":"B","AccessType":"C","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"D","CreatedByUserEmail":"E","CreatedByUserName":"F","Name":"G","NameLower":"H","Disabled":true,"IsMarkedForPurge":false,"PurgeMarkedOn":"0001-01-01T00:00:00Z","PurgeMarkedByUserID":"I","PurgeMarkedByUserName":"J","PurgeMarkedByUserEmail":"K"}';
const organizationProjectCollectionJson =
    '{"Projects":[$organizationProjectJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
