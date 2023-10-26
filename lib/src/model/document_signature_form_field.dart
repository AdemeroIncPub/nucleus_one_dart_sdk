import '../api_model/document_signature_form_field.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../common/string.dart';
import '../nucleus_one.dart';

class DocumentSignatureFormFieldCollection extends EntityCollection<DocumentSignatureFormField,
    api_mod.DocumentSignatureFormFieldCollection> {
  DocumentSignatureFormFieldCollection({
    NucleusOneApp? app,
    List<DocumentSignatureFormField>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureFormFieldCollection.fromApiModel(
    api_mod.DocumentSignatureFormFieldCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureFormFieldCollection(
      app: app,
      items:
          apiModel.items.map((x) => DocumentSignatureFormField.fromApiModel(x, app: app)).toList(),
    );
  }

  @override
  api_mod.DocumentSignatureFormFieldCollection toApiModel() {
    return api_mod.DocumentSignatureFormFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}

class DocumentSignatureFormField extends Entity with NucleusOneAppDependent {
  DocumentSignatureFormField._({
    NucleusOneApp? app,
    required this.id,
    required this.createdOn,
    required this.type,
    required this.pageIndex,
    required this.documentSignatureSessionRecipientID,
    required this.x,
    required this.y,
  }) {
    this.app = getEffectiveNucleusOneApp(app);
  }

  factory DocumentSignatureFormField.createNew({
    String? id,
    String createdOn = '',
    required String type,
    required int pageIndex,
    required String documentSignatureSessionRecipientID,
    required double x,
    required double y,
    NucleusOneApp? app,
  }) {
    if (isNullOrEmpty(id)) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }

    return DocumentSignatureFormField._(
      app: app,
      id: id!,
      createdOn: createdOn,
      type: type,
      pageIndex: pageIndex,
      documentSignatureSessionRecipientID: documentSignatureSessionRecipientID,
      x: x,
      y: y,
    );
  }

  factory DocumentSignatureFormField.fromApiModel(
    api_mod.DocumentSignatureFormField apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureFormField._(
      app: app,
      id: apiModel.id!,
      createdOn: apiModel.createdOn!,
      type: apiModel.type!,
      pageIndex: apiModel.pageIndex!,
      documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
      x: apiModel.x!,
      y: apiModel.y!,
    );
  }

  String id;

  String createdOn;

  String type;

  int pageIndex;

  String documentSignatureSessionRecipientID;

  double x;

  double y;

  @override
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
