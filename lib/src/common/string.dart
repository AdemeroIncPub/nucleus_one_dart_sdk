import '../hierarchy/nucleus_one_app_project.dart';

bool isNotEmpty(String? value) {
  return (value != null) && value.isNotEmpty;
}

bool isNullOrEmpty(String? value) {
  return (value == null) || value.isEmpty;
}

extension CommonFormatting on String {
  String replaceOrganizationAndProjectPlaceholders(NucleusOneAppProject project) {
    return replaceOrganizationPlaceholder(project.organization.id)
        .replaceFirst('<projectId>', project.id);
  }

  String replaceOrganizationPlaceholder(String organizationId) {
    return replaceFirst('<organizationId>', organizationId);
  }

  String replaceDocumentIdPlaceholder(String documentId) {
    return replaceFirst('<documentId>', documentId);
  }

  String replaceDocumentFolderIdPlaceholder(String documentFolderId) {
    return replaceFirst('<documentFolderId>', documentFolderId);
  }

  String replaceDocumentSignatureFormIdPlaceholder(String signatureFormId) {
    return replaceFirst('<documentSignatureFormId>', signatureFormId);
  }

  String replaceDocumentSignatureFormFieldIdPlaceholder(String signatureFormFieldId) {
    return replaceFirst('<documentSignatureFormFieldId>', signatureFormFieldId);
  }

  String replaceDocumentSignatureSessionIdPlaceholder(String signatureSessionId) {
    return replaceFirst('<documentSignatureSessionId>', signatureSessionId);
  }

  String replaceDocumentSignatureSessionRecipientIdPlaceholder(String signatureSessionRecipientId) {
    return replaceFirst('<documentSignatureSessionRecipientId>', signatureSessionRecipientId);
  }

  String replaceSignatureFormTemplateIdPlaceholder(String templateId) {
    return replaceFirst('<signatureFormTemplateId>', templateId);
  }

  String replaceFormTemplateIdPlaceholder(String templateId) {
    return replaceFirst('<formTemplateId>', templateId);
  }

  String replaceFormTemplateFieldIdPlaceholder(String fieldId) {
    return replaceFirst('<formTemplateFieldId>', fieldId);
  }

  String replaceTaskIdPlaceholder(String taskId) {
    return replaceFirst('<taskId>', taskId);
  }
}
