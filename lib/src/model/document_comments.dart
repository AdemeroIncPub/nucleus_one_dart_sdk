import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../api_model/document_comments.dart' as api_mod;
import '../nucleus_one.dart';
import 'document_event.dart';

class DocumentComments with NucleusOneAppDependent implements IModelPagingCursor2 {
  DocumentComments._(
      {NucleusOneAppInternal? app,
      required this.documentEvents,
      required this.cursor,
      required this.reverseCursor,
      required this.pageSize}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentComments.fromApiModel(api_mod.DocumentComments apiModel) {
    return DocumentComments._(
        documentEvents: apiModel.documentEvents!.map((x) => DocumentEvent.fromApiModel(x)).toList(),
        cursor: apiModel.cursor!,
        reverseCursor: apiModel.reverseCursor!,
        pageSize: apiModel.pageSize!);
  }

  List<DocumentEvent> documentEvents;

  @override
  String cursor;

  @override
  String reverseCursor;

  @override
  int pageSize;

  api_mod.DocumentComments toApiModel() {
    return api_mod.DocumentComments()
      ..documentEvents = documentEvents.map((x) => x.toApiModel()).toList()
      ..cursor = cursor
      ..reverseCursor = reverseCursor
      ..pageSize = pageSize;
  }
}