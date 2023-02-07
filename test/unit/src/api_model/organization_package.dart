import 'organization.dart';

const organizationPackageJson =
    '{"Organization":$organizationJson,"UserID":"A","IsMember":true,"IsExpiringSoon":false,"Expiration":"0001-01-01T00:00:00Z","FreeUsers":0,"IsExpired":true}';
const organizationPackageCollectionJson =
    '{"OrganizationPackagesForCurrentUser":[$organizationPackageJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
