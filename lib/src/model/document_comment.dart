import '../common/model.dart';

import '../nucleus_one.dart';
import 'document_event.dart';

class DocumentCommentCollection extends EntityCollection<DocumentEvent> {
  DocumentCommentCollection({
    NucleusOneAppInternal? app,
    List<DocumentEvent>? items,
  }) : super(app: app, items: items);

  // factory DocumentCommentCollection.fromApiModel(api_mod.DocumentCommentCollection apiModel) {
  //   return DocumentCommentCollection(
  //       documentEvents: apiModel.documentEvents!.map((x) => DocumentEvent.fromApiModel(x)).toList(),
  //       cursor: apiModel.cursor!,
  //       reverseCursor: apiModel.reverseCursor!,
  //       pageSize: apiModel.pageSize!);
  // }

  // List<DocumentEvent> documentEvents;

  // @override
  // String cursor;

  // @override
  // String reverseCursor;

  // @override
  // int pageSize;

  // api_mod.DocumentCommentCollection toApiModel() {
  //   return api_mod.DocumentCommentCollection()
  //     ..documentEvents = documentEvents.map((x) => x.toApiModel()).toList()
  //     ..cursor = cursor
  //     ..reverseCursor = reverseCursor
  //     ..pageSize = pageSize;
  // }
}
