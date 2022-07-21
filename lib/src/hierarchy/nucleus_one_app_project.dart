import 'dart:convert';

import '../api_model/document.dart' as api_mod;
import '../api_model/document_signature_form.dart' as api_mod;
import '../api_model/document_upload.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/signature_form_template.dart' as api_mod;
import '../common/model.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../common/string.dart';
import '../model/document.dart';
import '../model/document_signature_form.dart';
import '../model/document_upload.dart';
import '../model/folder_hierarchies.dart';
import '../model/form_template.dart';
import '../model/query_result.dart';
import '../model/signature_form_template.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_approvals.dart';
import 'nucleus_one_app_document.dart';
import 'nucleus_one_app_forms.dart';
import 'nucleus_one_app_organization.dart';
import 'nucleus_one_app_task.dart';

class NucleusOneAppProject with NucleusOneAppDependent {
  final NucleusOneAppOrganization organization;
  final String id;

  NucleusOneAppProject({
    required this.organization,
    required this.id,
  }) {
    app = organization.app;

    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
  }

  /// Approvals
  NucleusOneAppApprovals approvals() {
    return NucleusOneAppApprovals(
      project: this,
    );
  }

  /// Folder Hierarchies
  FolderHierarchyCollection folderHierarchies() {
    return FolderHierarchyCollection(project: this);
  }

  /// Folder Hierarchy Items
  FolderHierarchyItemCollection folderHierarchyItems() {
    return FolderHierarchyItemCollection(project: this);
  }

  /// FormTemplates
  FormTemplateCollection formTemplates() {
    return FormTemplateCollection(project: this);
  }

  /// Documents
  NucleusOneAppDocuments documents() {
    return NucleusOneAppDocuments(
      project: this,
    );
  }

  /// Document
  NucleusOneAppDocument document(String id) {
    return NucleusOneAppDocument(
      project: this,
      id: id,
    );
  }

  /// Gets documents, by page.
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
  Future<QueryResult<DocumentCollection>> getDocuments({
    bool? showAll,
    String? documentFolderId,
    String? documentGroupId,
    String? cursor,
  }) async {
    return _getDocumentsInternal(
      showAll: showAll,
      documentFolderId: documentFolderId,
      documentGroupId: documentGroupId,
      cursor: cursor,
    );
  }

  /// Forms
  NucleusOneAppForms forms() {
    return NucleusOneAppForms(
      project: this,
    );
  }

  /// Task
  NucleusOneAppTasks tasks() {
    return NucleusOneAppTasks(
      project: this,
    );
  }

  /// Task
  NucleusOneAppTask task(String id) {
    return NucleusOneAppTask(
      project: this,
      id: id,
    );
  }

  /// Gets the document count within the Recycle Bin.
  ///
  Future<int> getRecycleBinDocumentCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsCountsRecycleBinDocumentsFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
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
      http.apiPaths.organizationsProjectsCountsDocumentsFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }

  /// Gets the page count.
  ///
  Future<int> getPageCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsCountsPagesFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets signature form templates.
  Future<SignatureFormTemplateCollection> getSignatureFormTemplates() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
    );
    final apiModel = api_mod.SignatureFormTemplateCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SignatureFormTemplateCollection.fromApiModel(apiModel);
    });
  }

  /// Adds signature form templates.  A list of the same templates that were passed in are returned,
  /// as they now exist on the server.
  ///
  /// [templates] The signature form templates.
  Future<SignatureFormTemplateCollection> addSignatureFormTemplates(
      SignatureFormTemplateCollection templates) async {
    final responseBody = await http.executePostRequestWithTextResponse(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
      body: jsonEncode(templates.toApiModel()),
    );
    final apiModel = api_mod.SignatureFormTemplateCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SignatureFormTemplateCollection.fromApiModel(apiModel);
    });
  }

  /// Updates a signature form template.
  ///
  /// [templateId]: The signature form template id.
  ///
  /// [template]: The signature form template.
  Future<void> updateSignatureFormTemplate({
    required String templateId,
    required SignatureFormTemplate template,
  }) async {
    await http.executePutRequest(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app,
      body: jsonEncode(template.toApiModel()),
    );
  }

  /// Deletes a signature form template.
  ///
  /// [templateId] The signature form template id.
  Future<void> deleteSignatureFormTemplate({
    required String templateId,
  }) async {
    await http.executeDeleteRequest(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app: app,
    );
  }

  /// Gets signature form templates.
  ///
  /// [templateId]: The signature form template id.
  Future<SignatureFormTemplateFieldCollection> getSignatureFormTemplateFields({
    required String templateId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app,
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Adds fields to a signature form template.  The field that were passed in are returned, as they
  /// now exists on the server.
  ///
  /// [templateId]: The signature form template id.
  ///
  /// [fields]: The fields to add.
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
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app,
      query: qp,
      body: jsonEncode(fields.toApiModel()),
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Gets a document signature forms.
  ///
  /// [docNameStartsWith]: The value that the document name starts with.
  ///
  /// [excludingId]: The id of a signature form to exclude from the results.
  Future<DocumentSignatureFormCollection> getSignatureForms({
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
      http.apiPaths.organizationsProjectsDocumentsRecentDocumentSignatureFormsFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
      query: qp,
    );
    final apiModel = api_mod.DocumentSignatureFormCollection.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return DocumentSignatureFormCollection.fromApiModel(apiModel);
    });
  }

  Future<QueryResult<DocumentCollection>> _getDocumentsInternal({
    bool? showAll,
    String? documentFolderId,
    String? documentGroupId,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (showAll != null) {
      qp['showAll'] = showAll;
    }
    if (documentFolderId != null) {
      qp['documentFolderId'] = documentFolderId;
    }
    if (documentGroupId != null) {
      qp['documentGroupId'] = documentGroupId;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentsFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentCollection>.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(app, () {
      return DocumentCollectionQueryResult.fromApiModelDocumentCollection(apiModel);
    });
  }

  /// Gets a Document Upload.
  Future<DocumentUpload> getDocumentUpload() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrganizationAndProjectPlaceholders(this),
      app,
    );
    final apiModel = api_mod.DocumentUpload.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return DocumentUpload.fromApiModel(apiModel);
    });
  }
}
