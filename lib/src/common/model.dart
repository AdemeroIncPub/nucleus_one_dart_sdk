import 'dart:convert';

import '../hierarchy/nucleus_one_app_project.dart';
import '../http.dart' as http;
import '../model/document.dart' as mod;
import '../model/document_comment.dart' as mod;
import '../model/document_event.dart' as mod;
import '../model/document_folder.dart' as mod;
import '../model/task_comment.dart' as mod;
import '../model/task_event.dart' as mod;
import '../model/field.dart' as mod;
import '../model/approval.dart' as mod;
import '../model/field_list_item.dart' as mod;
import '../model/folder_hierarchies.dart' as mod;
import '../model/form_template.dart' as mod;
import '../model/task.dart' as mod;
import '../model/support_user.dart' as mod;
import '../model/support_organization.dart' as mod;
import '../model/support_error_event.dart' as mod;
import '../model/organization_for_client.dart' as mod;
import '../model/organization_package.dart' as mod;
import '../model/organization_project.dart' as mod;
import '../model/query_result.dart' as mod;
import '../model/user_organization_project.dart' as mod;
import '../api_model/document.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_folder.dart' as api_mod;
import '../api_model/organization_package.dart' as api_mod;
import '../api_model/organization_project.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/field.dart' as api_mod;
import '../api_model/approval.dart' as api_mod;
import '../api_model/folder_hierarchies.dart' as api_mod;
import '../api_model/form_template.dart' as api_mod;
import '../api_model/user_organization_project.dart' as api_mod;
import '../api_model/task.dart' as api_mod;
import '../api_model/task_comment.dart' as api_mod;
import '../api_model/task_event.dart' as api_mod;
import '../api_model/support_user.dart' as api_mod;
import '../api_model/support_organization.dart' as api_mod;
import '../api_model/support_error_event.dart' as api_mod;
import '../api_model/organization_for_client.dart' as api_mod;

import '../nucleus_one.dart';
import 'get_it.dart';

/// Base class for Model classes which support paging.
abstract class IModelPagingCursor {
  /// The ID of the cursor, from a previous query.  Used for paging results.
  abstract String cursor;

  /// The size of each page of results returned from a query.  Used for paging results.
  abstract int pageSize;
}

/// Base class for Model classes which support paging and a reverse cursor.
abstract class IModelPagingCursor2 extends IModelPagingCursor {
  /// The ID of the cursor used for getting results in reverse order, from a previous query.  Used
  /// for paging results.
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

/// Supports serialization of JSON structures that have an array at their root, which is not
/// currently implicitly supported by json_serializable.
/// https://github.com/google/json_serializable.dart/issues/648
abstract class EntityCollection<TResult extends NucleusOneAppDependent, TApiModel>
    with NucleusOneAppDependent /*, IterableMixin<T>*/ {
  /// Creates an EntityCollection instance.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [items]: The items to insert into this new collection.
  EntityCollection({
    NucleusOneApp? app,
    List<TResult>? items,
  }) : _items = List.unmodifiable(items ?? []) {
    this.app = app ?? getIt.get<NucleusOneApp>();
  }

  final List<TResult> _items;

  /// Gets all items in this collections.
  List<TResult> get items => _items;

  // @override
  // Iterator<T> get iterator => EntityCollectionIterator(_items);

  // T operator [](int i) => _items[i];

  /// Gets the API Model representation of this object.
  TApiModel toApiModel();
}

/// Contains logic for operating on list items used with the Nucleus One API.
abstract class ListItems {
  /// Builds query string parameters relevant to list items.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  ///
  /// [parentValue]: The parent list item value.
  ///
  /// [valueFilter]: The list item value to filter on.
  static Map<String, dynamic> getListItemsQueryParams({
    String? cursor,
    String? parentValue,
    String? valueFilter,
  }) {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    if (parentValue != null) {
      qp['parentValue'] = parentValue;
    }
    if (valueFilter != null) {
      qp['valueFilter'] = valueFilter;
    }
    return qp;
  }

  // static Future<void> downloadListItems({
  //   required NucleusOneApp app,
  //   required String apiRelativeUrlPath,
  //   String? parentValue,
  //   String? valueFilter,
  //   required String destinationFilePath,
  //   String? cursor,
  // }) async {
  //   final qp = getListItemsQueryParams(cursor, parentValue, valueFilter);
  //   qp['getAllAsFlatFile'] = true;
  //   await http.downloadAuthenticated(apiRelativeUrlPath, destinationFilePath, app, queryParams: qp);
  // }

  /// Adds list items to a collection on the Nucleus One server.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [apiRelativeUrlPath]: The relative Nucleus One API path to use when call the API.
  ///
  /// [items]: The items to add.
  ///
  /// [additionalQueryParams]: Additional query string parameters.
  static Future<void> addListItems({
    NucleusOneApp? app,
    required String apiRelativeUrlPath,
    required mod.FieldListItemCollection items,
    Map<String, dynamic>? additionalQueryParams,
  }) async {
    final qp = http.StandardQueryParams.get();
    if (additionalQueryParams != null) {
      qp.addAll(additionalQueryParams);
    }

    await http.executePostRequest(
      apiRelativeUrlPath: apiRelativeUrlPath,
      app: app,
      queryParams: qp,
      body: jsonEncode(items.toApiModel()),
    );
  }

  /// Sets or replaces list item values of a collection on the Nucleus One server.
  ///
  /// [app]: The application to use when connecting to Nucleus One.
  ///
  /// [apiRelativeUrlPath]: The relative Nucleus One API path to use when call the API.
  ///
  /// [values]: The values to set.
  ///
  /// [additionalQueryParams]: Additional query string parameters.
  static Future<void> setListItems({
    NucleusOneApp? app,
    required String apiRelativeUrlPath,
    required List<String> values,
    Map<String, dynamic>? additionalQueryParams,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['type'] = 'file';
    if (additionalQueryParams != null) {
      qp.addAll(additionalQueryParams);
    }

    await http.executePostRequest(
      apiRelativeUrlPath: apiRelativeUrlPath,
      app: app,
      queryParams: qp,
      body: '${values.join('\n')}\n',
    );
  }
}

/// Contains logic for working with [DocumentCollection] and [QueryResult] classes.
abstract class DocumentCollectionQueryResult {
  /// Creates a [DocumentCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.DocumentCollection> fromApiModelDocumentCollection(
    api_mod.QueryResult<api_mod.DocumentCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.DocumentCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [DocumentCommentCollection] and [QueryResult] classes.
abstract class DocumentCommentCollectionQueryResult {
  /// Creates a [DocumentCommentCollection] instance from its respective [QueryResult2] instance.
  static mod.QueryResult2<mod.DocumentCommentCollection> fromApiModelDocumentCommentCollection(
    api_mod.QueryResult2<api_mod.DocumentCommentCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult2(
      results: mod.DocumentCommentCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [DocumentEventCollection] and [QueryResult] classes.
abstract class DocumentEventCollectionQueryResult {
  /// Creates a [DocumentEventCollection] instance from its respective [QueryResult2] instance.
  static mod.QueryResult2<mod.DocumentEventCollection> fromApiModelDocumentEventCollection(
    api_mod.QueryResult2<api_mod.DocumentEventCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult2(
      results: mod.DocumentEventCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [FieldCollection] and [QueryResult] classes.
abstract class FieldCollectionQueryResult {
  /// Creates a [FieldCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.FieldCollection> fromApiModelFieldCollection(
    api_mod.QueryResult<api_mod.FieldCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.FieldCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [DocumentFolderCollection] and [QueryResult] classes.
abstract class DocumentFolderCollectionQueryResult {
  /// Creates a [DocumentFolderCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.DocumentFolderCollection> fromApiModelDocumentFolderCollection(
    api_mod.QueryResult<api_mod.DocumentFolderCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.DocumentFolderCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [ApprovalCollection] and [QueryResult] classes.
abstract class ApprovalCollectionQueryResult {
  /// Creates a [ApprovalCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.ApprovalCollection> fromApiModelApprovalCollection(
    api_mod.QueryResult<api_mod.ApprovalCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.ApprovalCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [FolderHierarchyCollection] and [QueryResult] classes.
abstract class FolderHierarchyCollectionQueryResult {
  /// Creates a [FolderHierarchyCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.FolderHierarchyCollection> fromApiModelFolderHierarchyCollection(
    api_mod.QueryResult<api_mod.FolderHierarchyCollection> apiModel, {
    NucleusOneAppProject? project,
  }) {
    return mod.QueryResult(
      results: mod.FolderHierarchyCollection.fromApiModel(apiModel.results!, project: project),
      cursor: apiModel.cursor!,
      // At the time of writing this, the API call for this didn't support this property
      pageSize: 0,
    );
  }
}

/// Contains logic for working with [FormTemplateCollection] and [QueryResult] classes.
abstract class FormTemplateCollectionQueryResult {
  /// Creates a [FormTemplateCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.FormTemplateCollection> fromApiModelFormTemplateCollection(
    api_mod.QueryResult<api_mod.FormTemplateCollection> apiModel, {
    NucleusOneAppProject? project,
  }) {
    return mod.QueryResult(
      results: mod.FormTemplateCollection.fromApiModel(apiModel.results!, project: project),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [OrganizationPackageCollection] and [QueryResult] classes.
abstract class OrganizationPackageCollectionQueryResult {
  /// Creates a [OrganizationPackageCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.OrganizationPackageCollection>
      fromApiModelOrganizationPackageCollection(
    api_mod.QueryResult<api_mod.OrganizationPackageCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.OrganizationPackageCollection.fromApiModel(apiModel.results!, app: app),
      // At the time of writing this, the API call for this didn't support these properties
      cursor: '',
      pageSize: 0,
    );
  }
}

/// Contains logic for working with [TaskCollection] and [QueryResult] classes.
abstract class TaskCollectionQueryResult {
  /// Creates a [TaskCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.TaskCollection> fromApiModelTaskCollection(
    api_mod.QueryResult<api_mod.TaskCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.TaskCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [SupportUserCollection] and [QueryResult] classes.
abstract class SupportUserCollectionQueryResult {
  /// Creates a [SupportUserCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.SupportUserCollection> fromApiModelSupportUserCollection(
    api_mod.QueryResult<api_mod.SupportUserCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.SupportUserCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [SupportOrganizationCollection] and [QueryResult] classes.
abstract class SupportOrganizationCollectionQueryResult {
  /// Creates a [SupportOrganizationCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.SupportOrganizationCollection>
      fromApiModelSupportOrganizationCollection(
    api_mod.QueryResult<api_mod.SupportOrganizationCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.SupportOrganizationCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [SupportErrorEventCollection] and [QueryResult] classes.
abstract class SupportErrorEventCollectionQueryResult {
  /// Creates a [SupportErrorEventCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.SupportErrorEventCollection> fromApiModelSupportErrorEventCollection(
    api_mod.QueryResult<api_mod.SupportErrorEventCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.SupportErrorEventCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [TaskCommentCollection] and [QueryResult] classes.
abstract class TaskCommentCollectionQueryResult {
  /// Creates a [TaskCommentCollection] instance from its respective [QueryResult2] instance.
  static mod.QueryResult2<mod.TaskCommentCollection> fromApiModelTaskCommentCollection(
    api_mod.QueryResult2<api_mod.TaskCommentCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult2(
      results: mod.TaskCommentCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [TaskEventCollection] and [QueryResult] classes.
abstract class TaskEventCollectionQueryResult {
  /// Creates a [TaskEventCollection] instance from its respective [QueryResult2] instance.
  static mod.QueryResult2<mod.TaskEventCollection> fromApiModelTaskEventCollection(
    api_mod.QueryResult2<api_mod.TaskEventCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult2(
      results: mod.TaskEventCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      reverseCursor: apiModel.reverseCursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [UserOrganizationProjectCollection] and [QueryResult] classes.
abstract class UserOrganizationProjectCollectionQueryResult {
  /// Creates a [UserOrganizationProjectCollection] instance from its respective [QueryResult]
  /// instance.
  static mod.QueryResult<mod.UserOrganizationProjectCollection>
      fromApiModelUserOrganizationProjectCollection(
    api_mod.QueryResult<api_mod.UserOrganizationProjectCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.UserOrganizationProjectCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [OrganizationProjectCollection] and [QueryResult] classes.
abstract class OrganizationProjectCollectionQueryResult {
  /// Creates a [OrganizationProjectCollection] instance from its respective [QueryResult] instance.
  static mod.QueryResult<mod.OrganizationProjectCollection>
      fromApiModelOrganizationProjectCollection(
    api_mod.QueryResult<api_mod.OrganizationProjectCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.OrganizationProjectCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

/// Contains logic for working with [OrganizationForClientCollection] and [QueryResult] classes.
abstract class OrganizationForClientCollectionQueryResult {
  /// Creates a [OrganizationForClientCollection] instance from its respective [QueryResult]
  /// instance.
  static mod.QueryResult<mod.OrganizationForClientCollection>
      fromApiModelOrganizationForClientCollection(
    api_mod.QueryResult<api_mod.OrganizationForClientCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.OrganizationForClientCollection.fromApiModel(apiModel.results!, app: app),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}
