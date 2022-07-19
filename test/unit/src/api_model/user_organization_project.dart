const userOrganizationProjectJson =
    r'{"UserEmail":"A","OrganizationID":"B","OrganizationName":"C","ProjectID":"D","ProjectName":"E","ProjectAccessType":"F","ProjectIsDisabled":false,"AssignmentTypes":["G"],"HasAssignment":false}';
const userOrganizationProjectCollectionJson =
    '{"UserOrganizationProjects":[$userOrganizationProjectJson],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
