import 'package:get_it/get_it.dart';

import '../api_model/document_package.dart' as api_mod;
import '../nucleus_one.dart';
import 'approval.dart';
import 'document.dart';
import 'document_package_field.dart';
import 'document_subscription_for_client.dart';
import 'project.dart';

class DocumentPackage with NucleusOneAppDependent {
  DocumentPackage._({
    NucleusOneApp? app,
    required this.projectMember,
    required this.projectAccessType,
    required this.document,
    required this.documentSubscription,
    required this.approval,
    required this.fields,
  }) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  factory DocumentPackage.fromApiModel(
    api_mod.DocumentPackage apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentPackage._(
      projectMember: ProjectMember.fromApiModel(apiModel.projectMember!),
      projectAccessType: apiModel.projectAccessType!,
      document: Document.fromApiModel(apiModel.document!, app: app),
      documentSubscription:
          DocumentSubscriptionForClient.fromApiModel(apiModel.documentSubscription!),
      approval: Approval.fromApiModel(apiModel.approval!, app: app),
      fields: apiModel.fields!.map((x) => DocumentPackageField.fromApiModel(x, app: app)).toList(),
    );
  }

  ProjectMember projectMember;

  String projectAccessType;

  Document document;

  DocumentSubscriptionForClient documentSubscription;

  Approval? approval;

  List<DocumentPackageField> fields;

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
