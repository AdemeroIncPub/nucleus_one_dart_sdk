const organizationForClientJson =
    '{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","Name":"B","CreatingUserID":"C","CreatingUserName":"D","CreatingUserEmail":"E","CrmAccountId":"F","SubscriptionRequired":true,"SubscriptionFreeUsers":0,"SubscriptionExpiration":"G","SearchIndexID":"H","BucketName":"I","Disabled":true,"IsMarkedForPurge":true,"PurgeDate":"J","UniqueNonReadOnlyOrganizationMembers":1,"UniqueReadOnlyOrganizationMembers":2,"UniqueFreeOrganizationMembers":3,"UniqueBillableOrganizationMembers":4}';
const organizationForClientCollectionJson =
    '{"Organizations":[$organizationForClientJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
