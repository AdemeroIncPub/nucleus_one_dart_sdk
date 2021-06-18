const tenantJson =
    '{"ID":"A","CreatedOn":"2019-09-05T18:51:37.704127Z","Name":"B","CreatingUserName":"C","CreatingUserEmail":"D","CrmAccountId":"E","OrganizationID":"F","OrganizationName":"G","OrganizationSubscriptionRequired":true,"OrganizationSubscriptionExpiration":"2021-07-24T01:01:56Z","SearchIndexID":"H","BucketName":"I","Disabled":false,"IsMarkedForPurge":true,"PurgeDate":"0001-04-01T00:00:00Z","DocumentCount":0}';
const tenantCollectionJson = '{"Tenants":[$tenantJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
