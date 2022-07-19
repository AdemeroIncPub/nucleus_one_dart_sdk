import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import '../http.dart' as http;
import '../model/document.dart' as mod;
import '../model/document_for_client.dart' as mod;
import '../model/document_comment.dart' as mod;
import '../model/document_event.dart' as mod;
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
import '../model/organization_package.dart' as mod;
import '../model/query_result.dart' as mod;
import '../model/user_organization_project.dart' as mod;
import '../api_model/document.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/organization_package.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
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

abstract class EntityCollection<TResult extends NucleusOneAppDependent, TApiModel>
    with NucleusOneAppDependent /*, IterableMixin<T>*/ {
  EntityCollection({
    NucleusOneApp? app,
    List<TResult>? items,
  }) : _items = List.unmodifiable(items ?? []) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>();
  }

  final List<TResult> _items;
  List<TResult> get items => _items;

  // @override
  // Iterator<T> get iterator => EntityCollectionIterator(_items);

  // T operator [](int i) => _items[i];

  TApiModel toApiModel();
}

abstract class ListItems {
  static Map<String, dynamic> getListItemsQueryParams(
      String? cursor, String? parentValue, String? valueFilter) {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
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
  //   await http.downloadAuthenticated(apiRelativeUrlPath, destinationFilePath, app, query: qp);
  // }

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
      apiRelativeUrlPath,
      app: app,
      query: qp,
      body: jsonEncode(items.toApiModel()),
    );
  }

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
      apiRelativeUrlPath,
      app: app,
      query: qp,
      body: values.join('\n') + '\n',
    );
  }
}

abstract class DocumentCollectionQueryResult {
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

abstract class DocumentCommentCollectionQueryResult {
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

abstract class DocumentEventCollectionQueryResult {
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

abstract class FieldCollectionQueryResult {
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

abstract class ApprovalCollectionQueryResult {
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

abstract class FolderHierarchyCollectionQueryResult {
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

abstract class FormTemplateCollectionQueryResult {
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

abstract class OrganizationPackageCollectionQueryResult {
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

abstract class TaskCollectionQueryResult {
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

abstract class SupportUserCollectionQueryResult {
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

abstract class SupportOrganizationCollectionQueryResult {
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

abstract class SupportErrorEventCollectionQueryResult {
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

abstract class TaskCommentCollectionQueryResult {
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

abstract class TaskEventCollectionQueryResult {
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

abstract class UserOrganizationProjectCollectionQueryResult {
  static mod.QueryResult<mod.UserOrganizationProjectCollection>
      fromApiModelUserOrganizationProjectCollection(
    api_mod.QueryResult<api_mod.UserOrganizationProjectCollection> apiModel, {
    NucleusOneApp? app,
  }) {
    return mod.QueryResult(
      results: mod.UserOrganizationProjectCollection(
          items: apiModel.results!.userOrganizationProjects!
              .map((x) => mod.UserOrganizationProject.fromApiModel(x, app: app))
              .toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}
