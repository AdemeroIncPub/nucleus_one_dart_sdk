import '../api_model/document_signature_session_signing_recipient_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'document_content_package.dart';
import 'document_signature_session_form_field_package.dart';
import 'document_signature_session_signing_recipient.dart';

class DocumentSignatureSessionSigningRecipientPackage extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionSigningRecipientPackage._({
    NucleusOneApp? app,
    required this.requireAccessCode,
    required this.signingRecipient,
    required this.formFieldPackage,
    required this.serverDate,
    required this.contentPackage,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionSigningRecipientPackage.fromApiModel(
    api_mod.DocumentSignatureSessionSigningRecipientPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionSigningRecipientPackage._(
      app: app,
      requireAccessCode: apiModel.requireAccessCode!,
      signingRecipient: DocumentSignatureSessionSigningRecipient.fromApiModel(
          apiModel.signingRecipient!,
          app: app),
      formFieldPackage: DocumentSignatureSessionFormFieldPackage.fromApiModel(
          apiModel.formFieldPackage!,
          app: app),
      serverDate: apiModel.serverDate!,
      contentPackage: DocumentContentPackage.fromApiModel(
        apiModel.contentPackage!,
      ),
    );
  }

  bool requireAccessCode;

  DocumentSignatureSessionSigningRecipient signingRecipient;

  DocumentSignatureSessionFormFieldPackage formFieldPackage;

  String serverDate;

  DocumentContentPackage contentPackage;

  @override
  api_mod.DocumentSignatureSessionSigningRecipientPackage toApiModel() {
    return api_mod.DocumentSignatureSessionSigningRecipientPackage()
      ..requireAccessCode = requireAccessCode
      ..signingRecipient = signingRecipient.toApiModel()
      ..formFieldPackage = formFieldPackage.toApiModel()
      ..serverDate = serverDate
      ..contentPackage = contentPackage.toApiModel();
  }
}
