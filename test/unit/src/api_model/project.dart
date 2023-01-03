const projectJson =
    '{"ID":"A","CreatedOn":"2019-08-27T15:21:23.90425Z","OrganizationID":"B","OrganizationName":"C","OrganizationNameLower":"D","OrganizationSubscriptionRequired":true,"OrganizationSubscriptionFreeUsers":0,"OrganizationSubscriptionExpiration":"2021-06-24T01:01:56Z","BucketName":"E","Name":"F","NameLower":"G","CreatingUserID":"H","CreatingUserName":"I","CreatingUserEmail":"J","CrmAccountId":"K","Disabled":false,"IsMarkedForPurge":true,"PurgeMarkedOn":"0001-01-01T00:00:00Z","PurgeMarkedByUserID":"L","PurgeMarkedByUserName":"M","PurgeMarkedByUserEmail":"N"}';
const projectMemberJson =
    '{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","OrganizationMemberID":"B","OrganizationMemberIsAdmin":true,"OrganizationID":"C","OrganizationName":"D","ProjectID":"E","ProjectName":"F","ProjectIsDisabled":false,"ProjectAccessType":"G","UserID":"H","UserName":"I","UserNameLower":"J","UserEmail":"K","Disabled":false,"IsReadOnly":false,"IsAdmin":true}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
