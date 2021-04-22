import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/document.dart' as api_mod;
import '../api_model/document_comments.dart' as api_mod;
import '../api_model/document_events.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../http.dart' as http;
import 'document_comments.dart' as mod;
import 'document_events.dart' as mod;
import 'document_results.dart' as mod;
import '../nucleus_one.dart';
import 'preview_metadata_item.dart';

class Document with NucleusOneAppDependent {
  Document._(
      {NucleusOneAppInternal? app,
      required this.uniqueID,
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
          uniqueID: '',
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
        uniqueID: apiModel.uniqueID!,
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

  String uniqueID;

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
      ..uniqueID = uniqueID
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
  Future<mod.DocumentResults> getRecent({
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

  /// Gets recent Approval documents, by page.
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
  ///
  /// [processID]: The Approval Process ID to limit the results to.
  ///
  /// [processElementID]: The id of the Approval Process stage.  Used in conjunction with [processID].
  ///
  /// [showForAllInProject]: Admins only.  Allows viewing of all approvals without a result for the entire Project.
  Future<mod.DocumentResults> getApprovalsRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
    String? processID,
    String? processElementID,
    bool? showForAllInProject,
  }) async {
    final qpAdditional = <String, Object>{
      'documentApprovals': true,
    };
    if (showForAllInProject != null) {
      qpAdditional['showForAllInProject'] = showForAllInProject;
    }
    if (showForAllInProject != true) {
      if (processID != null) {
        qpAdditional['processID'] = processID;
      }
      if (processElementID != null) {
        qpAdditional['processElementID'] = processElementID;
      }
    }

    return _getRecentInternal(
      sortType: sortType,
      sortDescending: sortDescending,
      offset: offset,
      cursor: cursor,
      singleRecord: singleRecord,
      qpAdditional: qpAdditional,
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
  Future<mod.DocumentResults> getInboxRecent({
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
  Future<mod.DocumentResults> getRecycleBinRecent({
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
  Future<mod.DocumentResults> getDocumentSubscriptionsRecent({
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

  Future<mod.DocumentResults> _getRecentInternal({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
    Map<String, Object>? qpAdditional,
  }) async {
    final qp = _StandardQueryParams.get([
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
    final dl = api_mod.DocumentResults.fromJson(jsonDecode(responseBody));
    return mod.DocumentResults.fromApiModel(dl);
  }

  /// Gets comments for a document, by page.
  ///
  /// [documentId]: The document id.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<mod.DocumentComments> getComments({
    required String documentId,
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = _StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', documentId),
      app,
      query: qp,
    );
    final dl = api_mod.DocumentComments.fromJson(jsonDecode(responseBody));
    return mod.DocumentComments.fromApiModel(dl);
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
  Future<mod.DocumentEvents> getEvents({
    required String documentId,
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = _StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsEventsFormat.replaceFirst('<documentId>', documentId),
      app,
      query: qp,
    );
    final dl = api_mod.DocumentEvents.fromJson(jsonDecode(responseBody));
    return mod.DocumentEvents.fromApiModel(dl);
  }
}

/// Provides support for adding common query string parameters.  Values are only included if they
/// are not null.
class _StandardQueryParams {
  final _map = <String, dynamic>{};

  static Map<String, dynamic> get(List<void Function(_StandardQueryParams sqp)> callbacks) {
    final sqp = _StandardQueryParams();
    for (var cb in callbacks) {
      cb(sqp);
    }
    return sqp._map;
  }

  void sortDescending(bool? sortDescending) {
    if (sortDescending != null) {
      _map['sortDescending'] = sortDescending;
    }
  }

  void sortType(String? sortType) {
    if (sortType != null) {
      _map['sortType'] = sortType;
    }
  }

  void offset(int? offset) {
    if (offset != null) {
      _map['offset'] = offset;
    }
  }

  void cursor(String? cursor) {
    if (cursor != null) {
      _map['cursor'] = cursor;
    }
  }
}
