import 'package:meta/meta.dart';
import '../api_model/query_result.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../nucleus_one.dart';

import 'approval.dart' as mod;
import 'document.dart' as mod;
import 'document_comment.dart' as mod;
import 'document_event.dart' as mod;
import 'document_folder.dart' as mod;
import 'document_subscription_for_client.dart' as mod;
import 'field.dart' as mod;
import 'folder_hierarchies.dart' as mod;
import 'form_template.dart' as mod;
import 'organization_for_client.dart' as mod;
import 'organization_membership_package.dart' as mod;
import 'organization_package.dart' as mod;
import 'organization_project.dart' as mod;
import 'support_error_event.dart' as mod;
import 'support_organization.dart' as mod;
import 'support_user.dart' as mod;
import 'task.dart' as mod;
import 'task_comment.dart' as mod;
import 'task_event.dart' as mod;
import 'user_organization_project.dart' as mod;

TQueryResult _resultsFromApiModel<T extends EntityCollection, TQueryResult extends QueryResult<T>>(
  bool isQueryResult2,
  dynamic Function(dynamic apiModel) qrFromApiModelHandler,
  Map<Type, Object Function(Map<String, dynamic>)> fromApiModelFactories,
  dynamic apiModel,
) {
  final r = qrFromApiModelHandler(apiModel);
  final fromApiModel = fromApiModelFactories[T];
  if (fromApiModel == null) {
    final className = isQueryResult2 ? 'QueryResult2' : 'QueryResult';
    throw UnimplementedError(
        'The $T.fromApiModel factory constructor must be explicitly registered in the model $className class.');
  }
  return r..results = fromApiModel(apiModel) as T;
}

class QueryResult<T extends EntityCollection> with NucleusOneAppDependent {
  static final _fromApiModelFactories = <Type, Object Function(dynamic json)>{
    ...QueryResult2._fromApiModelFactories, // Include factories from the QueryResult2 class
    mod.DocumentCollection: (x) => mod.DocumentCollection.fromApiModel(x),
    mod.DocumentFolderCollection: (x) => mod.DocumentFolderCollection.fromApiModel(x),
    mod.DocumentSubscriptionForClientCollection: (x) =>
        mod.DocumentSubscriptionForClientCollection.fromApiModel(x),
    mod.FieldCollection: (x) => mod.FieldCollection.fromApiModel(x),
    mod.ApprovalCollection: (x) => mod.ApprovalCollection.fromApiModel(x),
    mod.FolderHierarchyCollection: (x) => mod.FolderHierarchyCollection.fromApiModel(x),
    mod.FormTemplateCollection: (x) => mod.FormTemplateCollection.fromApiModel(x),
    mod.TaskCollection: (x) => mod.TaskCollection.fromApiModel(x),
    mod.OrganizationForClientCollection: (x) => mod.OrganizationForClientCollection.fromApiModel(x),
    mod.OrganizationMembershipPackageCollection: (x) =>
        mod.OrganizationMembershipPackageCollection.fromApiModel(x),
    mod.OrganizationPackageCollection: (x) => mod.OrganizationPackageCollection.fromApiModel(x),
    mod.OrganizationProjectCollection: (x) => mod.OrganizationProjectCollection.fromApiModel(x),
    mod.SupportUserCollection: (x) => mod.SupportUserCollection.fromApiModel(x),
    mod.SupportOrganizationCollection: (x) => mod.SupportOrganizationCollection.fromApiModel(x),
    mod.SupportErrorEventCollection: (x) => mod.SupportErrorEventCollection.fromApiModel(x),
    mod.UserOrganizationProjectCollection: (x) =>
        mod.UserOrganizationProjectCollection.fromApiModel(x),
  };

  @protected
  QueryResult({
    NucleusOneApp? app,
    required this.results,
    required this.cursor,
    required this.pageSize,
  }) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  /// A necessary factory constructor for creating a new QueryResult instance
  /// from a map. Pass the map to the generated [_$QueryResultFromJson()] constructor.
  /// The constructor is named after the source class, in this case, QueryResult.
  factory QueryResult.fromApiModel(dynamic apiModel) {
    return _resultsFromApiModel<T, QueryResult<T>>(
        false, _fromApiModel, _fromApiModelFactories, apiModel);
  }

  static QueryResult _fromApiModel(dynamic apiModel) {
    return QueryResult(
      results: apiModel.results!,
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

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
  static final _fromApiModelFactories = <Type, Object Function(dynamic json)>{
    mod.DocumentCommentCollection: (x) => mod.DocumentCommentCollection.fromApiModel(x),
    mod.DocumentEventCollection: (x) => mod.DocumentEventCollection.fromApiModel(x),
    mod.TaskCommentCollection: (x) => mod.TaskCommentCollection.fromApiModel(x),
    mod.TaskEventCollection: (x) => mod.TaskEventCollection.fromApiModel(x),
  };

  @protected
  QueryResult2({
    NucleusOneApp? app,
    required T results,
    required String cursor,
    required this.reverseCursor,
    required int pageSize,
  }) : super(
          app: app,
          results: results,
          cursor: cursor,
          pageSize: pageSize,
        );

  /// A necessary factory constructor for creating a new QueryResult instance
  /// from a map. Pass the map to the generated [_$QueryResultFromJson()] constructor.
  /// The constructor is named after the source class, in this case, QueryResult.
  factory QueryResult2.fromApiModel(dynamic apiModel) {
    return _resultsFromApiModel<T, QueryResult2<T>>(
        true, _fromApiModel, _fromApiModelFactories, apiModel);
  }

  static QueryResult2 _fromApiModel(dynamic apiModel) {
    return QueryResult2(
      results: apiModel.results!,
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }

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
