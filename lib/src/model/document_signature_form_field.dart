import 'package:get_it/get_it.dart';

import '../api_model/document_signature_form_field.dart' as api_mod;
import '../common/model.dart';
import '../common/string.dart';
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
      required this.id,
      required this.createdOn,
      required this.type,
      required this.pageIndex,
      required this.documentSignatureSessionRecipientID,
      required this.x,
      required this.y}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentSignatureFormField.createNew({
    String? id,
    String createdOn = '',
    required String type,
    required int pageIndex,
    required String documentSignatureSessionRecipientID,
    required double x,
    required double y,
  }) {
    if (isNullOrEmpty(id)) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return DocumentSignatureFormField._(
      id: id!,
      createdOn: createdOn,
      type: type,
      pageIndex: pageIndex,
      documentSignatureSessionRecipientID: documentSignatureSessionRecipientID,
      x: x,
      y: y,
    );
  }

  factory DocumentSignatureFormField.fromApiModel(api_mod.DocumentSignatureFormField apiModel) {
    return DocumentSignatureFormField._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        type: apiModel.type!,
        pageIndex: apiModel.pageIndex!,
        documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
        x: apiModel.x!,
        y: apiModel.y!);
  }

  String id;

  String createdOn;

  String type;

  int pageIndex;

  String documentSignatureSessionRecipientID;

  double x;

  double y;

  api_mod.DocumentSignatureFormField toApiModel() {
    return api_mod.DocumentSignatureFormField()
      ..id = id
      ..createdOn = createdOn.isEmpty ? null : createdOn
      ..type = type
      ..pageIndex = pageIndex
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..x = x
      ..y = y;
  }
}
