import 'package:json_annotation/json_annotation.dart';
import '../api_model/classification.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../api_model/field.dart' as api_mod;

part 'query_result.g.dart';

TQueryResult _resultsFromJson<T, TQueryResult extends QueryResult<T>>(
    bool isQueryResult2,
    TQueryResult Function(Map<String, dynamic> json) qrFromJsonHandler,
    Map<Type, Object Function(Map<String, dynamic>)> fromJsonFactories,
    Map<String, dynamic> json,
    Object Function(Map<String, dynamic>)? fromJsonFactoryOverride) {
  final r = qrFromJsonHandler(json);
  final fromJsonFactory = fromJsonFactoryOverride ?? fromJsonFactories[T];
  if (fromJsonFactory == null) {
    final className = isQueryResult2 ? 'QueryResult2' : 'QueryResult';
    throw UnimplementedError(
        'The $T.fromJson factory constructor must be explicitly registered in the $className class.');
  }
  return r..results = fromJsonFactory(json) as T;
}

// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class QueryResult<T> {
  static final _fromJsonFactories = <Type, Object Function(Map<String, dynamic> json)>{
    ...QueryResult2._fromJsonFactories, // Include factories from the QueryResult2 class
    api_mod.ClassificationCollection: (x) => api_mod.ClassificationCollection.fromJson(x),
    api_mod.DocumentResultCollection: (x) => api_mod.DocumentResultCollection.fromJson(x),
    api_mod.FieldCollection: (x) => api_mod.FieldCollection.fromJson(x),
  };

  QueryResult();

  /// A necessary factory constructor for creating a new QueryResult instance
  /// from a map. Pass the map to the generated [_$QueryResultFromJson()] constructor.
  /// The constructor is named after the source class, in this case, QueryResult.
  factory QueryResult.fromJson(Map<String, dynamic> json,
      [Object Function(Map<String, dynamic>)? fromJsonFactoryOverride]) {
    return _resultsFromJson<T, QueryResult<T>>(
        false, _$QueryResultFromJson, _fromJsonFactories, json, fromJsonFactoryOverride);
  }

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
  factory QueryResult2.fromJson(Map<String, dynamic> json,
      [Object Function(Map<String, dynamic>)? fromJsonFactoryOverride]) {
    return _resultsFromJson<T, QueryResult2<T>>(
        true, _$QueryResult2FromJson, _fromJsonFactories, json, fromJsonFactoryOverride);
  }

  @JsonKey(name: 'ReverseCursor')
  String? reverseCursor;

  // coverage:ignore-start
  /// [toJson] is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method [_$QueryResult2ToJson].
  @override
  Map<String, dynamic> toJson() => _$QueryResult2ToJson(this);
  // coverage:ignore-end
}
