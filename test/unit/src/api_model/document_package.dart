import 'document.dart';
import 'document_package_field.dart';

const documentSubscriptionJson =
    r'{"Subscribed":false,"Notify":false,"CreatedOn":"0001-01-01T00:00:00Z","DocumentID":"A","DocumentCreatedOn":"0001-01-01T00:00:00Z","DocumentName":"B","DocumentPageCount":0,"DocumentFileSize":1,"DocumentClassificationID":"C","DocumentClassificationName":"D","DocumentPreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentIsSigned":false}';
const approvalJson =
    '{"ID":"A","CreatedOn":"2021-06-04T16:49:04.317582Z","RoleID":"B","RoleName":"C","ProcessID":"D","ProcessName":"E","ProcessElementID":"F","ProcessElementName":"G","ParticipationType":"H","ApprovingTenantMemberIDs":{"0":false,"1":false,"2":false},"Result":"J","ItemType":"K","ItemID":"L","ItemCreatedOn":"2021-06-04T16:49:05.317582Z","ItemCreatedByUserID":"M","ItemCreatedByUserEmail":"N","ItemCreatedByUserName":"O","ItemCompletedOn":"0001-01-01T00:00:01Z","ItemCompletedByUserID":"P","ItemCompletedByUserEmail":"Q","ItemCompletedByUserName":"R","ItemName":"S","ItemDescription":"T","DocumentName":"U","DocumentCreatedOn":"2021-06-04T16:49:06.317582Z","DocumentCreatedByUserID":"V","DocumentCreatedByUserEmail":"W","DocumentCreatedByUserName":"X","DocumentPageCount":0,"DocumentFileSize":1,"DocumentClassificationID":"Y","DocumentClassificationName":"Z","DocumentPreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentIsSigned":false,"TaskDueOn":"0001-01-01T00:00:01Z","ThumbnailUrl":"AA"}';
const documentPackageProjectMemberJson =
    r'{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","OrganizationMemberID":"B","OrganizationMemberIsAdmin":false,"OrganizationID":"C","OrganizationName":"D","ProjectID":"E","ProjectName":"F","ProjectIsDisabled":false,"ProjectAccessType":"G","UserID":"H","UserName":"I","UserNameLower":"i","UserEmail":"J","Disabled":false,"IsReadOnly":false,"IsAdmin":true}';
const documentPackageJson =
    '{"ProjectMember":$documentPackageProjectMemberJson,"ProjectAccessType":"A","Document":$documentJson,"DocumentSubscription":$documentSubscriptionJson,"Approval":$approvalJson,"Fields":[$documentPackageFieldJson]}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
