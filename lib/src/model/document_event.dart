import '../api_model/document_event.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

class DocumentEvent extends Entity with NucleusOneAppDependent {
  DocumentEvent._({
    NucleusOneApp? app,
    required this.id,
    required this.documentID,
    required this.createdOn,
    required this.createdByUserID,
    required this.createdByUserName,
    required this.createdByUserEmail,
    required this.type,
    required this.detailJson,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  factory DocumentEvent.fromApiModel(
    api_mod.DocumentEvent apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentEvent._(
      app: app,
      id: apiModel.id!,
      documentID: apiModel.documentID!,
      createdOn: apiModel.createdOn!,
      createdByUserID: apiModel.createdByUserID!,
      createdByUserName: apiModel.createdByUserName!,
      createdByUserEmail: apiModel.createdByUserEmail!,
      type: apiModel.type!,
      detailJson: apiModel.detailJson!,
    );
  }

  String id;

  String documentID;

  String createdOn;

  String createdByUserID;

  String createdByUserName;

  String createdByUserEmail;

  String type;

  String detailJson;

  @override
  api_mod.DocumentEvent toApiModel() {
    return api_mod.DocumentEvent()
      ..id = id
      ..documentID = documentID
      ..createdOn = createdOn
      ..createdByUserID = createdByUserID
      ..createdByUserName = createdByUserName
      ..createdByUserEmail = createdByUserEmail
      ..type = type
      ..detailJson = detailJson;
  }
}

class DocumentEventCollection
    extends EntityCollection<DocumentEvent, api_mod.DocumentEventCollection> {
  DocumentEventCollection({
    NucleusOneApp? app,
    List<DocumentEvent>? items,
  }) : super(app: app, items: items);

  factory DocumentEventCollection.fromApiModel(
    api_mod.DocumentEventCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentEventCollection(
        items: apiModel.documentEvents?.map((x) => DocumentEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentEventCollection toApiModel() {
    return api_mod.DocumentEventCollection()
      ..documentEvents = items.map((x) => x.toApiModel()).toList();
  }
}
