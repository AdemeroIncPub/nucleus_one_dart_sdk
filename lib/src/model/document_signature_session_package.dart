import '../api_model/document_signature_session_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'document_signature_session.dart';
import 'document_signature_session_recipient.dart';

class DocumentSignatureSessionPackage extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionPackage._({
    NucleusOneApp? app,
    required this.session,
    required this.recipients,
    required this.beginSession,
    required this.resetSession,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionPackage.fromApiModel(
    api_mod.DocumentSignatureSessionPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionPackage._(
      app: app,
      session: DocumentSignatureSession.fromApiModel(apiModel.session!, app: app),
      recipients: apiModel.recipients!
          .map((x) => DocumentSignatureSessionRecipient.fromApiModel(x, app: app))
          .toList(),
      beginSession: apiModel.beginSession!,
      resetSession: apiModel.resetSession!,
    );
  }

  DocumentSignatureSession session;

  List<DocumentSignatureSessionRecipient> recipients;

  bool beginSession;

  bool resetSession;

  @override
  api_mod.DocumentSignatureSessionPackage toApiModel() {
    return api_mod.DocumentSignatureSessionPackage()
      ..session = session.toApiModel()
      ..recipients = recipients.map((x) => x.toApiModel()).toList()
      ..beginSession = beginSession
      ..resetSession = resetSession;
  }
}

class DocumentSignatureSessionPackageCollection extends EntityCollection<
    DocumentSignatureSessionPackage, api_mod.DocumentSignatureSessionPackageCollection> {
  DocumentSignatureSessionPackageCollection({
    NucleusOneApp? app,
    List<DocumentSignatureSessionPackage>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureSessionPackageCollection.fromApiModel(
    api_mod.DocumentSignatureSessionPackageCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionPackageCollection(
        app: app,
        items: apiModel.items
            .map((x) => DocumentSignatureSessionPackage.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.DocumentSignatureSessionPackageCollection toApiModel() {
    return api_mod.DocumentSignatureSessionPackageCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}
