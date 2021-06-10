import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/folder_hierarchies.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../http.dart' as http;
import '../nucleus_one.dart';

class NucleusOneAppFolderHierarchies with NucleusOneAppDependent {
  NucleusOneAppFolderHierarchies({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }
  
  /// Gets folder hierarchies, by page.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [getAll]: Whether to retrieve all folder hierarchies.
  Future<QueryResult<FolderHierarchyCollection>> get({
    String? cursor,
    bool? getAll,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.folderHierarchies,
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.FolderHierarchyCollection>.fromJson(jsonDecode(responseBody));
    return FolderHierarchyCollectionQueryResult.fromApiModelFolderHierarchyCollection(apiModel);
  }

  /// Gets a folder hierarchy by id.
  ///
  /// [id]: The id of the folder hierarchy.
  Future<FolderHierarchy> getById(String id) async {
    final qp = http.StandardQueryParams.get();

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.folderHierarchiesFormat.replaceFirst('<folderHierarchyId>', id),
      app,
      query: qp,
    );
    final apiModel = api_mod.FolderHierarchy.fromJson(jsonDecode(responseBody));
    return FolderHierarchy.fromApiModel(apiModel);
  }

  /// Gets a folder hierarchy's items by its id.
  ///
  /// [folderHierarchyId]: The id of the folder hierarchy.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [getAll]: Whether to retrieve all folder hierarchy items.
  Future<FolderHierarchyItemCollection> getItemsById(
    String folderHierarchyId, {
    String? cursor,
    bool? getAll,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.folderHierarchiesItemsFormat
          .replaceFirst('<folderHierarchyId>', folderHierarchyId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FolderHierarchyItemCollection.fromJson(jsonDecode(responseBody));
    return FolderHierarchyItemCollection.fromApiModel(apiModel);
  }

  /// Gets a folder hierarchy item by its id.
  ///
  /// [folderHierarchyId]: The id of the folder hierarchy.
  ///
  /// [itemId]: The id of the folder hierarchy item.
  Future<FolderHierarchyItem> getItemById(
    String folderHierarchyId,
    String itemId, {
    String? cursor,
    bool? getAll,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.folderHierarchiesItemsItemFormat
          .replaceFirst('<folderHierarchyId>', folderHierarchyId)
          .replaceFirst('<folderHierarchyItemId>', itemId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FolderHierarchyItem.fromJson(jsonDecode(responseBody));
    return FolderHierarchyItem.fromApiModel(apiModel);
  }
}
