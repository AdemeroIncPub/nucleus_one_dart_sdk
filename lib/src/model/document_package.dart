import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/model/classification_field.dart';
import 'package:nucleus_one_dart_sdk/src/model/document.dart';
import 'package:nucleus_one_dart_sdk/src/model/approval.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_subscription.dart';

import '../api_model/document_package.dart' as api_mod;
import '../nucleus_one.dart';
import 'index_field.dart';

class DocumentPackage with NucleusOneAppDependent {
  DocumentPackage._(
      {NucleusOneAppInternal? app,
      required this.document,
      required this.documentSubscription,
      required this.approval,
      required this.classificationField,
      required this.indexFields}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentPackage.fromApiModel(api_mod.DocumentPackage apiModel) {
    return DocumentPackage._(
        document: Document.fromApiModel(apiModel.document!),
        documentSubscription: DocumentSubscription.fromApiModel(apiModel.documentSubscription!),
        approval: Approval.fromApiModel(apiModel.approval!),
        classificationField: ClassificationField.fromApiModel(apiModel.classificationField!),
        indexFields: apiModel.indexFields!.map((x) => IndexField.fromApiModel(x)).toList());
  }

  Document document;

  DocumentSubscription documentSubscription;

  Approval approval;

  ClassificationField classificationField;

  List<IndexField> indexFields;

  api_mod.DocumentPackage toApiModel() {
    return api_mod.DocumentPackage()
      ..document = document.toApiModel()
      ..documentSubscription = documentSubscription.toApiModel()
      ..approval = approval.toApiModel()
      ..classificationField = classificationField.toApiModel()
      ..indexFields = indexFields.map((x) => (x).toApiModel()).toList();
  }
}
