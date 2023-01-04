import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import '../api_model/document.dart' as api_mod;
import '../api_model/document_folder.dart' as api_mod;
import '../api_model/document_signature_form.dart' as api_mod;
import '../api_model/document_upload.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/signature_form_template.dart' as api_mod;
import '../common/model.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../common/string.dart';
import '../http.dart';
import '../model/document.dart';
import '../model/document_folder.dart';
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
  /// [showAll]: Whether to get all documents recursively under this folder path, regardless of their
  /// depth within the heirarchy.
  ///
  /// [documentFolderId]: The document's parent folder id.
  ///
  /// [documentGroupId]: The document's group id.  This is only relevant when a document was created
  /// via a form.
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets the document count.
  ///
  /// [ignoreInbox]: Whether results should contain documents from the Inbox.
  ///
  /// [ignoreRecycleBin]: Whether results should contain documents from the Recycle Bin.
  Future<int> getDocumentCount({
    required bool ignoreInbox,
    required bool ignoreRecycleBin,
  }) async {
    final qp = {
      'ignoreInbox': ignoreInbox,
      'ignoreRecycleBin': ignoreRecycleBin,
    };
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsCountsDocumentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }

  /// Gets folders for the current project.  Only one folder hierarchy level is returned per call.
  Future<QueryResult<DocumentFolderCollection>> getDocumentFolders({
    String? parentId,
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
    if (parentId != null) {
      qp['parentId'] = parentId;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentFoldersFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentFolderCollection>.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(app, () {
      return DocumentFolderCollectionQueryResult.fromApiModelDocumentFolderCollection(apiModel);
    });
  }

  /// Gets a folder in the current project.
  Future<DocumentFolder> getDocumentFolder({
    required String documentFolderId,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['documentFolderId'] = documentFolderId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentFoldersDocumentFolderFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceDocumentFolderIdPlaceholder(documentFolderId),
      app,
      query: qp,
    );
    final apiModel = api_mod.DocumentFolder.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(app, () {
      return DocumentFolder.fromApiModel(apiModel);
    });
  }

  /// Gets the page count.
  ///
  Future<int> getPageCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsCountsPagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
    );
    return int.parse(responseBody);
  }

  /// Gets signature form templates.
  Future<SignatureFormTemplateCollection> getSignatureFormTemplates() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
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
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );
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
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentCollection>.fromJson(jsonDecode(responseBody));

    return await DefineN1AppInScope(app, () {
      return DocumentCollectionQueryResult.fromApiModelDocumentCollection(apiModel);
    });
  }

  /// Gets a Document Upload reservation.
  ///
  /// Call this *only* if you want to handle the upload process of a document manually; otherwise,
  /// you likely want to call `uploadDocument`, instead, which handles the entire process.
  Future<DocumentUpload> getDocumentUploadReservation() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
    );
    final apiModel = api_mod.DocumentUpload.fromJson(jsonDecode(responseBody));
    return await DefineN1AppInScope(app, () {
      return DocumentUpload.fromApiModel(apiModel);
    });
  }

  /// Uploads a file to Google Cloud Storage, in chunks.
  Future<void> _uploadFileToGcsFromUrl({
    required String gcsPublicReservationUrl,
    required String contentType,
    required Uint8List file,
  }) async {
    final Uri sessionUri;
    {
      final apiUri = Uri.parse(gcsPublicReservationUrl);
      final httpClient = getStandardHttpClient();

      final initialReq = await httpClient.putUrl(apiUri);
      initialReq.headers.add('Content-Type', 'application/octet-stream');
      initialReq.headers.add('x-goog-resumable', 'start');
      initialReq.write('{}');

      final initialResp = await initialReq.close();
      if (initialResp.statusCode != 200) {
        throw 'Error initializing upload to cloud storage.  HTTP ${initialResp.statusCode}: ' +
            (await initialResp.readToEnd());
      }

      final sessionUriString = initialResp.headers['location'];

      if ((sessionUriString == null) ||
          (sessionUriString.length != 1) ||
          isNullOrEmpty(sessionUriString[0])) {
        throw 'Unable to get upload URL.';
      }
      sessionUri = Uri.parse(sessionUriString[0]);
    }

    int offset = 0;
    final fileSize = file.length;

    // Read each chunk and upload synchronously
    while (offset < fileSize || fileSize == 0) {
      // Get chunk
      final currentChunkSize = math.min(offset + NucleusOneOptions.uploadChunkSize, fileSize),
          binaryChunk = file.sublist(offset, currentChunkSize),
          byteEnd = (fileSize == 0)
              ? 0
              : math.min(offset + NucleusOneOptions.uploadChunkSize - 1, fileSize - 1);

      final chunkReqHttpClient = getStandardHttpClient();
      final chunkReq = await chunkReqHttpClient.putUrl(sessionUri);
      chunkReq.headers.add('Content-Type', contentType);
      chunkReq.headers.add('Content-Range', 'bytes $offset-$byteEnd/$fileSize');

      chunkReq.write(binaryChunk);
      final chunkResp = await chunkReq.close();

      // A 308 is desired after uploading a chunk
      if ((chunkResp.statusCode != 200) && (chunkResp.statusCode != 308)) {
        //throw await chunkResp.readToEnd();
        throw 'Error uploading to cloud storage.  HTTP ${chunkResp.statusCode}: ' +
            (await chunkResp.readToEnd());
      }

      // Stop here if this is a 0-byte binary
      if (fileSize == 0) {
        break;
      }
      // Increment offset
      offset += binaryChunk.length;
    }
  }

  /// Uploads a new document.
  ///
  /// [userEmail]: The email address of the user by whom the Document will be uploaded.
  ///
  /// [fileName]: The file name to use when uploading the file.
  ///
  /// [contentType]: The MIME type of the file.
  ///
  /// [file]: The file to upload.
  Future<void> uploadDocument({
    required String userEmail,
    required String fileName,
    required String contentType,
    required Uint8List file,
  }) async {
    final docUploadReservation = await getDocumentUploadReservation();

    final fileSize = file.length;
    await _uploadFileToGcsFromUrl(
      gcsPublicReservationUrl: docUploadReservation.signedUrl,
      contentType: contentType,
      file: file,
    );

    docUploadReservation.originalFilename = fileName;
    docUploadReservation.originalFileSize = fileSize;

    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = docUploadReservation.uniqueId;
    qp['captureOriginal'] = false;

    /*final responseBody = */ await http.executePutRequestWithTextResponse(
      http.apiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app,
      query: qp,
      body: jsonEncode([docUploadReservation.toApiModel()]),
    );

    //print(responseBody);
  }
}
