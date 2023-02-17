import '../api_model/document_signature_session_signing_recipient.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureSessionSigningRecipient extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipient._({
    NucleusOneApp? app,
    required this.email,
    required this.fullName,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionSigningRecipient.fromApiModel(
    api_mod.DocumentSignatureSessionSigningRecipient apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionSigningRecipient._(
      app: app,
      email: apiModel.email!,
      fullName: apiModel.fullName!,
    );
  }

  String email;

  String fullName;

  @override
  api_mod.DocumentSignatureSessionSigningRecipient toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipient()
      ..email = email
      ..fullName = fullName;
  }
}
