import 'dart:async';
import 'dart:convert';

import 'api_model/recent_documents.dart' as api_mod;
import 'http.dart' as http;
import 'model/recent_documents.dart' as mod;
import 'nucleus_one.dart';

class Document with NucleusOneAppDependent {
  Document({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
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

  /*
  Future<void> getRecent() async {
    final qp = {
      'sortDescending': false,
      'sortType': '',
      'offset': 0,
      'cursor': '',
      'singleRecord': false,
      
      'inbox': false,
      'recycleBin': false,
      'documentApprovals': false,
        // 'showForAllInProject': false,
        // 'documentApprovalsByRole': false,
        'processID', '',
        'processElementID', '',
      'documentSubscriptions': false,
      'documentSignatureSessionRecipients': false,
        'showForAllTenantMembers': false,
    };
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documents,
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }
  */

  Future<mod.RecentDocuments> getRecent([
    String sortType = 'CreatedOn',
    bool sortDescending = true,
  ]) async {
    return _getRecentInternal(sortType, sortDescending);
  }

  Future<mod.RecentDocuments> getApprovalsRecent([
    String sortType = 'CreatedOn',
    bool sortDescending = true,
  ]) async {
    return _getRecentInternal(sortType, sortDescending, {
      'documentApprovals': true,
    });
  }

  Future<mod.RecentDocuments> getInboxRecent([
    String sortType = 'CreatedOn',
    bool sortDescending = true,
  ]) async {
    return _getRecentInternal(sortType, sortDescending, {
      'inbox': true,
    });
  }

  // Future<mod.RecentDocuments> getNeedSignatureRecent([
  //   String sortType = 'CreatedOn',
  //   bool sortDescending = true,
  // ]) async {
  //   return _getRecentInternal(sortType, sortDescending, {
  //     'documentSignatureSessionRecipients': true,
  //     'showForAllTenantMembers': this.props.isAdmin
  //   });
  // }

  Future<mod.RecentDocuments> getDocumentSubscriptionsRecent([
    String sortType = 'CreatedOn',
    bool sortDescending = true,
  ]) async {
    return _getRecentInternal(sortType, sortDescending, {
      'documentSubscriptions': true,
    });
  }

  Future<mod.RecentDocuments> _getRecentInternal([
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    Map<String, Object>? qpAdditional,
  ]) async {
    final qp = {
      'sortType': sortType,
      'sortDescending': sortDescending,
    };
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
