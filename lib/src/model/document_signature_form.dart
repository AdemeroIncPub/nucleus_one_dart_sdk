import 'package:get_it/get_it.dart';

import '../api_model/document_signature_form.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureFormCollection
    extends EntityCollection<DocumentSignatureForm, api_mod.DocumentSignatureFormCollection> {
  DocumentSignatureFormCollection({
    NucleusOneAppInternal? app,
    List<DocumentSignatureForm>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureFormCollection.fromApiModel(
      api_mod.DocumentSignatureFormCollection apiModel) {
    return DocumentSignatureFormCollection(
        items: apiModel.items.map((x) => DocumentSignatureForm.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentSignatureFormCollection toApiModel() {
    return api_mod.DocumentSignatureFormCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureForm with NucleusOneAppDependent {
  DocumentSignatureForm._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.signatureFormTemplateID,
      required this.createdOn,
      required this.tenantID,
      required this.documentID,
      required this.documentClassificationID,
      required this.documentClassificationName,
      required this.documentClassificationNameLower,
      required this.documentName,
      required this.documentNameLower,
      required this.hasFormFields,
      required this.totalFormFields,
      required this.lastViewedPageIndex}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureForm.fromApiModel(api_mod.DocumentSignatureForm apiModel) {
    return DocumentSignatureForm._(
        id: apiModel.id!,
        signatureFormTemplateID: apiModel.signatureFormTemplateID!,
        createdOn: apiModel.createdOn!,
        tenantID: apiModel.tenantID!,
        documentID: apiModel.documentID!,
        documentClassificationID: apiModel.documentClassificationID!,
        documentClassificationName: apiModel.documentClassificationName!,
        documentClassificationNameLower: apiModel.documentClassificationNameLower!,
        documentName: apiModel.documentName!,
        documentNameLower: apiModel.documentNameLower!,
        hasFormFields: apiModel.hasFormFields!,
        totalFormFields: apiModel.totalFormFields!,
        lastViewedPageIndex: apiModel.lastViewedPageIndex!);
  }

  String id;

  String signatureFormTemplateID;

  String createdOn;

  String tenantID;

  String documentID;

  String documentClassificationID;

  String documentClassificationName;

  String documentClassificationNameLower;

  String documentName;

  String documentNameLower;

  bool hasFormFields;

  int totalFormFields;

  int lastViewedPageIndex;

  api_mod.DocumentSignatureForm toApiModel() {
    return api_mod.DocumentSignatureForm()
      ..id = id
      ..signatureFormTemplateID = signatureFormTemplateID
      ..createdOn = createdOn
      ..tenantID = tenantID
      ..documentID = documentID
      ..documentClassificationID = documentClassificationID
      ..documentClassificationName = documentClassificationName
      ..documentClassificationNameLower = documentClassificationNameLower
      ..documentName = documentName
      ..documentNameLower = documentNameLower
      ..hasFormFields = hasFormFields
      ..totalFormFields = totalFormFields
      ..lastViewedPageIndex = lastViewedPageIndex;
  }
}
