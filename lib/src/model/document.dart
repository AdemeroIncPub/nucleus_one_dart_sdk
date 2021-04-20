import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/document.dart' as api_mod;
import '../api_model/recent_documents.dart' as api_mod;
import '../http.dart' as http;
import '../model/recent_documents.dart' as mod;
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

  Future<mod.RecentDocuments> getRecent({
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

  Future<mod.RecentDocuments> getApprovalsRecent({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
    bool? showForAllInProject,
    String? processID,
    String? processElementID,
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

  Future<mod.RecentDocuments> getInboxRecent({
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

  Future<mod.RecentDocuments> getRecycleBinRecent({
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

  // Future<mod.RecentDocuments> getNeedSignatureRecent({
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

  Future<mod.RecentDocuments> getDocumentSubscriptionsRecent({
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

  Future<mod.RecentDocuments> _getRecentInternal({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? singleRecord,
    Map<String, Object>? qpAdditional,
  }) async {
    final qp = {
      'sortType': sortType,
      'sortDescending': sortDescending,
    };
    if ((offset != null) && (offset >= 0)) {
      qp['offset'] = offset;
    }
    if (cursor != null) {
      qp['cursor'] = cursor;
    }
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
    final dl = api_mod.RecentDocuments.fromJson(jsonDecode(responseBody));
    return mod.RecentDocuments.fromApiModel(dl);
  }
}
