import '../api_model/document_signature_session_recipient_form_field.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentSignatureSessionRecipientFormField extends Entity with NucleusOneAppDependent {
  DocumentSignatureSessionRecipientFormField._({
    NucleusOneApp? app,
    required this.id,
    required this.documentSignatureFormFieldID,
    required this.documentSignatureSessionRecipientID,
    required this.documentSignatureSessionRecipientRank,
    required this.isComplete,
    required this.type,
    required this.pageIndex,
    required this.x,
    required this.y,
    required this.value,
    required this.placementRank,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentSignatureSessionRecipientFormField.fromApiModel(
    api_mod.DocumentSignatureSessionRecipientFormField apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionRecipientFormField._(
      app: app,
      id: apiModel.id!,
      documentSignatureFormFieldID: apiModel.documentSignatureFormFieldID!,
      documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
      documentSignatureSessionRecipientRank: apiModel.documentSignatureSessionRecipientRank!,
      isComplete: apiModel.isComplete!,
      type: apiModel.type!,
      pageIndex: apiModel.pageIndex!,
      x: apiModel.x!,
      y: apiModel.y!,
      value: apiModel.value!,
      placementRank: apiModel.placementRank!,
    );
  }

  String id;

  String documentSignatureFormFieldID;

  String documentSignatureSessionRecipientID;

  int documentSignatureSessionRecipientRank;

  bool isComplete;

  String type;

  int pageIndex;

  double x;

  double y;

  String value;

  int placementRank;

  @override
  api_mod.DocumentSignatureSessionRecipientFormField toApiModel() {
    return api_mod.DocumentSignatureSessionRecipientFormField()
      ..id = id
      ..documentSignatureFormFieldID = documentSignatureFormFieldID
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..documentSignatureSessionRecipientRank = documentSignatureSessionRecipientRank
      ..isComplete = isComplete
      ..type = type
      ..pageIndex = pageIndex
      ..x = x
      ..y = y
      ..value = value
      ..placementRank = placementRank;
  }
}

class DocumentSignatureSessionRecipientFormFieldCollection extends EntityCollection<
    DocumentSignatureSessionRecipientFormField,
    api_mod.DocumentSignatureSessionRecipientFormFieldCollection> {
  DocumentSignatureSessionRecipientFormFieldCollection({
    NucleusOneApp? app,
    List<DocumentSignatureSessionRecipientFormField>? items,
  }) : super(app: app, items: items);

  factory DocumentSignatureSessionRecipientFormFieldCollection.fromApiModel(
    api_mod.DocumentSignatureSessionRecipientFormFieldCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentSignatureSessionRecipientFormFieldCollection(
        app: app,
        items: apiModel.items
            .map((x) => DocumentSignatureSessionRecipientFormField.fromApiModel(x, app: app))
            .toList());
  }

  @override
  api_mod.DocumentSignatureSessionRecipientFormFieldCollection toApiModel() {
    return api_mod.DocumentSignatureSessionRecipientFormFieldCollection()
      ..items = items.map((x) => x.toApiModel()).toList();
  }
}
