import 'dart:convert';

import '../api_model/document_content_package.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_for_client.dart' as api_mod;
import '../api_model/document_package.dart' as api_mod;
import '../api_model/document_signature_form.dart' as api_mod;
import '../api_model/document_signature_form_field.dart' as api_mod;
import '../api_model/document_signature_session.dart' as api_mod;
import '../api_model/document_signature_session_signing_recipient_package.dart' as api_mod;
import '../api_model/document_subscription_for_client.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../common/validation.dart';
import '../http.dart' as http;
import '../model/document_comment.dart';
import '../model/document_content_package.dart';
import '../model/document_event.dart';
import '../model/document_for_client.dart';
import '../model/document_package.dart';
import '../model/document_signature_form.dart';
import '../model/document_signature_form_field.dart';
import '../model/document_signature_session.dart';
import '../model/document_signature_session_signing_recipient_package.dart';
import '../model/document_subscription_for_client.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';

class NucleusOneAppDocument with NucleusOneAppProjectDependent {
  final String id;

  NucleusOneAppDocument({
    NucleusOneAppProject? project,
    required this.id,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets subscription to a document.
  Future<DocumentSubscriptionForClient> getSubscription() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentSubscriptionsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
    );
    final apiModel = api_mod.DocumentSubscriptionForClient.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSubscriptionForClient.fromApiModel(apiModel);
    });
  }

  /// Gets the document package for the current document.
  ///
  /// [documentId]: The id of the document.
  Future<DocumentPackage> getDocumentPackage() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
    );
    final apiModel = api_mod.DocumentPackage.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentPackage.fromApiModel(apiModel);
    });
  }

  // /// Gets Document Subscriptions documents, by page.
  // ///
  // /// [sortType]: Which field to sort on.
  // ///
  // /// [sortDescending]: Sort order.
  // ///
  // /// [offset]: The number of initial results to skip.
  // ///
  // /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection>>
  //     getDocumentSubscriptions({
  //   String sortType = 'CreatedOn',
  //   bool sortDescending = true,
  //   int? offset,
  //   String? cursor,
  //   bool? singleRecord,
  // }) async {
  //   return _getDocumentsInternal(
  //     sortType: sortType,
  //     sortDescending: sortDescending,
  //     offset: offset,
  //     cursor: cursor,
  //     singleRecord: singleRecord,
  //     qpAdditional: {
  //       'documentSubscriptions': true,
  //     },
  //   );
  // }

  /// Gets comments for this document, by page.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentCommentCollection>> getComments({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentCommentCollection>.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentCommentCollectionQueryResult.fromApiModelDocumentCommentCollection(apiModel);
    });
  }

  /// Posts comments for this document.
  ///
  /// [comments]: The comments to post.
  Future<void> postComments({
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      http.apiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      body: jsonEncode({'Comments': comments}),
    );
  }

  /// Gets events for this document, by page.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentEventCollection>> getEvents({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationProjectsDocumentsDocumentEventsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentEventCollection>.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(project.app, () {
      return DocumentEventCollectionQueryResult.fromApiModelDocumentEventCollection(apiModel);
    });
  }

  /// Gets this document's content package.
  Future<DocumentContentPackage> getDocumentContentPackage() async {
    final qp = http.StandardQueryParams.get();
    qp['displayInline'] = 'false';
    qp['preview'] = 'false';
    qp['singlePage'] = 'false';
    qp['requireSinglePage'] = 'false';
    qp['pageIndex'] = '0';

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentContentPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
      query: qp,
    );
    final apiModel = api_mod.DocumentContentPackage.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentContentPackage.fromApiModel(apiModel);
    });
  }

  // /// Gets Recycle Bin documents, by page.
  // ///
  // /// [sortType]: Which field to sort on.
  // ///
  // /// [sortDescending]: Sort order.
  // ///
  // /// [offset]: The number of initial results to skip.
  // ///
  // /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection>> getRecycleBin({
  //   String sortType = 'CreatedOn',
  //   bool sortDescending = true,
  //   int? offset,
  //   String? cursor,
  //   bool? singleRecord,
  // }) async {
  //   return _getDocumentsInternal(
  //     sortType: sortType,
  //     sortDescending: sortDescending,
  //     offset: offset,
  //     cursor: cursor,
  //     singleRecord: singleRecord,
  //     qpAdditional: {
  //       'recycleBin': true,
  //     },
  //   );
  // }

  // /// Gets Inbox documents, by page.
  // ///
  // /// [sortType]: Which field to sort on.
  // ///
  // /// [sortDescending]: Sort order.
  // ///
  // /// [offset]: The number of initial results to skip.
  // ///
  // /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection>> getInbox({
  //   String sortType = 'CreatedOn',
  //   bool sortDescending = true,
  //   int? offset,
  //   String? cursor,
  //   bool? singleRecord,
  // }) async {
  //   return _getDocumentsInternal(
  //     sortType: sortType,
  //     sortDescending: sortDescending,
  //     offset: offset,
  //     cursor: cursor,
  //     singleRecord: singleRecord,
  //     qpAdditional: {
  //       'inbox': true,
  //     },
  //   );
  // }

  /// Updates a document's name.  The document is returned, as it now exists on the server.
  ///
  /// [documentName]: The new document name.
  Future<DocumentForClient> updateDocumentName({
    required String documentName,
    // This was intentionally not implemented, since the client doesn't currently use it either
    //required String uniqueId,
  }) async {
    ensureArgumentIsNotEmpty('documentId', id);
    ensureArgumentIsNotEmpty('documentName', documentName);

    final doc = api_mod.DocumentForClient()
      ..id = id
      ..name = documentName;
    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
      body: jsonEncode(doc),
    );
    final apiModel = api_mod.DocumentForClient.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentForClient.fromApiModel(apiModel);
    });
  }

  /// Gets the thumbnail URL for the current document.
  Future<String> getThumbnailUrl() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsThumbnailsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
    );
    return responseBody;
  }

  /// Gets a document's signature form.  If a signature form does not exist for the document, one is
  /// created.
  Future<DocumentSignatureForm> getOrCreateSignatureForm() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsDocumentSignatureFormsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureForm.fromApiModel(apiModel);
    });
  }

  /// Gets a document's signature form.
  ///
  /// [signatureFormId]: The signature form id.
  Future<DocumentSignatureForm> getSignatureForm({
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      project.app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureForm.fromApiModel(apiModel);
    });
  }

  /// Updates a document's signature form.
  ///
  /// [signatureForm]: The signature form to update.  Should be obtained by calling one of the "get"
  /// signature form methods.
  Future<void> updateSignatureForm({
    required DocumentSignatureForm signatureForm,
  }) async {
    await http.executePutRequest(
      http.apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureForm.id),
      project.app,
      body: jsonEncode(signatureForm.toApiModel()),
    );
  }

  /// Gets a document's signature form's fields.
  ///
  /// [signatureFormId]: The signature form id.
  Future<DocumentSignatureFormFieldCollection> getSignatureFormFields({
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      project.app,
    );
    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Adds fields to a document's signature form.  The field that were passed in are returned, as
  /// they now exists on the server.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormFields]: The fields to add.
  ///
  /// [clearExisting]: If true, existing form fields will be deleted.
  Future<DocumentSignatureFormFieldCollection> addSignatureFormFields({
    required String signatureFormId,
    required DocumentSignatureFormFieldCollection signatureFormFields,
    bool clearExisting = false,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['clearExisting'] = clearExisting;

    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      project.app,
      query: qp,
      body: jsonEncode(signatureFormFields.toApiModel()),
    );
    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Updates a field to a document's signature form.  The field that was passed in is returned, as
  /// it now exists on the server.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormField]: The field to update.
  ///
  /// [clearExisting]: If true, existing form fields will be deleted.
  Future<DocumentSignatureFormField> updateSignatureFormField({
    required String signatureFormId,
    required DocumentSignatureFormField signatureFormField,
    bool clearExisting = false,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['clearExisting'] = clearExisting;

    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId)
          .replaceDocumentSignatureFormFieldIdPlaceholder(signatureFormField.id),
      project.app,
      query: qp,
      body: jsonEncode(signatureFormField.toApiModel()),
    );
    final apiModel = api_mod.DocumentSignatureFormField.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureFormField.fromApiModel(apiModel);
    });
  }

  /// Deletes a field from a document's signature form.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormField]: The field to delete.
  Future<void> deleteSignatureFormField({
    required String signatureFormId,
    required String signatureFormFieldId,
  }) async {
    await http.executeDeleteRequest(
      http.apiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId)
          .replaceDocumentSignatureFormFieldIdPlaceholder(signatureFormFieldId),
      app: project.app,
    );
  }

  /// Deletes all fields from a document's signature form.
  ///
  /// [signatureFormId]: The signature form id.
  Future<void> deleteAllSignatureFormFields({
    required String signatureFormId,
  }) async {
    await http.executeDeleteRequest(
      http.apiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      app: project.app,
    );
  }

  /// Gets a document's signature session packages.  If a session does not exist, one is created.
  Future<DocumentSignatureSessionPackage> getSignatureSessionPackage() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
    );
    final apiModel = api_mod.DocumentSignatureSessionPackage.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureSessionPackage.fromApiModel(apiModel);
    });
  }

  /// Updates a document's signature session packages.  A list of the same packages that were passed
  /// in are returned, as they now exist on the server.
  ///
  /// [packages]: The signature session packages to update.  An instance of this should first be
  /// retrieved by calling the [getSignatureSessionPackage] method.
  Future<DocumentSignatureSessionPackageCollection> updateSignatureSessionPackages({
    required DocumentSignatureSessionPackageCollection packages,
  }) async {
    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceDocumentIdPlaceholder(id),
      project.app,
      body: jsonEncode(packages.toApiModel()),
    );
    final apiModel =
        api_mod.DocumentSignatureSessionPackageCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureSessionPackageCollection.fromApiModel(apiModel);
    });
  }
}

class NucleusOneAppDocuments with NucleusOneAppProjectDependent {
  NucleusOneAppDocuments({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Restores one or more documents from the Recycle Bin.
  ///
  /// [documentIds]: The document ids to process.
  Future<void> restoreFromRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      http.apiPaths.organizationsProjectsDocumentActionsRestoreFromRecycleBinFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app: project.app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Sends one or more documents to the Recycle Bin.
  ///
  /// [documentIds]: The document ids to process.
  Future<void> sendToRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      http.apiPaths.organizationsProjectsDocumentActionsSendToRecycleBinFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app: project.app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Gets the signing package for a document's signature signing session.
  ///
  /// [signatureSessionId]: The signature session id.
  ///
  /// [signatureSessionRecipientId]: The recipient's id.
  ///
  /// [signatureSessionRecipientUniqueId]: The recipient's unique id.
  ///
  /// [skipFormFieldPackage]: If true, the [formFieldPackage] property is not populated in the results.
  ///
  /// [accessCode]: The access code required to access the form field package.  If [skipFormFieldPackage]
  /// is true, this parameter is ignored.
  ///
  /// [pageIndex]: The index of the document page of which the signing package should be retrieved.
  /// This is zero based.
  Future<DocumentSignatureSessionSigningRecipientPackage>
      getDocumentSignatureSessionSigningRecipientPackage({
    required String signatureSessionId,
    required String signatureSessionRecipientId,
    required String signatureSessionRecipientUniqueId,
    bool? skipFormFieldPackage,
    String? accessCode,
    int? pageIndex,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = signatureSessionRecipientUniqueId;
    if (skipFormFieldPackage != null) {
      qp['skipFormFieldPackage'] = skipFormFieldPackage;
    }
    if (accessCode != null) {
      qp['accessCode'] = accessCode;
    }
    if (pageIndex != null) {
      qp['pageIndex'] = pageIndex;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder(signatureSessionId)
          .replaceDocumentSignatureSessionRecipientIdPlaceholder(signatureSessionRecipientId),
      project.app,
      query: qp,
    );
    final apiModel =
        api_mod.DocumentSignatureSessionSigningRecipientPackage.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(project.app, () {
      return DocumentSignatureSessionSigningRecipientPackage.fromApiModel(apiModel);
    });
  }

  /// Signs a document that has an existing signature session.
  ///
  /// [signatureSessionId]: The document's signature session id.
  ///
  /// [signatureSessionRecipientId]: The recipient's id.
  ///
  /// [signatureSessionRecipientUniqueId]: The recipient's unique id.
  ///
  /// [fields]: The field values to sign with.  The list of fields can be retrieved by first calling
  /// the [getDocumentSignatureSessionSigningRecipientPackage] method.
  Future<void> signDocument({
    required String signatureSessionId,
    required String signatureSessionRecipientId,
    required String signatureSessionRecipientUniqueId,
    required DocumentSignatureSessionRecipientFormFieldCollection fields,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = signatureSessionRecipientUniqueId;

    await http.executePutRequest(
      http.apiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder(signatureSessionId)
          .replaceDocumentSignatureSessionRecipientIdPlaceholder(signatureSessionRecipientId),
      project.app,
      query: qp,
      body: jsonEncode(fields.toApiModel()),
    );
  }
}
