import 'organization.dart';
import 'organization_member.dart';

const organizationMembershipPackageJson =
    '{"Organization":$organizationJson,"OrganizationMember":$organizationMemberJson,"UserID":"A","IsAdmin":true,"IsExpiringSoon":false,"Expiration":"0001-01-01T00:00:00Z","FreeUsers":1,"IsExpired":true}';
const organizationMembershipPackageCollectionJson =
    '{"OrganizationMembershipPackages":[$organizationMembershipPackageJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
