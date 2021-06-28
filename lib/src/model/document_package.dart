import 'package:get_it/get_it.dart';

import '../api_model/document_package.dart' as api_mod;
import '../model/document_package_field.dart';
import '../model/document.dart';
import '../model/approval.dart';
import '../model/document_subscription.dart';
import '../nucleus_one.dart';

class DocumentPackage with NucleusOneAppDependent {
  DocumentPackage._(
      {NucleusOneAppInternal? app,
      required this.document,
      required this.documentSubscription,
      this.approval,
      required this.classificationField,
      required this.indexFields}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentPackage.fromApiModel(api_mod.DocumentPackage apiModel) {
    Approval? approval;
    if (apiModel.approval != null) {
      approval = Approval.fromApiModel(apiModel.approval!);
    }
    return DocumentPackage._(
        document: Document.fromApiModel(apiModel.document!),
        documentSubscription: DocumentSubscription.fromApiModel(apiModel.documentSubscription!),
        approval: approval,
        classificationField: DocumentPackageField.fromApiModel(apiModel.classificationField!),
        indexFields:
            apiModel.indexFields!.map((x) => DocumentPackageField.fromApiModel(x)).toList());
  }

  Document document;

  DocumentSubscription documentSubscription;

  Approval? approval;

  DocumentPackageField classificationField;

  List<DocumentPackageField> indexFields;

  api_mod.DocumentPackage toApiModel() {
    return api_mod.DocumentPackage()
      ..document = document.toApiModel()
      ..documentSubscription = documentSubscription.toApiModel()
      ..approval = approval?.toApiModel()
      ..classificationField = classificationField.toApiModel()
      ..indexFields = indexFields.map((x) => (x).toApiModel()).toList();
  }
}
