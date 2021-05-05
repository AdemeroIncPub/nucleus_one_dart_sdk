import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/document.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_content_package.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../http.dart' as http;
import '../nucleus_one.dart';
import 'document_comment.dart';
import 'document_content_package.dart';
import 'document_event.dart';
import 'preview_metadata_item.dart';
import 'query_result.dart';

class DocumentCollection extends EntityCollection<Document, void> {
  DocumentCollection({
    NucleusOneAppInternal? app,
    List<Document>? items,
  }) : super(app: app, items: items);

  @override
  void toApiModel() =>
      throw UnsupportedError('toApiModel() is not supported for this collection type.');

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
  Future<QueryResult<DocumentCollection>> getRecent({
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
  Future<QueryResult<DocumentCollection>> getInboxRecent({
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
  Future<QueryResult<DocumentCollection>> getRecycleBinRecent({
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

  // Future<mod.DocumentResults> getNeedSignatureRecent({
  //   String sortType = 'CreatedOn',
  //   bool sortDescending = true,
  //   int? offset,
  //   String? cursor,
  //   bool? singleRecord,
  // }) async {
  //   return _getRecentInternal(
  //     sortType: sortType,
  //     sortDescending: sortDescending,
  //     offset: offset,
  //     cursor: cursor,
  //     singleRecord: singleRecord,
  //     qpAdditional: {
  //       'documentSignatureSessionRecipients': true,
  //       'showForAllTenantMembers': this.props.isAdmin
  //     },
  //   );
  // }

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
  Future<QueryResult<DocumentCollection>> getDocumentSubscriptionsRecent({
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

  Future<QueryResult<DocumentCollection>> _getRecentInternal({
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
    return DocumentCollectionQueryResult.fromApiModelDocumentResultCollection(apiModel);
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

  /// Returns information needed to download a document.
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
}

class Document with NucleusOneAppDependent {
  Document._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.documentID,
      required this.createdOn,
      required this.purgeDate,
      required this.name,
      required this.pageCount,
      required this.fileSize,
      required this.thumbnailUrl,
      required this.isSigned,
      required this.classificationID,
      required this.classificationName,
      required this.previewMetadata,
      required this.documentApprovalID,
      required this.documentApprovalCreatedOn,
      required this.documentSubscriptionID,
      required this.documentSubscriptionCreatedOn,
      required this.documentSignatureSessionRecipientID,
      required this.documentSignatureSessionID,
      required this.documentSignatureSessionRecipientEmail,
      required this.documentSignatureSessionRecipientFullName,
      required this.documentSignatureSessionRecipientRequestedOn,
      required this.roleName,
      required this.processName,
      required this.processElementName,
      required this.score}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  Document({
    NucleusOneAppInternal? app,
  }) : this._(
          app: app,
          id: '',
          documentID: '',
          createdOn: '',
          purgeDate: '',
          name: '',
          pageCount: 0,
          fileSize: 0,
          thumbnailUrl: '',
          isSigned: false,
          classificationID: '',
          classificationName: '',
          previewMetadata: [],
          documentApprovalID: '',
          documentApprovalCreatedOn: '',
          documentSubscriptionID: '',
          documentSubscriptionCreatedOn: '',
          documentSignatureSessionRecipientID: '',
          documentSignatureSessionID: '',
          documentSignatureSessionRecipientEmail: '',
          documentSignatureSessionRecipientFullName: '',
          documentSignatureSessionRecipientRequestedOn: '',
          roleName: '',
          processName: '',
          processElementName: '',
          score: 0,
        );

  factory Document.fromApiModel(api_mod.Document apiModel) {
    return Document._(
        id: apiModel.id!,
        documentID: apiModel.documentID!,
        createdOn: apiModel.createdOn!,
        purgeDate: apiModel.purgeDate!,
        name: apiModel.name!,
        pageCount: apiModel.pageCount!,
        fileSize: apiModel.fileSize!,
        thumbnailUrl: apiModel.thumbnailUrl!,
        isSigned: apiModel.isSigned!,
        classificationID: apiModel.classificationID!,
        classificationName: apiModel.classificationName!,
        previewMetadata:
            apiModel.previewMetadata?.map((x) => PreviewMetadataItem.fromApiModel(x)).toList(),
        documentApprovalID: apiModel.documentApprovalID!,
        documentApprovalCreatedOn: apiModel.documentApprovalCreatedOn!,
        documentSubscriptionID: apiModel.documentSubscriptionID!,
        documentSubscriptionCreatedOn: apiModel.documentSubscriptionCreatedOn!,
        documentSignatureSessionRecipientID: apiModel.documentSignatureSessionRecipientID!,
        documentSignatureSessionID: apiModel.documentSignatureSessionID!,
        documentSignatureSessionRecipientEmail: apiModel.documentSignatureSessionRecipientEmail!,
        documentSignatureSessionRecipientFullName:
            apiModel.documentSignatureSessionRecipientFullName!,
        documentSignatureSessionRecipientRequestedOn:
            apiModel.documentSignatureSessionRecipientRequestedOn!,
        roleName: apiModel.roleName!,
        processName: apiModel.processName!,
        processElementName: apiModel.processElementName!,
        score: apiModel.score!);
  }

  String id;

  String documentID;

  String createdOn;

  String purgeDate;

  String name;

  int pageCount;

  int fileSize;

  String thumbnailUrl;

  bool isSigned;

  String classificationID;

  String classificationName;

  List<PreviewMetadataItem>? previewMetadata;

  String documentApprovalID;

  String documentApprovalCreatedOn;

  String documentSubscriptionID;

  String documentSubscriptionCreatedOn;

  String documentSignatureSessionRecipientID;

  String documentSignatureSessionID;

  String documentSignatureSessionRecipientEmail;

  String documentSignatureSessionRecipientFullName;

  String documentSignatureSessionRecipientRequestedOn;

  String roleName;

  String processName;

  String processElementName;

  int score;

  api_mod.Document toApiModel() {
    return api_mod.Document()
      ..id = id
      ..documentID = documentID
      ..createdOn = createdOn
      ..purgeDate = purgeDate
      ..name = name
      ..pageCount = pageCount
      ..fileSize = fileSize
      ..thumbnailUrl = thumbnailUrl
      ..isSigned = isSigned
      ..classificationID = classificationID
      ..classificationName = classificationName
      ..previewMetadata = previewMetadata!.map((x) => x.toApiModel()).toList()
      ..documentApprovalID = documentApprovalID
      ..documentApprovalCreatedOn = documentApprovalCreatedOn
      ..documentSubscriptionID = documentSubscriptionID
      ..documentSubscriptionCreatedOn = documentSubscriptionCreatedOn
      ..documentSignatureSessionRecipientID = documentSignatureSessionRecipientID
      ..documentSignatureSessionID = documentSignatureSessionID
      ..documentSignatureSessionRecipientEmail = documentSignatureSessionRecipientEmail
      ..documentSignatureSessionRecipientFullName = documentSignatureSessionRecipientFullName
      ..documentSignatureSessionRecipientRequestedOn = documentSignatureSessionRecipientRequestedOn
      ..roleName = roleName
      ..processName = processName
      ..processElementName = processElementName
      ..score = score;
  }
}
