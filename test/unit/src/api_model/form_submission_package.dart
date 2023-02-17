import 'form_submission_field.dart';

const formSubmissionPackageJson =
    '{"TenantID":"A","FormTemplateID":"B","FormSubmissionFields":[$formSubmissionFieldJson]}';
const formSubmissionPackageCollectionJson = '[$formSubmissionPackageJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
