import 'document_content_package.dart';
import 'document_signature_session_form_field_package.dart';
import 'document_signature_session_signing_recipient.dart';

const documentSignatureSessionSigningRecipientPackageJson =
    '{"RequireAccessCode":false,"SigningRecipient":$documentSignatureSessionSigningRecipientJson,"FormFieldPackage":$documentSignatureSessionFormFieldPackageJson,"ServerDate":"2021-06-23T15:56:33.360404143Z","ContentPackage":$documentContentPackageJson}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
