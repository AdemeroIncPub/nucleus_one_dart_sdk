import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import '../api_model/document.dart' as api_mod;
import '../api_model/document_folder.dart' as api_mod;
import '../api_model/document_signature_form.dart' as api_mod;
import '../api_model/document_upload.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../api_model/signature_form_template.dart' as api_mod;
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

/// Performs project operations.
class NucleusOneAppProject with NucleusOneAppDependent {
  /// The organization that this project belongs to.
  final NucleusOneAppOrganization organization;

  /// This project's ID.
  final String id;

  /// Creates an instance of the [NucleusOneAppProject] class.
  ///
  /// [organization]: The organization to perform task operations on.
  ///
  /// [id]: The project's ID.
  NucleusOneAppProject({
    required this.organization,
    required this.id,
  }) {
    app = organization.app;

    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
  }

  /// Gets a [NucleusOneAppApprovals] instance, which can be used to perform approval process
  /// operations for this project.
  NucleusOneAppApprovals approvals() {
    return NucleusOneAppApprovals(
      project: this,
    );
  }

  /// Gets a [FolderHierarchyCollection] instance, which can be used to configure new folder
  /// hierarchies for this project.
  ///
  /// Note that the data configured in this object is local, until it is explicitly sent to the
  /// server.
  FolderHierarchyCollection folderHierarchies() {
    return FolderHierarchyCollection(project: this);
  }

  /// Gets a [FolderHierarchyItemCollection] instance, which can be used to configure new folder
  /// hierarchy items for this project.
  ///
  /// Note that the data configured in this object is local, until it is explicitly sent to the
  /// server.
  FolderHierarchyItemCollection folderHierarchyItems() {
    return FolderHierarchyItemCollection(project: this);
  }

  /// Gets a [FormTemplateCollection] instance, which can be used to configure new form templates
  /// for this project.
  ///
  /// Note that the data configured in this object is local, until it is explicitly sent to the
  /// server.
  FormTemplateCollection formTemplates() {
    return FormTemplateCollection(project: this);
  }

  /// Gets a [NucleusOneAppDocuments] instance, which can be used to perform document operations for
  /// this project.
  NucleusOneAppDocuments documents() {
    return NucleusOneAppDocuments(
      project: this,
    );
  }

  /// Gets a [NucleusOneAppDocument] instance, which can be used to perform operations for a
  /// specific document.
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
  /// [documentFolderId]: The document's parent folder ID.
  ///
  /// [documentGroupId]: The document's group ID.  This is only relevant when a document was created
  /// via a form.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<DocumentCollection, api_mod.DocumentCollection>> getDocuments({
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

  /// Gets a [NucleusOneAppForms] instance, which can be used to perform form operations for this
  /// project.
  NucleusOneAppForms forms() {
    return NucleusOneAppForms(
      project: this,
    );
  }

  /// Gets a [NucleusOneAppTasks] instance, which can be used to perform task operations for this
  /// project.
  NucleusOneAppTasks tasks() {
    return NucleusOneAppTasks(
      project: this,
    );
  }

  /// Gets a [NucleusOneAppTask] instance, which can be used to perform operations for a specific
  /// task.
  NucleusOneAppTask task(String id) {
    return NucleusOneAppTask(
      project: this,
      taskId: id,
    );
  }

  /// Gets the document count within the Recycle Bin.
  Future<int> getRecycleBinDocumentCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsCountsRecycleBinDocumentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
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
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsCountsDocumentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      queryParams: qp,
    );
    return int.parse(responseBody);
  }

  /// Gets document folders for the current project.  Only one folder hierarchy level is returned
  /// per call.
  ///
  /// [parentId]: The ID of the parent folder in the hierarchy.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<DocumentFolderCollection, api_mod.DocumentFolderCollection>>
      getDocumentFolders({
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
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentFoldersFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentFolderCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult<DocumentFolderCollection, api_mod.DocumentFolderCollection>.fromApiModel(
          apiModel);
    });
  }

  /// Gets a document folder in the current project.
  ///
  /// [documentFolderId]: The ID of the document folder.
  Future<DocumentFolder> getDocumentFolder({
    required String documentFolderId,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['documentFolderId'] = documentFolderId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentFoldersDocumentFolderFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceDocumentFolderIdPlaceholder(documentFolderId),
      app: app,
      queryParams: qp,
    );
    final apiModel = api_mod.DocumentFolder.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return DocumentFolder.fromApiModel(apiModel);
    });
  }

  /// Gets the page count in this project.
  Future<int> getPageCount() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsCountsPagesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
    );
    return int.parse(responseBody);
  }

  /// Gets signature form templates in this project.
  Future<SignatureFormTemplateCollection> getSignatureFormTemplates() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
    );
    final apiModel =
        api_mod.SignatureFormTemplateCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return SignatureFormTemplateCollection.fromApiModel(apiModel);
    });
  }

  /// Adds signature form templates to this project.  A list of the same templates that were passed
  /// in are returned, as they now exist on the server.
  ///
  /// [templates]: The signature form templates to add.
  Future<SignatureFormTemplateCollection> addSignatureFormTemplates(
      SignatureFormTemplateCollection templates) async {
    final responseBody = await http.executePostRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsSignatureFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      body: jsonEncode(templates.toApiModel()),
    );
    final apiModel =
        api_mod.SignatureFormTemplateCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return SignatureFormTemplateCollection.fromApiModel(apiModel);
    });
  }

  /// Updates a signature form template in this project.
  ///
  /// [templateId]: The signature form template ID.
  ///
  /// [template]: The signature form template.
  Future<void> updateSignatureFormTemplate({
    required String templateId,
    required SignatureFormTemplate template,
  }) async {
    await http.executePutRequest(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app: app,
      body: jsonEncode(template.toApiModel()),
    );
  }

  /// Deletes a signature form template in this project.
  ///
  /// [templateId]: The signature form template ID.
  Future<void> deleteSignatureFormTemplate({
    required String templateId,
  }) async {
    await http.executeDeleteRequest(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app: app,
    );
  }

  /// Gets signature form templates in this project.
  ///
  /// [templateId]: The signature form template ID.
  Future<SignatureFormTemplateFieldCollection> getSignatureFormTemplateFields({
    required String templateId,
  }) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app: app,
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Adds fields to a signature form template in this project.  The field that were passed in are
  /// returned, as they now exists on the server.
  ///
  /// [templateId]: The signature form template ID.
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
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app: app,
      queryParams: qp,
      body: jsonEncode(fields.toApiModel()),
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Gets document signature forms in this project.
  ///
  /// [docNameStartsWith]: The value that the document name starts with.
  ///
  /// [excludingId]: The ID of a signature form to exclude from the results.
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
      apiRelativeUrlPath: http
          .ApiPaths.organizationsProjectsDocumentsRecentDocumentSignatureFormsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.DocumentSignatureFormCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(app, () {
      return DocumentSignatureFormCollection.fromApiModel(apiModel);
    });
  }

  /// Contains core logic for retrieving documents.
  Future<QueryResult<DocumentCollection, api_mod.DocumentCollection>> _getDocumentsInternal({
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
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.DocumentCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppInScope(app, () {
      return QueryResult<DocumentCollection, api_mod.DocumentCollection>.fromApiModel(apiModel);
    });
  }

  /// Gets a Document Upload reservation for this project.
  ///
  /// Call this *only* if you want to handle the upload process of a document manually; otherwise,
  /// you likely want to call [uploadDocument], instead, which handles the entire process.
  Future<DocumentUpload> getDocumentUploadReservation() async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
    );
    final apiModel = api_mod.DocumentUpload.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(app, () {
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
        throw 'Error initializing upload to cloud storage.  HTTP ${initialResp.statusCode}: ${await initialResp.readToEnd()}';
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
        throw 'Error uploading to cloud storage.  HTTP ${chunkResp.statusCode}: ${await chunkResp.readToEnd()}';
      }

      // Stop here if this is a 0-byte binary
      if (fileSize == 0) {
        break;
      }
      // Increment offset
      offset += binaryChunk.length;
    }
  }

  /// Uploads a new document into this project.
  ///
  /// [userEmail]: The email address of the user by whom the document will be uploaded.
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
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsDocumentUploadsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(this),
      app: app,
      queryParams: qp,
      body: jsonEncode([docUploadReservation.toApiModel()]),
    );

    //print(responseBody);
  }
}
