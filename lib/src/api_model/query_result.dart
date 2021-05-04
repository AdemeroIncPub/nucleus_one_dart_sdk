import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../api_model/classification.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;

part 'query_result.g.dart';

// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class QueryResult<T> {
  static final _fromJsonFactories = <Type, Object Function(Map<String, dynamic> json)>{
    ...QueryResult2._fromJsonFactories, // Include factories from the QueryResult2 class
    api_mod.ClassificationCollection: (x) => api_mod.ClassificationCollection.fromJson(x),
    api_mod.DocumentResultCollection: (x) => api_mod.DocumentResultCollection.fromJson(x),
  };

  QueryResult();

  /// A necessary factory constructor for creating a new QueryResult instance
  /// from a map. Pass the map to the generated [_$QueryResultFromJson()] constructor.
  /// The constructor is named after the source class, in this case, QueryResult.
  factory QueryResult.fromJson(Map<String, dynamic> json) {
    final QueryResult<T> r = _$QueryResultFromJson(json);
    final fromJsonFactory = _fromJsonFactories[T];
    if (fromJsonFactory == null) {
      throw UnimplementedError(
          'The $T.fromJson factory constructor must be explicitly registered in the QueryResult class.');
    }
    return r..results = fromJsonFactory(json) as T;
  }

  @protected
  QueryResult._({
    required this.results,
    required this.cursor,
    required this.pageSize,
  });

  T? results;

  @JsonKey(name: 'Cursor')
  String? cursor;

  @JsonKey(name: 'PageSize')
  int? pageSize;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$QueryResultToJson].
  Map<String, dynamic> toJson() => _$QueryResultToJson(this);
  // coverage:ignore-end
}

// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class QueryResult2<T> extends QueryResult<T> {
  static final _fromJsonFactories = <Type, Object Function(Map<String, dynamic> json)>{
    api_mod.DocumentCommentCollection: (x) => api_mod.DocumentCommentCollection.fromJson(x),
    api_mod.DocumentEventCollection: (x) => api_mod.DocumentEventCollection.fromJson(x),
  };

  QueryResult2() : super();

  /// A necessary factory constructor for creating a new QueryResult2 instance
  /// from a map. Pass the map to the generated [_$QueryResult2FromJson()] constructor.
  /// The constructor is named after the source class, in this case, QueryResult2.
  factory QueryResult2.fromJson(Map<String, dynamic> json) {
    final QueryResult2<T> r = _$QueryResult2FromJson(json);
    final fromJsonFactory = _fromJsonFactories[T];
    if (fromJsonFactory == null) {
      throw UnimplementedError(
          'The $T.fromJson factory constructor must be explicitly registered in the QueryResult2 class.');
    }
    return r..results = fromJsonFactory(json) as T;
  }

  @JsonKey(name: 'ReverseCursor')
  String? reverseCursor;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$QueryResult2ToJson].
  Map<String, dynamic> toJson() => _$QueryResult2ToJson(this);
  // coverage:ignore-end
}
