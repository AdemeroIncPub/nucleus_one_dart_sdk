import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_for_client.dart';

import '../nucleus_one.dart';
import '../model/document_package.dart';
import '../http.dart' as http;
import '../api_model/document_content_package.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_package.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;

class NucleusOneAppDocuments with NucleusOneAppDependent {
  NucleusOneAppDocuments({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets the document count.
  ///
  /// [ignoreInbox]: Whether results should contain documents from the Inbox.
  ///
  /// [ignoreRecycleBin]: Whether results should contain documents from the Recycle Bin.
  Future<int> getCount(bool ignoreInbox, bool ignoreRecycleBin) async {
    final qp = {
      'ignoreInbox': ignoreInbox,
      'ignoreRecycleBin': ignoreRecycleBin,
    };
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentCounts,
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }

  /// Gets a DocumentPackage by a Document Id..
  ///
  /// [documentId]: The id of the document.
  Future<DocumentPackage> getDocumentPackageByDocumentId(String documentId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentPackageFormat.replaceFirst('<documentId>', documentId),
      app,
    );
    final apiModel = api_mod.DocumentPackage.fromJson(jsonDecode(responseBody));
    return DocumentPackage.fromApiModel(apiModel);
  }

  /// Gets recent documents, by page.
  ///
  /// [sortType]: Which field to sort on.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [offset]: The number of initial results to skip.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [singleRecord]: Limits the results to a single document.
  Future<QueryResult<DocumentForClientCollection>> getRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
  }) async {
    return _getRecentInternal(
      sortType: sortType,
      sortDescending: sortDescending,
      offset: offset,
      cursor: cursor,
      singleRecord: singleRecord,
    );
  }

  /// Gets recent Document Subscriptions documents, by page.
  ///
  /// [sortType]: Which field to sort on.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [offset]: The number of initial results to skip.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [singleRecord]: Limits the results to a single document.
  Future<QueryResult<DocumentForClientCollection>> getDocumentSubscriptionsRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
  }) async {
    return _getRecentInternal(
      sortType: sortType,
      sortDescending: sortDescending,
      offset: offset,
      cursor: cursor,
      singleRecord: singleRecord,
      qpAdditional: {
        'documentSubscriptions': true,
      },
    );
  }

  /// Gets comments for a document, by page.
  ///
  /// [documentId]: The document id.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentCommentCollection>> getComments({
    required String documentId,
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', documentId),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentCommentCollection>.fromJson(jsonDecode(responseBody));
    return DocumentCommentCollectionQueryResult.fromApiModelDocumentCommentCollection(apiModel);
  }

  /// Posts comments for a document.
  ///
  /// [documentId]: The document id.
  ///
  /// [comments]: The comments to post.
  Future<void> postComments({
    required String documentId,
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', documentId),
      app,
      body: jsonEncode({'Comments': comments}),
    );
  }

  /// Gets events for a document, by page.
  ///
  /// [documentId]: The document id.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentEventCollection>> getEvents({
    required String documentId,
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsEventsFormat.replaceFirst('<documentId>', documentId),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentEventCollection>.fromJson(jsonDecode(responseBody));

    return DocumentEventCollectionQueryResult.fromApiModelDocumentEventCollection(apiModel);
  }

  /// Restores one or more documents from the Recycle Bin.
  ///
  /// [documentIds]: The document ids to process.
  Future<void> restoreFromRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      http.apiPaths.documentActionsRestoreFromRecycleBin,
      app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Sends one or more documents to the Recycle Bin.
  ///
  /// [documentIds]: The document ids to process.
  Future<void> sendToRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      http.apiPaths.documentActionsSendToRecycleBin,
      app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Gets information needed to download a document.
  ///
  /// [documentId]: The document id to process.
  Future<DocumentContentPackage> getDocumentContentPackage(String documentId) async {
    final qp = http.StandardQueryParams.get();
    qp['displayInline'] = 'false';
    qp['preview'] = 'false';
    qp['singlePage'] = 'false';
    qp['requireSinglePage'] = 'false';
    qp['pageIndex'] = '0';

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentContentPackagesFormat.replaceFirst('<documentId>', documentId),
      app,
      query: qp,
    );
    final apiModel = api_mod.DocumentContentPackage.fromJson(jsonDecode(responseBody));
    return DocumentContentPackage.fromApiModel(apiModel);
  }

  /// Gets recent Recycle Bin documents, by page.
  ///
  /// [sortType]: Which field to sort on.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [offset]: The number of initial results to skip.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [singleRecord]: Limits the results to a single document.
  Future<QueryResult<DocumentForClientCollection>> getRecycleBinRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
  }) async {
    return _getRecentInternal(
      sortType: sortType,
      sortDescending: sortDescending,
      offset: offset,
      cursor: cursor,
      singleRecord: singleRecord,
      qpAdditional: {
        'recycleBin': true,
      },
    );
  }

  /// Gets recent Inbox documents, by page.
  ///
  /// [sortType]: Which field to sort on.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [offset]: The number of initial results to skip.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [singleRecord]: Limits the results to a single document.
  Future<QueryResult<DocumentForClientCollection>> getInboxRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
  }) async {
    return _getRecentInternal(
      sortType: sortType,
      sortDescending: sortDescending,
      offset: offset,
      cursor: cursor,
      singleRecord: singleRecord,
      qpAdditional: {
        'inbox': true,
      },
    );
  }

  Future<QueryResult<DocumentForClientCollection>> _getRecentInternal({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
    Map<String, Object>? qpAdditional,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.sortType(sortType),
      (sqp) => sqp.sortDescending(sortDescending),
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.offset(offset),
    ]);
    if (singleRecord != null) {
      qp['singleRecord'] = singleRecord;
    }
    if (qpAdditional != null) {
      qp.addAll(qpAdditional);
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documents,
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentResultCollection>.fromJson(jsonDecode(responseBody));
    return DocumentForClientCollectionQueryResult.fromApiModelDocumentResultCollection(apiModel);
  }
}
