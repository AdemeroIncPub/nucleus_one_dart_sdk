import 'package:meta/meta.dart';
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../nucleus_one.dart';

class QueryResult<T extends EntityCollection> with NucleusOneAppDependent {
  @protected
  QueryResult({
    required this.results,
    required this.cursor,
    required this.pageSize,
  });

  T results;

  String cursor;

  int pageSize;

  @visibleForTesting
  @protected
  api_mod.QueryResult<TApiModel> toApiModel<TApiModel>() {
    return api_mod.QueryResult<TApiModel>()
      ..results = results.toApiModel() as TApiModel
      ..cursor = cursor
      ..pageSize = pageSize;
  }
}

class QueryResult2<T extends EntityCollection> extends QueryResult<T> {
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

  String reverseCursor;

  @visibleForTesting
  @override
  api_mod.QueryResult2<TApiModel> toApiModel<TApiModel>() {
    return api_mod.QueryResult2<TApiModel>()
      ..results = results.toApiModel() as TApiModel
      ..cursor = cursor
      ..reverseCursor = reverseCursor
      ..pageSize = pageSize;
  }
}