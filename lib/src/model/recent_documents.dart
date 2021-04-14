import '../api_model/recent_documents.dart' as api_model;
import 'document.dart';

class RecentDocuments {
  RecentDocuments._({required this.documents, required this.cursor, required this.pageSize});

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
