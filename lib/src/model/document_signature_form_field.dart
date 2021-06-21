import 'package:get_it/get_it.dart';

import '../api_model/document_signature_form_field.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureFormFieldCollection extends EntityCollection<DocumentSignatureFormField,
    api_mod.DocumentSignatureFormFieldCollection> {
  DocumentSignatureFormFieldCollection({
    NucleusOneAppInternal? app,
    List<DocumentSignatureFormField>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureFormFieldCollection.fromApiModel(
      api_mod.DocumentSignatureFormFieldCollection apiModel) {
    return DocumentSignatureFormFieldCollection(
        items: apiModel.items.map((x) => DocumentSignatureFormField.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentSignatureFormFieldCollection toApiModel() {
    return api_mod.DocumentSignatureFormFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureFormField with NucleusOneAppDependent {
  DocumentSignatureFormField._(
      {NucleusOneAppInternal? app,
      required this.type,
      required this.label,
      required this.widthPercent,
      required this.sortRank,
      required this.id,
      required this.documentSignatureSessionRecipientID,
      required this.x,
      required this.y,
      required this.pageIndex}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureFormField.createNew({
    required String type,
    required String label,
    required double widthPercent,
    required int sortRank,
    required String id,
    required String documentSignatureSessionRecipientID,
    required double x,
    required double y,
    required int pageIndex,
  }) {
    return DocumentSignatureFormField._(
      type: type,
      label: label,
      widthPercent: widthPercent,
      sortRank: sortRank,
      id: id,
      documentSignatureSessionRecipientID: documentSignatureSessionRecipientID,
      x: x,
      y: y,
      pageIndex: pageIndex,
    );
  }

  factory DocumentSignatureFormField.fromApiModel(api_mod.DocumentSignatureFormField apiModel) {
    return DocumentSignatureFormField._(
        type: apiModel.type!,
        label: apiModel.label!,
        widthPercent: apiModel.widthPercent!,
        sortRank: apiModel.sortRank!,
        id: apiModel.id!,
        documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
        x: apiModel.x!,
        y: apiModel.y!,
        pageIndex: apiModel.pageIndex!);
  }

  String type;

  String label;

  double widthPercent;

  int sortRank;

  String id;

  String documentSignatureSessionRecipientID;

  double x;

  double y;

  int pageIndex;

  api_mod.DocumentSignatureFormField toApiModel() {
    return api_mod.DocumentSignatureFormField()
      ..type = type
      ..label = label
      ..widthPercent = widthPercent
      ..sortRank = sortRank
      ..id = id
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..x = x
      ..y = y
      ..pageIndex = pageIndex;
  }
}
