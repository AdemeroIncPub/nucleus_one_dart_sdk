import 'approval.dart';
import 'document.dart';
import 'document_package_field.dart';
import 'document_subscription_for_client.dart';

const documentPackageProjectMemberJson =
    r'{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","OrganizationMemberID":"B","OrganizationMemberIsAdmin":false,"OrganizationID":"C","OrganizationName":"D","ProjectID":"E","ProjectName":"F","ProjectIsDisabled":false,"ProjectAccessType":"G","UserID":"H","UserName":"I","UserNameLower":"i","UserEmail":"J","Disabled":false,"IsReadOnly":false,"IsAdmin":true}';
const documentPackageJson =
    '{"ProjectMember":$documentPackageProjectMemberJson,"ProjectAccessType":"A","Document":$documentJson,"DocumentSubscription":$documentSubscriptionForClientJson,"Approval":$approvalJson,"Fields":[$documentPackageFieldJson]}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
