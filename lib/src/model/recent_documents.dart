import 'package:get_it/get_it.dart';

import '../api_model/recent_documents.dart' as api_model;
import '../nucleus_one.dart';
import 'document.dart';

class RecentDocuments with NucleusOneAppDependent {
  RecentDocuments._(
      {NucleusOneAppInternal? app,
      required this.documents,
      required this.cursor,
      required this.pageSize}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory RecentDocuments.fromApiModel(api_model.RecentDocuments apiModel) {
    return RecentDocuments._(
        documents: apiModel.documents!.map((x) => Document.fromApiModel(x)).toList(),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!);
  }

  List<Document> documents;

  String cursor;

  int pageSize;

  api_model.RecentDocuments toApiModel() {
    return api_model.RecentDocuments()
      ..documents = documents.map((x) => x.toApiModel()).toList()
      ..cursor = cursor
      ..pageSize = pageSize;
  }
}
