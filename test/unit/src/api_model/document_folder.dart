const documentFolderJson =
    '{"ID":"A","UniqueID":"B","ParentID":"C","AncestorIDs":["D"],"OrganizationID":"E","ProjectID":"F","ProjectName":"G","ProjectAccessType":"H","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserEmail":"I","CreatedByUserName":"J","CreatedByUserID":"K","ModifiedOn":"0001-01-01T00:00:00Z","ModifiedByUserEmail":"L","ModifiedByUserName":"M","ModifiedByUserID":"N","Name":"O","NameLower":"P","Depth":1,"AncestorAssignmentUserEmails":["Q"],"AssignmentUserEmails":["R"],"HexColor":"S"}';
const documentFolderCollectionJson =
    '{"DocumentFolders":[' + documentFolderJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
