import '../common/model.dart';

import '../api_model/document_comment.dart' as api_mod;
import '../nucleus_one.dart';
import 'document_event.dart';

class DocumentCommentCollection
    extends EntityCollection<DocumentEvent, api_mod.DocumentCommentCollection> {
  DocumentCommentCollection({
    NucleusOneApp? app,
    List<DocumentEvent>? items,
  }) : super(app: app, items: items);

  factory DocumentCommentCollection.fromApiModel(
    api_mod.DocumentCommentCollection apiModel, {
    NucleusOneApp? app,
  }) {
    return DocumentCommentCollection(
        items: apiModel.documentEvents?.map((x) => DocumentEvent.fromApiModel(x)).toList());
  }

  @override
  api_mod.DocumentCommentCollection toApiModel() {
    return api_mod.DocumentCommentCollection()
      ..documentEvents = items.map((x) => x.toApiModel()).toList();
  }
}
