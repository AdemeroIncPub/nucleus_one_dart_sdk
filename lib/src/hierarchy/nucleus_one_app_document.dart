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

/// Performs operations on a specific document.
class NucleusOneAppDocument with NucleusOneAppProjectDependent {
  /// The document's ID.
  final String id;

  /// Creates an instance of the [NucleusOneAppDocument] class.
  ///
  /// [project]: The project to perform task operations on.
  ///
  /// [id]: The document's ID.
  NucleusOneAppDocument({
    NucleusOneAppProject? project,
    required this.id,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets subscription information for the current document.
  Future<DocumentSubscriptionForClient> getSubscription() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentSubscriptionsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
    );
    final apiModel = api_mod.DocumentSubscriptionForClient.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSubscriptionForClient.fromApiModel(apiModel);
    });
  }

  /// Gets the document package for the current document.
  Future<DocumentPackage> getDocumentPackage() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
    );
    final apiModel = api_mod.DocumentPackage.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentPackage.fromApiModel(apiModel);
    });
  }

  /// Updates the document package for the current document.  The document package that was passed
  /// in is returned, as it now exists on the server.
  Future<DocumentPackage> updateDocumentPackage(DocumentPackage documentPackage) async {
    final responseBody = await http.executePutRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      body: jsonEncode(documentPackage.toApiModel()),
    );
    final apiModel = api_mod.DocumentPackage.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentPackage.fromApiModel(apiModel);
    });
  }

  // /// Gets document subscriptions documents, by page.
  // ///
  // /// [sortType]: Which field to sort on.
  // ///
  // /// [sortDescending]: Sort order.
  // ///
  // /// [offset]: The number of initial results to skip.
  // ///
  // /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection, api_mod.DocumentForClientCollection>>
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

  /// Gets comments for the current document, by page.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentCommentCollection, api_mod.DocumentCommentCollection>> getComments({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
        (sqp) => sqp.sortDescending(sortDescending),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentCommentCollection>.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return QueryResult2<DocumentCommentCollection,
          api_mod.DocumentCommentCollection>.fromApiModel(apiModel);
    });
  }

  /// Posts comments on the current document.
  ///
  /// [comments]: The comments to post.
  Future<void> postComments({
    required List<String> comments,
  }) async {
    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsDocumentCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      body: jsonEncode({'Comments': comments}),
    );
  }

  /// Gets events for the current document, by page.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult2<DocumentEventCollection, api_mod.DocumentEventCollection>> getEvents({
    bool sortDescending = true,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
        (sqp) => sqp.sortDescending(sortDescending),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationProjectsDocumentsDocumentEventsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.QueryResult2<api_mod.DocumentEventCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(project.app, () {
      return QueryResult2<DocumentEventCollection, api_mod.DocumentEventCollection>.fromApiModel(
          apiModel);
    });
  }

  /// Gets this content package for the current document.
  ///
  /// [pageIndex]: The starting page of the document to return, if the document has multiple pages.
  Future<DocumentContentPackage> getDocumentContentPackage({
    int pageIndex = 0,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['displayInline'] = 'false';
    qp['preview'] = 'false';
    qp['singlePage'] = 'false';
    qp['requireSinglePage'] = 'false';
    qp['pageIndex'] = pageIndex;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentContentPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      queryParams: qp,
    );
    final apiModel = api_mod.DocumentContentPackage.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
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
  // /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection, api_mod.DocumentForClientCollection>> getRecycleBin({
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
  // /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  // ///
  // /// [singleRecord]: Limits the results to a single document.
  // Future<QueryResult<DocumentForClientCollection, api_mod.DocumentForClientCollection>> getInbox({
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

  /// Updates the current document's name.  The document is returned, as it now exists on the
  /// server.
  ///
  /// [documentName]: The new document name.
  Future<DocumentForClient> updateDocumentName({
    required String documentName,
    // This was intentionally not implemented, since the client doesn't currently use it either
    //required String uniqueId,
  }) async {
    ensureArgumentIsNotEmpty(argumentName: 'documentId', argumentValue: id);
    ensureArgumentIsNotEmpty(argumentName: 'documentName', argumentValue: documentName);

    final doc = api_mod.DocumentForClient()
      ..id = id
      ..name = documentName;
    final responseBody = await http.executePutRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsDocumentFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      body: jsonEncode(doc),
    );
    final apiModel = api_mod.DocumentForClient.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentForClient.fromApiModel(apiModel);
    });
  }

  /// Gets the thumbnail URL of the current document.
  Future<String> getThumbnailUrl() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsThumbnailsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
    );
    return responseBody;
  }

  /// Gets the current document's signature form.  If a signature form does not exist, one is
  /// created.
  Future<DocumentSignatureForm> getOrCreateSignatureForm() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsDocumentSignatureFormsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureForm.fromApiModel(apiModel);
    });
  }

  /// Gets the current document's signature form.
  ///
  /// [signatureFormId]: The signature form ID.
  Future<DocumentSignatureForm> getSignatureForm({
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      app: project.app,
    );
    final apiModel = api_mod.DocumentSignatureForm.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureForm.fromApiModel(apiModel);
    });
  }

  /// Updates the current document's signature form.
  ///
  /// [signatureForm]: The signature form to update.  Should be obtained by calling one of the "get"
  /// signature form methods.
  Future<void> updateSignatureForm({
    required DocumentSignatureForm signatureForm,
  }) async {
    await http.executePutRequest(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureForm.id),
      app: project.app,
      body: jsonEncode(signatureForm.toApiModel()),
    );
  }

  /// Gets the current document's signature form's fields.
  ///
  /// [signatureFormId]: The signature form ID.
  Future<DocumentSignatureFormFieldCollection> getSignatureFormFields({
    required String signatureFormId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      app: project.app,
    );

    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Adds fields to the current document's signature form.  The fields that were passed in are
  /// returned, as they now exists on the server.
  ///
  /// [signatureFormId]: The signature form ID.
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
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      app: project.app,
      queryParams: qp,
      body: jsonEncode(signatureFormFields.toApiModel()),
    );
    final apiModel =
        api_mod.DocumentSignatureFormFieldCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureFormFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Updates a field on the current document's signature form.  The field that was passed in is
  /// returned, as it now exists on the server.
  ///
  /// [signatureFormId]: The signature form ID.
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
      apiRelativeUrlPath: http.ApiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId)
          .replaceDocumentSignatureFormFieldIdPlaceholder(signatureFormField.id),
      app: project.app,
      queryParams: qp,
      body: jsonEncode(signatureFormField.toApiModel()),
    );
    final apiModel = api_mod.DocumentSignatureFormField.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureFormField.fromApiModel(apiModel);
    });
  }

  /// Deletes a field from the current document's signature form.
  ///
  /// [signatureFormId]: The signature form ID.
  ///
  /// [signatureFormField]: The field to delete.
  Future<void> deleteSignatureFormField({
    required String signatureFormId,
    required String signatureFormFieldId,
  }) async {
    await http.executeDeleteRequest(
      apiRelativeUrlPath: http.ApiPaths
          .organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsdocumentSignatureFormFieldFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId)
          .replaceDocumentSignatureFormFieldIdPlaceholder(signatureFormFieldId),
      app: project.app,
    );
  }

  /// Deletes all fields from the current document's signature form.
  ///
  /// [signatureFormId]: The signature form ID.
  Future<void> deleteAllSignatureFormFields({
    required String signatureFormId,
  }) async {
    await http.executeDeleteRequest(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsSignatureFormsDocumentSignatureFormFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id)
          .replaceDocumentSignatureFormIdPlaceholder(signatureFormId),
      app: project.app,
    );
  }

  /// Gets the current document's signature session packages.  If a session does not exist, one is
  /// created.
  Future<DocumentSignatureSessionPackage> getSignatureSessionPackage() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
    );
    final apiModel = api_mod.DocumentSignatureSessionPackage.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureSessionPackage.fromApiModel(apiModel);
    });
  }

  /// Updates the current document's signature session packages.  A list of the same packages that
  /// were passed in are returned, as they now exist on the server.
  ///
  /// [packages]: The signature session packages to update.  An instance of this should first be
  /// retrieved by calling the [getSignatureSessionPackage] method.
  Future<DocumentSignatureSessionPackageCollection> updateSignatureSessionPackages({
    required DocumentSignatureSessionPackageCollection packages,
  }) async {
    final responseBody = await http.executePutRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsSignatureSessionPackagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceDocumentIdPlaceholder(id),
      app: project.app,
      body: jsonEncode(packages.toApiModel()),
    );
    final apiModel = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
        jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureSessionPackageCollection.fromApiModel(apiModel);
    });
  }
}

/// Performs document operations.
class NucleusOneAppDocuments with NucleusOneAppProjectDependent {
  /// Creates an instance of the [NucleusOneAppDocuments] class.
  ///
  /// [project]: The project to perform task operations on.
  NucleusOneAppDocuments({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Restores one or more documents from the Recycle Bin.
  ///
  /// [documentIds]: The document IDs to process.
  Future<void> restoreFromRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentActionsRestoreFromRecycleBinFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Sends one or more documents to the Recycle Bin.
  ///
  /// [documentIds]: The document IDs to process.
  Future<void> sendToRecycleBin(List<String> documentIds) async {
    assert(documentIds.isNotEmpty);

    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentActionsSendToRecycleBinFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      body: jsonEncode({'IDs': documentIds}),
    );
  }

  /// Gets the signing package for a document's signature signing session.
  ///
  /// [signatureSessionId]: The signature session ID.
  ///
  /// [signatureSessionRecipientId]: The recipient's ID.
  ///
  /// [signatureSessionRecipientUniqueId]: The recipient's unique ID.
  ///
  /// [skipFormFieldPackage]: If true, the [DocumentSignatureSessionSigningRecipientPackage.formFieldPackage]
  /// property is not populated in the results.
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
      apiRelativeUrlPath: http.ApiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder(signatureSessionId)
          .replaceDocumentSignatureSessionRecipientIdPlaceholder(signatureSessionRecipientId),
      app: project.app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.DocumentSignatureSessionSigningRecipientPackage.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return DocumentSignatureSessionSigningRecipientPackage.fromApiModel(apiModel);
    });
  }

  /// Signs a document that has an existing signature session.
  ///
  /// [signatureSessionId]: The document's signature session ID.
  ///
  /// [signatureSessionRecipientId]: The recipient's ID.
  ///
  /// [signatureSessionRecipientUniqueId]: The recipient's unique ID.
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
      apiRelativeUrlPath: http.ApiPaths.documentSignatureSessionsSigningRecipientsFieldsFormat
          .replaceDocumentSignatureSessionIdPlaceholder(signatureSessionId)
          .replaceDocumentSignatureSessionRecipientIdPlaceholder(signatureSessionRecipientId),
      app: project.app,
      queryParams: qp,
      body: jsonEncode(fields.toApiModel()),
    );
  }
}
