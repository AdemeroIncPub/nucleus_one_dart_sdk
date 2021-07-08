import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/document_content_package.dart' as api_mod;
import '../api_model/document_event.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_for_client.dart' as api_mod;
import '../api_model/document_package.dart' as api_mod;
import '../api_model/document_results.dart' as api_mod;
import '../api_model/document_signature_form.dart' as api_mod;
import '../api_model/document_signature_form_field.dart' as api_mod;
import '../api_model/document_signature_session.dart' as api_mod;
import '../api_model/document_signature_session_signing_recipient_package.dart' as api_mod;
import '../api_model/document_subscription_for_client.dart' as api_mod;
import '../api_model/document_comment.dart' as api_mod;
import '../api_model/document_upload.dart' as api_mod;
import '../api_model/signature_form_template.dart' as api_mod;
import '../common/model.dart';
import '../common/validation.dart';
import '../http.dart' as http;
import '../model/document_for_client.dart';
import '../model/document_package.dart';
import '../model/document_subscription_for_client.dart';
import '../model/document_upload.dart';
import '../nucleus_one.dart';

class NucleusOneAppDocuments with NucleusOneAppDependent {
  NucleusOneAppDocuments({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets a Document Upload.
  Future<DocumentUpload> getDocumentUpload() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentUploads,
      app,
    );
    final apiModel = api_mod.DocumentUpload.fromJson(jsonDecode(responseBody));
    return DocumentUpload.fromApiModel(apiModel);
  }

  /// Gets subscriptions to a document.
  ///
  /// [documentId]: The id of the document.
  Future<DocumentSubscriptionForClient> getSubscription(String documentId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentSubscriptionsFormat.replaceFirst('<documentId>', documentId),
      app,
    );
    final apiModel = api_mod.DocumentSubscriptionForClient.fromJson(jsonDecode(responseBody));
    return DocumentSubscriptionForClient.fromApiModel(apiModel);
  }

  /// Gets the document count within the Recycle Bin Inbox.
  ///
  Future<int> getRecycleBinInboxDocumentCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.recycleBinInboxCounts,
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets the page count.
  ///
  Future<int> getPageCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.pageCounts,
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets the document count within the Recycle Bin.
  ///
  Future<int> getRecycleBinDocumentCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.recycleBinDocumentCounts,
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets the document count within the Inbox.
  ///
  /// [ignoreRecycleBin]: Whether results should contain documents from the Recycle Bin.
  Future<int> getInboxDocumentCount(bool ignoreRecycleBin) async {
    final qp = {
      'ignoreRecycleBin': ignoreRecycleBin,
    };
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.inboxCounts,
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }

  /// Gets the document count.
  ///
  /// [ignoreInbox]: Whether results should contain documents from the Inbox.
  ///
  /// [ignoreRecycleBin]: Whether results should contain documents from the Recycle Bin.
  Future<int> getDocumentCount(bool ignoreInbox, bool ignoreRecycleBin) async {
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

  /// Updates a document's name.  The document is returned, as it now exists on the server.
  ///
  /// [documentId]: The document id.
  ///
  /// [documentName]: The new document name.
  Future<DocumentForClient> updateDocumentName({
    required String documentId,
    required String documentName,
    // This was intentionally not implemented, since the client doesn't currently use it either
    //required String uniqueId,
  }) async {
    ensureArgumentIsNotEmpty('documentId', documentId);
    ensureArgumentIsNotEmpty('documentName', documentName);

    final doc = api_mod.DocumentForClient()
      ..id = documentId
      ..name = documentName;
    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.documentsFormat.replaceFirst('<documentId>', documentId),
      app,
      body: jsonEncode(doc),
    );
    final apiModel = api_mod.DocumentForClient.fromJson(jsonDecode(responseBody));
    return DocumentForClient.fromApiModel(apiModel);
  }

  /// Gets a document's thumbnail URL.
  ///
  /// [documentId]: The id of the document.
  Future<String> getThumbnailUrl(String documentId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsThumbnailsFormat.replaceFirst('<documentId>', documentId),
      app,
    );
    return responseBody;
  }

  /// Gets a document's signature form.  If a signature form does not exist for the document, one is
  /// created.
  ///
  /// [documentId]: The document id.
  Future<DocumentSignatureForm> getOrCreateSignatureForm(String documentId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsSignatureFormsFormat.replaceFirst('<documentId>', documentId),
      app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return DocumentSignatureForm.fromApiModel(apiModel);
  }

  /// Gets a document's signature form.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  Future<DocumentSignatureForm> getSignatureForm({
    required String documentId,
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsSignatureFormsByIdFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId),
      app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return DocumentSignatureForm.fromApiModel(apiModel);
  }

  /// Updates a document's signature form.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureForm]: The signature form to update.  Should be obtained by calling one of the "get"
  /// signature form methods.
  Future<void> updateSignatureForm({
    required String documentId,
    required DocumentSignatureForm signatureForm,
  }) async {
    await http.executePutRequest(
      http.apiPaths.documentsSignatureFormsByIdFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureForm.id),
      app,
      body: jsonEncode(signatureForm.toApiModel()),
    );
  }

  /// Gets a document's signature form's fields.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  Future<DocumentSignatureFormFieldCollection> getSignatureFormFields({
    required String documentId,
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId),
      app,
    );
    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecode(responseBody));
    return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
  }

  /// Adds fields to a document's signature form.  The field that were passed in are returned, as
  /// they now exists on the server.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormFields]: The fields to add.
  ///
  /// [clearExisting]: If true, existing form fields will be deleted.
  Future<DocumentSignatureFormFieldCollection> addSignatureFormFields({
    required String documentId,
    required String signatureFormId,
    required DocumentSignatureFormFieldCollection signatureFormFields,
    bool clearExisting = false,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['clearExisting'] = clearExisting;

    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId),
      app,
      query: qp,
      body: jsonEncode(signatureFormFields.toApiModel()),
    );
    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecode(responseBody));
    return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
  }

  /// Updates a field to a document's signature form.  The field that was passed in is returned, as
  /// it now exists on the server.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormField]: The field to update.
  ///
  /// [clearExisting]: If true, existing form fields will be deleted.
  Future<DocumentSignatureFormField> updateSignatureFormField({
    required String documentId,
    required String signatureFormId,
    required DocumentSignatureFormField signatureFormField,
    bool clearExisting = false,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['clearExisting'] = clearExisting;

    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.documentsSignatureFormsByIdFieldsByFieldIdFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId)
          .replaceFirst('<documentSignatureFormFieldId>', signatureFormField.id),
      app,
      query: qp,
      body: jsonEncode(signatureFormField.toApiModel()),
    );
    final apiModel = api_mod.DocumentSignatureFormField.fromJson(jsonDecode(responseBody));
    return DocumentSignatureFormField.fromApiModel(apiModel);
  }

  /// Deletes a field from a document's signature form.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  ///
  /// [signatureFormField]: The field to delete.
  Future<void> deleteSignatureFormField({
    required String documentId,
    required String signatureFormId,
    required String signatureFormFieldId,
  }) async {
    await http.executeDeleteRequest(
      http.apiPaths.documentsSignatureFormsByIdFieldsByFieldIdFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId)
          .replaceFirst('<documentSignatureFormFieldId>', signatureFormFieldId),
      app,
    );
  }

  /// Deletes all fields from a document's signature form.
  ///
  /// [documentId]: The document id.
  ///
  /// [signatureFormId]: The signature form id.
  Future<void> deleteAllSignatureFormFields({
    required String documentId,
    required String signatureFormId,
  }) async {
    await http.executeDeleteRequest(
      http.apiPaths.documentsSignatureFormsByIdFieldsFormat
          .replaceFirst('<documentId>', documentId)
          .replaceFirst('<documentSignatureFormId>', signatureFormId),
      app,
    );
  }

  /// Gets a document's signature session packages.  If a session does not exist, one is created.
  ///
  /// [documentId]: The document id.
  Future<DocumentSignatureSessionPackage> getSignatureSessionPackage({
    required String documentId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentsSignatureSessionPackagesFormat
          .replaceFirst('<documentId>', documentId),
      app,
    );
    final apiModel = api_mod.DocumentSignatureSessionPackage.fromJson(jsonDecode(responseBody));
    return DocumentSignatureSessionPackage.fromApiModel(apiModel);
  }

  /// Updates a document's signature session packages.  A list of the same packages that were passed
  /// in are returned, as they now exist on the server.
  ///
  /// [documentId]: The document id.
  ///
  /// [packages]: The signature session packages to update.  An instance of this should first be
  /// retrieved by calling the [getSignatureSessionPackage] method.
  Future<DocumentSignatureSessionPackageCollection> updateSignatureSessionPackages({
    required String documentId,
    required DocumentSignatureSessionPackageCollection packages,
  }) async {
    final responseBody = await http.executePutRequestWithTextResponse(
      http.apiPaths.documentsSignatureSessionPackagesFormat
          .replaceFirst('<documentId>', documentId),
      app,
      body: jsonEncode(packages.toApiModel()),
    );
    final apiModel =
        api_mod.DocumentSignatureSessionPackageCollection.fromJson(jsonDecode(responseBody));
    return DocumentSignatureSessionPackageCollection.fromApiModel(apiModel);
  }

  /// Gets a recent document signature forms.
  ///
  /// [docNameStartsWith]: The value that the document name starts with.
  ///
  /// [excludingId]: The id of a signature form to exclude from the results.
  Future<DocumentSignatureFormCollection> getRecentSignatureForms({
    String? docNameStartsWith,
    String? excludingId,
  }) async {
    final qp = http.StandardQueryParams.get();
    if (docNameStartsWith != null) {
      qp['nameFilter'] = docNameStartsWith;
    }
    if (excludingId != null) {
      qp['excludingId'] = excludingId;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentSignatureFormsRecent,
      app,
      query: qp,
    );
    final apiModel = api_mod.DocumentSignatureFormCollection.fromJson(jsonDecode(responseBody));
    return DocumentSignatureFormCollection.fromApiModel(apiModel);
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
          .replaceFirst('<documentSignatureSessionId>', signatureSessionId)
          .replaceFirst('<documentSignatureSessionRecipientId>', signatureSessionRecipientId),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.DocumentSignatureSessionSigningRecipientPackage.fromJson(jsonDecode(responseBody));
    return DocumentSignatureSessionSigningRecipientPackage.fromApiModel(apiModel);
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
          .replaceFirst('<documentSignatureSessionId>', signatureSessionId)
          .replaceFirst('<documentSignatureSessionRecipientId>', signatureSessionRecipientId),
      app,
      query: qp,
      body: jsonEncode(fields.toApiModel()),
    );
  }

  /// Gets signature form templates.
  Future<SignatureFormTemplateCollection> getSignatureFormTemplates() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.signatureFormTemplates,
      app,
    );
    final apiModel = api_mod.SignatureFormTemplateCollection.fromJson(jsonDecode(responseBody));
    return SignatureFormTemplateCollection.fromApiModel(apiModel);
  }

  /// Adds signature form templates.  A list of the same templates that were passed in are returned,
  /// as they now exist on the server.
  ///
  /// [templates] The signature form templates.
  Future<SignatureFormTemplateCollection> addSignatureFormTemplates(
      SignatureFormTemplateCollection templates) async {
    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.signatureFormTemplates,
      app,
      body: jsonEncode(templates.toApiModel()),
    );
    final apiModel = api_mod.SignatureFormTemplateCollection.fromJson(jsonDecode(responseBody));
    return SignatureFormTemplateCollection.fromApiModel(apiModel);
  }

  /// Updates a signature form template.
  ///
  /// [templateId] The signature form template id.
  ///
  /// [template] The signature form template.
  Future<void> updateSignatureFormTemplate({
    required String templateId,
    required SignatureFormTemplate template,
  }) async {
    await http.executePutRequest(
      http.apiPaths.signatureFormTemplatesFormat
          .replaceFirst('<signatureFormTemplateId>', templateId),
      app,
      body: jsonEncode(template.toApiModel()),
    );
  }

  /// Deletes a signature form template.
  ///
  /// [templateId] The signature form template id.
  Future<void> deleteSignatureFormTemplate(templateId) async {
    await http.executeDeleteRequest(
      http.apiPaths.signatureFormTemplatesFormat
          .replaceFirst('<signatureFormTemplateId>', templateId),
      app,
    );
  }

  /// Gets signature form templates.
  ///
  /// [templateId] The signature form template id.
  Future<SignatureFormTemplateFieldCollection> getSignatureFormTemplateFields(
      String templateId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.signatureFormTemplatesFieldsFormat
          .replaceFirst('<signatureFormTemplateId>', templateId),
      app,
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
  }

  /// Adds fields to a signature form template.  The field that were passed in are returned, as they
  /// now exists on the server.
  ///
  /// [templateId] The signature form template id.
  ///
  /// [fields] The fields to add.
  ///
  /// [clearExisting]: If true, existing fields will be deleted.
  Future<SignatureFormTemplateFieldCollection> addSignatureFormTemplateFields({
    required String templateId,
    required SignatureFormTemplateFieldCollection fields,
    bool clearExisting = false,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['clearExisting'] = clearExisting;

    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.signatureFormTemplatesFieldsFormat
          .replaceFirst('<signatureFormTemplateId>', templateId),
      app,
      query: qp,
      body: jsonEncode(fields.toApiModel()),
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
  }
}
