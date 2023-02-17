import 'document_signature_session.dart';
import 'document_signature_session_recipient.dart';

const documentSignatureSessionPackageJson =
    '{"Session":$documentSignatureSessionJson,"Recipients":[$documentSignatureSessionRecipientJson],"BeginSession":true,"ResetSession":false}';
const documentSignatureSessionPackageCollectionJson = '[$documentSignatureSessionPackageJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
