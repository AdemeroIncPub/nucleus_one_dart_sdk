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
import 'folder_hierarchy.dart' as mod;
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

TQueryResult _resultsFromApiModel<TModel extends EntityCollection, TApiModel,
    TQueryResult extends QueryResult<TModel, TApiModel>>(
  bool isQueryResult2,
  TQueryResult Function(dynamic apiModel, Object Function(dynamic) fromApiModel)
      qrFromApiModelHandler,
  Map<Type, Object Function(dynamic apiModel)> fromApiModelFactories,
  api_mod.QueryResult apiModel,
) {
  final fromApiModel = fromApiModelFactories[TModel];
  if (fromApiModel == null) {
    final className = isQueryResult2 ? 'QueryResult2' : 'QueryResult';
    throw UnimplementedError(
        'The $TModel.fromApiModel factory constructor must be explicitly registered in the model $className class.');
  }

  final r = qrFromApiModelHandler(apiModel, fromApiModel);
  return r;
}

class QueryResult<TModel extends EntityCollection, TApiModel>
    with NucleusOneAppDependent
    implements IToApiModel {
  static final _fromApiModelFactories = <Type, Object Function(dynamic apiModel)>{
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
  factory QueryResult.fromApiModel(
      api_mod.QueryResult/*<api_mod.EntityCollection<api_mod.Entity>>*/ apiModel) {
    return _resultsFromApiModel<TModel, TApiModel, QueryResult<TModel, TApiModel>>(
        false, _fromApiModel, _fromApiModelFactories, apiModel);
  }

  static QueryResult<TModel, TApiModel> _fromApiModel<TModel extends EntityCollection, TApiModel,
      TQueryResult extends QueryResult<TModel, TApiModel>>(
    dynamic apiModel,
    Object Function(dynamic) fromApiModel,
  ) {
    return QueryResult<TModel, TApiModel>(
      results: fromApiModel(apiModel.results) as TModel,
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  final TModel results;

  final String cursor;

  final int pageSize;

  @override
  @visibleForTesting
  @protected
  api_mod.QueryResult<TApiModel> toApiModel() {
    return api_mod.QueryResult<TApiModel>()
      ..results = results.toApiModel()
      ..cursor = cursor
      ..pageSize = pageSize;
  }
}

class QueryResult2<TModel extends EntityCollection, TApiModel>
    extends QueryResult<TModel, TApiModel> {
  static final _fromApiModelFactories = <Type, Object Function(dynamic apiModel)>{
    mod.DocumentCommentCollection: (x) => mod.DocumentCommentCollection.fromApiModel(x),
    mod.DocumentEventCollection: (x) => mod.DocumentEventCollection.fromApiModel(x),
    mod.TaskCommentCollection: (x) => mod.TaskCommentCollection.fromApiModel(x),
    mod.TaskEventCollection: (x) => mod.TaskEventCollection.fromApiModel(x),
  };

  @protected
  QueryResult2({
    NucleusOneApp? app,
    required TModel results,
    required String cursor,
    required this.reverseCursor,
    required int pageSize,
  }) : super(
          app: app,
          results: results,
          cursor: cursor,
          pageSize: pageSize,
        );

  /// A necessary factory constructor for creating a new QueryResult2 instance from a map.
  factory QueryResult2.fromApiModel(api_mod.QueryResult2 apiModel) {
    return _resultsFromApiModel<TModel, TApiModel, QueryResult2<TModel, TApiModel>>(
        true, _fromApiModel, _fromApiModelFactories, apiModel);
  }

  static QueryResult2<TModel, TApiModel> _fromApiModel<TModel extends EntityCollection, TApiModel,
      TQueryResult extends QueryResult<TModel, TApiModel>>(
    dynamic apiModel,
    Object Function(dynamic) fromApiModel,
  ) {
    return QueryResult2<TModel, TApiModel>(
      results: fromApiModel(apiModel.results) as TModel,
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  String reverseCursor;

  @visibleForTesting
  @override
  api_mod.QueryResult2<TApiModel> toApiModel() {
    return api_mod.QueryResult2<TApiModel>()
      ..results = results.toApiModel()
      ..cursor = cursor
      ..reverseCursor = reverseCursor
      ..pageSize = pageSize;
  }
}
