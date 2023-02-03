const organizationForClientJson =
    '{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","Name":"B","CreatedByUserID":"C","CreatedByUserName":"D","CreatedByUserEmail":"E","SubscriptionRequired":true,"SubscriptionFreeUsers":1,"SubscriptionExpiration":"H","UniqueNonReadOnlyOrganizationMembers":2,"UniqueReadOnlyOrganizationMembers":3,"UniqueFreeOrganizationMembers":4,"UniqueBillableOrganizationMembers":5}';
const organizationForClientCollectionFromArrayJson = '[$organizationForClientJson]';
const organizationForClientCollectionJson =
    '{"Organizations":$organizationForClientCollectionFromArrayJson,"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
