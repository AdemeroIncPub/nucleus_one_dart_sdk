const supportOrganizationJson =
    '{"ID": "A","CreatedOn": "0001-01-01T00:00:01Z","Name": "B","CreatingUserName": "C","CreatingUserEmail": "D","SubscriptionRequired": false,"SubscriptionFreeUsers": 0,"SubscriptionExpiration": "0001-01-01T00:00:01Z","UniqueNonReadOnlyTenantMembers": 1,"UniqueReadOnlyTenantMembers": 2}';
const supportOrganizationCollectionJson =
    '{"Organizations":[$supportOrganizationJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
