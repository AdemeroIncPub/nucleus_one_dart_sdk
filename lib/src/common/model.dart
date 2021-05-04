import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../model/document.dart' as mod;
import '../model/document_comment.dart' as mod;
import '../model/document_event.dart' as mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;

import '../nucleus_one.dart';

abstract class IApiModelPagingCursor {
  abstract String? cursor;
  abstract int? pageSize;
}

abstract class IApiModelPagingCursor2 extends IApiModelPagingCursor {
  abstract String? reverseCursor;
}

abstract class IModelPagingCursor {
  abstract String cursor;
  abstract int pageSize;
}

abstract class IModelPagingCursor2 extends IModelPagingCursor {
  abstract String reverseCursor;
}

// class EntityCollectionIterator<T extends NucleusOneAppDependent> extends Iterator<T> {
//   EntityCollectionIterator(List<T> list) : _list = list;

//   final List<T> _list;

//   int _current = -1;

//   @override
//   bool moveNext() {
//     if (_current == (_list.length - 1)) {
//       return false;
//     }
//     ++_current;
//     return true;
//   }

//   @override
//   T get current => _list[_current];
// }

abstract class EntityCollection<T extends NucleusOneAppDependent>
    with NucleusOneAppDependent /*, IterableMixin<T>*/ {
  EntityCollection({
    NucleusOneAppInternal? app,
    List<T>? items,
  }) : _items = List.unmodifiable(items ?? []) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  final List<T> _items;
  List<T> get items => _items;

  // @override
  // Iterator<T> get iterator => EntityCollectionIterator(_items);

  // T operator [](int i) => _items[i];
}

class QueryResult<T extends EntityCollection>
    with NucleusOneAppDependent
    implements IModelPagingCursor {
  @protected
  QueryResult({
    required this.results,
    required this.cursor,
    required this.pageSize,
  });

  T results;

  @override
  String cursor;

  @override
  int pageSize;
}

class QueryResult2<T extends EntityCollection> extends QueryResult<T>
    implements IModelPagingCursor2 {
  @protected
  QueryResult2({
    required T results,
    required String cursor,
    required this.reverseCursor,
    required int pageSize,
  }) : super(
          results: results,
          cursor: cursor,
          pageSize: pageSize,
        );

  @override
  String reverseCursor;
}

abstract class DocumentCollectionQueryResult {
  static QueryResult<mod.DocumentCollection> fromApiModelDocumentResults(
      api_mod.DocumentResults apiModel) {
    return QueryResult(
      results: mod.DocumentCollection(
          items: apiModel.documents!.map((x) => mod.Document.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

abstract class DocumentCommentCollectionQueryResult {
  static QueryResult2<mod.DocumentCommentCollection> fromApiModelDocumentCommentCollection(
      api_mod.DocumentCommentCollection apiModel) {
    return QueryResult2(
      results: mod.DocumentCommentCollection(
          items: apiModel.documentEvents!.map((x) => mod.DocumentEvent.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

