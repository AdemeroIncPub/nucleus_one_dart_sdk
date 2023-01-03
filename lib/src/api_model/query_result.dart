import 'package:json_annotation/json_annotation.dart';

import '../api_model/approval.dart' as api_mod;
import '../api_model/document.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/document_folder.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../api_model/field.dart' as api_mod;
import '../api_model/folder_hierarchies.dart' as api_mod;
import '../api_model/form_template.dart' as api_mod;
import '../api_model/organization_for_client.dart' as api_mod;
import '../api_model/organization_package.dart' as api_mod;
import '../api_model/organization_project.dart' as api_mod;
import '../api_model/support_error_event.dart' as api_mod;
import '../api_model/support_organization.dart' as api_mod;
import '../api_model/support_user.dart' as api_mod;
import '../api_model/user_organization_project.dart' as api_mod;
import 'task.dart' as api_mod;
import 'task_comment.dart' as api_mod;
import 'task_event.dart' as api_mod;

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

/// This is just a marker interface to indicate an entity's intended usage
abstract class IQueryResultEntityCollection {}

// Serializable members must be explicitly marked with [JsonKey].
@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class QueryResult<T> {
  static final _fromJsonFactories = <Type, Object Function(Map<String, dynamic> json)>{
    ...QueryResult2._fromJsonFactories, // Include factories from the QueryResult2 class
    api_mod.DocumentCollection: (x) => api_mod.DocumentCollection.fromJson(x),
    api_mod.DocumentFolderCollection: (x) => api_mod.DocumentFolderCollection.fromJson(x),
    api_mod.DocumentResultCollection: (x) => api_mod.DocumentResultCollection.fromJson(x),
    api_mod.FieldCollection: (x) => api_mod.FieldCollection.fromJson(x),
    api_mod.ApprovalCollection: (x) => api_mod.ApprovalCollection.fromJson(x),
    api_mod.FolderHierarchyCollection: (x) => api_mod.FolderHierarchyCollection.fromJson(x),
    api_mod.FormTemplateCollection: (x) => api_mod.FormTemplateCollection.fromJson(x),
    api_mod.TaskCollection: (x) => api_mod.TaskCollection.fromJson(x),
    api_mod.OrganizationForClientCollection: (x) =>
        api_mod.OrganizationForClientCollection.fromJson(x),
    api_mod.OrganizationPackageCollection: (x) => api_mod.OrganizationPackageCollection.fromJson(x),
    api_mod.OrganizationProjectCollection: (x) => api_mod.OrganizationProjectCollection.fromJson(x),
    api_mod.SupportUserCollection: (x) => api_mod.SupportUserCollection.fromJson(x),
    api_mod.SupportOrganizationCollection: (x) => api_mod.SupportOrganizationCollection.fromJson(x),
    api_mod.SupportErrorEventCollection: (x) => api_mod.SupportErrorEventCollection.fromJson(x),
    api_mod.UserOrganizationProjectCollection: (x) =>
        api_mod.UserOrganizationProjectCollection.fromJson(x),
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
    api_mod.TaskCommentCollection: (x) => api_mod.TaskCommentCollection.fromJson(x),
    api_mod.TaskEventCollection: (x) => api_mod.TaskEventCollection.fromJson(x),
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
