import '../api_model/document_package.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';
import 'approval.dart';
import 'document.dart';
import 'document_package_field.dart';
import 'document_subscription_for_client.dart';
import 'project.dart';

class DocumentPackage extends Entity with NucleusOneAppDependent {
  DocumentPackage._({
    NucleusOneApp? app,
    required this.projectMember,
    required this.projectAccessType,
    required this.document,
    required this.documentSubscription,
    this.approval,
    required this.fields,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory DocumentPackage.fromApiModel(
    api_mod.DocumentPackage apiModel, {
    NucleusOneApp? app,
  }) {
    final approval =
        (apiModel.approval == null) ? null : Approval.fromApiModel(apiModel.approval!, app: app);
    return DocumentPackage._(
      app: app,
      projectMember: ProjectMember.fromApiModel(apiModel.projectMember!, app: app),
      projectAccessType: apiModel.projectAccessType!,
      document: Document.fromApiModel(apiModel.document!, app: app),
      documentSubscription:
          DocumentSubscriptionForClient.fromApiModel(apiModel.documentSubscription!, app: app),
      approval: approval,
      fields: apiModel.fields!.map((x) => DocumentPackageField.fromApiModel(x, app: app)).toList(),
    );
  }

  ProjectMember projectMember;

  String projectAccessType;

  Document document;

  DocumentSubscriptionForClient documentSubscription;

  Approval? approval;

  List<DocumentPackageField> fields;

  @override
  api_mod.DocumentPackage toApiModel() {
    return api_mod.DocumentPackage()
      ..projectMember = projectMember.toApiModel()
      ..projectAccessType = projectAccessType
      ..document = document.toApiModel()
      ..documentSubscription = documentSubscription.toApiModel()
      ..approval = approval?.toApiModel()
      ..fields = fields.map((x) => (x).toApiModel()).toList();
  }
}
