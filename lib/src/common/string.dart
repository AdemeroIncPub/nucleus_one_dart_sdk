import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';

import '../hierarchy/nucleus_one_app_project.dart';

/// If the value is null or blank false is returned; otherwise, true.
///
/// [value]: The value to check.
bool isNotEmpty(String? value) {
  return (value != null) && value.isNotEmpty;
}

/// If the value is null or blank true is returned; otherwise, false.
///
/// [value]: The value to check.
bool isNullOrEmpty(String? value) {
  return (value == null) || value.isEmpty;
}

extension CommonFormatting on String {
  /// If the [String]'s lower-case value equals "true", true is returned; otherwise, false.
  bool parseBool() {
    return toLowerCase() == 'true';
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [project]: The project that the replcement values should be sourced from.
  String replaceOrgIdAndProjectIdPlaceholdersUsingProject(NucleusOneAppProject project) {
    return replaceOrgIdPlaceholder(project.organization.id).replaceProjectIdPlaceholder(project.id);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [organizationId]: The organization ID to replace the placeholder with.
  ///
  /// [projectId]: The project ID to replace the placeholder with.
  String replaceOrgIdAndProjectIdPlaceholders(String organizationId, String projectId) {
    return replaceOrgIdPlaceholder(organizationId).replaceProjectIdPlaceholder(projectId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [organizationId]: The organization ID to replace the placeholder with.
  String replaceOrgIdPlaceholder(String organizationId) {
    return replaceFirst('<organizationId>', organizationId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [projectId]: The project ID to replace the placeholder with.
  String replaceProjectIdPlaceholder(String projectId) {
    return replaceFirst('<projectId>', projectId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [documentId]: The document ID to replace the placeholder with.
  String replaceDocumentIdPlaceholder(String documentId) {
    return replaceFirst('<documentId>', documentId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [documentFolderId]: The document folder ID to replace the placeholder with.
  String replaceDocumentFolderIdPlaceholder(String documentFolderId) {
    return replaceFirst('<documentFolderId>', documentFolderId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [signatureFormId]: The signature form ID to replace the placeholder with.
  String replaceDocumentSignatureFormIdPlaceholder(String signatureFormId) {
    return replaceFirst('<documentSignatureFormId>', signatureFormId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [signatureFormFieldId]: The signature form field ID to replace the placeholder with.
  String replaceDocumentSignatureFormFieldIdPlaceholder(String signatureFormFieldId) {
    return replaceFirst('<documentSignatureFormFieldId>', signatureFormFieldId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [signatureFormFieldId]: The signature session ID to replace the placeholder with.
  String replaceDocumentSignatureSessionIdPlaceholder(String signatureSessionId) {
    return replaceFirst('<documentSignatureSessionId>', signatureSessionId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [signatureFormFieldId]: The signature session recipient ID to replace the placeholder with.
  String replaceDocumentSignatureSessionRecipientIdPlaceholder(String signatureSessionRecipientId) {
    return replaceFirst('<documentSignatureSessionRecipientId>', signatureSessionRecipientId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [templateId]: The template ID to replace the placeholder with.
  String replaceSignatureFormTemplateIdPlaceholder(String templateId) {
    return replaceFirst('<signatureFormTemplateId>', templateId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [templateId]: The template ID to replace the placeholder with.
  String replaceFormTemplateIdPlaceholder(String templateId) {
    return replaceFirst('<formTemplateId>', templateId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [fieldId]: The field ID to replace the placeholder with.
  String replaceFormTemplateFieldIdPlaceholder(String fieldId) {
    return replaceFirst('<formTemplateFieldId>', fieldId);
  }

  /// Replaces the placeholder value with an actual value.
  ///
  /// [taskId]: The task ID to replace the placeholder with.
  String replaceTaskIdPlaceholder(String taskId) {
    return replaceFirst('<taskId>', taskId);
  }
}
