const supportOrganizationTenantJson =
    '{"ID": "A","CreatedOn": "0001-01-01T00:00:01Z","Name": "B","CreatingUserName": "C","CreatingUserEmail": "D","CrmAccountId": "E","OrganizationID": "F","OrganizationName": "G","OrganizationSubscriptionRequired": false,"OrganizationSubscriptionExpiration": "0001-01-01T00:00:01Z","SearchIndexID": "H","BucketName": "I","Disabled": false,"IsMarkedForPurge": false,"PurgeDate": "0001-01-01T00:00:01Z","DocumentCount": 0}';
const supportOrganizationTenantCollectionJson =
    '{"Tenants":[' + supportOrganizationTenantJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
