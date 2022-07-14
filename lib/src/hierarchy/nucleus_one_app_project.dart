import 'dart:convert';

import '../api_model/signature_form_template.dart' as api_mod;
import '../http.dart' as http;
import '../common/string.dart';
import '../model/signature_form_template.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_approvals.dart';
import 'nucleus_one_app_documents.dart';
import 'nucleus_one_app_forms.dart';
import 'nucleus_one_app_organization.dart';

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

  /// Documents
  NucleusOneAppDocuments documents() {
    return NucleusOneAppDocuments(
      project: this,
    );
  }

  /// Forms
  NucleusOneAppForms forms() {
    return NucleusOneAppForms(
      project: this,
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
      http.apiPaths.organizationsProjectsCountsPagesFormat.replaceOrganizationAndProjectPlaceholders(this),
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
    return SignatureFormTemplateCollection.fromApiModel(apiModel);
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
  Future<void> deleteSignatureFormTemplate(templateId) async {
    await http.executeDeleteRequest(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app,
    );
  }

  /// Gets signature form templates.
  ///
  /// [templateId] The signature form template id.
  Future<SignatureFormTemplateFieldCollection> getSignatureFormTemplateFields(
      String templateId) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
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
      http.apiPaths.organizationsProjectsSignatureFormTemplatesSignatureFormTemplateFieldsFormat
          .replaceOrganizationAndProjectPlaceholders(this)
          .replaceSignatureFormTemplateIdPlaceholder(templateId),
      app,
      query: qp,
      body: jsonEncode(fields.toApiModel()),
    );
    final apiModel =
        api_mod.SignatureFormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return SignatureFormTemplateFieldCollection.fromApiModel(apiModel);
  }
}
