const organizationJson =
    '{"ID":"A","CreatedOn":"2021-05-25T13:21:29.111348Z","BucketName":"C","Name":"D","NameLower":"E","CreatingUserID":"F","CreatingUserName":"G","CreatingUserEmail":"H","CrmAccountId":"I","CrmLeadId":"J","CrmContactId":"K","CrmDealId":"L","Disabled":true,"IsMarkedForPurge":true,"PurgeMarkedOn":"M","PurgeMarkedByUserID":"N","PurgeMarkedByUserName":"O","PurgeMarkedByUserEmail":"P","SubscriptionRequired":true,"SubscriptionFreeUsers":0,"SubscriptionExpiration":"0001-01-01T00:00:00Z","SearchIndexRemovedForCostSavings":true,"SearchIndexRestoredAtLeastOnce":true}';
//'{"ID":"A","CreatedOn":"2021-05-25T13:21:29.111348Z","Disabled":true,"Name":"B","NameLower":"C","CreatingUserID":"D","CreatingUserName":"E","CreatingUserEmail":"F","CrmLeadId":"G","CrmAccountId":"H","CrmContactId":"I","CrmDealId":"J","SubscriptionRequired":false,"SubscriptionFreeUsers":0,"SubscriptionExpiration":"0001-01-01T00:00:00Z","MaxTenants":1}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
