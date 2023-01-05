import 'document.dart';

const taskJson =
    '{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","ModifiedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"B","CreatedByUserEmail":"C","CreatedByUserName":"D","CompletedOn":"0001-01-01T00:00:00Z","CompletedByUserID":"E","CompletedByUserEmail":"F","CompletedByUserName":"G","ModifiedByUserID":"H","ModifiedByUserEmail":"I","ModifiedByUserName":"J","Revision":0,"Result":"K","Name":"L","NameLower": "M", "Description": "N","DescriptionHtml": "O","DescriptionRichTextJson": "P","RoleID": "Q","RoleName": "R","RoleNameLower": "S","DueOn": "0001-01-01T00:00:00Z","DueOnModifiedOn": "0001-01-01T00:00:00Z","PrimaryDocument":$documentJson,"OtherDocuments": [$documentJson],"ParentTaskID": "T","ProcessID": "U","ProcessName": "V","ProcessNameLower": "W","ProcessElementID": "X","ProcessElementName": "Y","ProcessElementNameLower": "Z","Reminder_7_Day": "0001-01-01T00:00:00Z","Reminder_3_Day": "0001-01-01T00:00:00Z","Reminder_1_Day": "0001-01-01T00:00:00Z", "OrganizationID": "Z", "ProjectID": "AA", "ProjectName": "AB", "ProjectAccessType": "AC", "ProjectAccessType": "AD", "AssignmentUserEmail": "AE", "AssignmentUserEmail": "AF", "AssignmentUserName": "AG", "AssignmentUserNameLower": "AF"}';
const taskCollectionJson = '{"Tasks":[$taskJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
