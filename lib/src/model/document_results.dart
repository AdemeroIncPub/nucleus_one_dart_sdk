import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../api_model/document_results.dart' as api_model;
import '../nucleus_one.dart';
import 'document.dart';

class DocumentResults with NucleusOneAppDependent implements IModelPagingCursor {
  DocumentResults._(
      {NucleusOneAppInternal? app,
      required this.documents,
      required this.cursor,
      required this.pageSize}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory DocumentResults.fromApiModel(api_model.DocumentResults apiModel) {
    return DocumentResults._(
        documents: apiModel.documents!.map((x) => Document.fromApiModel(x)).toList(),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!);
  }

  List<Document> documents;

  @override
  String cursor;

  @override
  int pageSize;

  api_model.DocumentResults toApiModel() {
    return api_model.DocumentResults()
      ..documents = documents.map((x) => x.toApiModel()).toList()
      ..cursor = cursor
      ..pageSize = pageSize;
  }
}
