// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureForm _$DocumentSignatureFormFromJson(Map<String, dynamic> json) =>
    DocumentSignatureForm()
      ..id = json['ID'] as String?
      ..signatureFormTemplateID = json['SignatureFormTemplateID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..tenantID = json['TenantID'] as String?
      ..documentID = json['DocumentID'] as String?
      ..documentClassificationID = json['DocumentClassificationID'] as String?
      ..documentClassificationName = json['DocumentClassificationName'] as String?
      ..documentClassificationNameLower = json['DocumentClassificationNameLower'] as String?
      ..documentName = json['DocumentName'] as String?
      ..documentNameLower = json['DocumentNameLower'] as String?
      ..hasFormFields = json['HasFormFields'] as bool?
      ..totalFormFields = json['TotalFormFields'] as int?
      ..lastViewedPageIndex = json['LastViewedPageIndex'] as int?;

Map<String, dynamic> _$DocumentSignatureFormToJson(DocumentSignatureForm instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('SignatureFormTemplateID', instance.signatureFormTemplateID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('DocumentClassificationID', instance.documentClassificationID);
  writeNotNull('DocumentClassificationName', instance.documentClassificationName);
  writeNotNull('DocumentClassificationNameLower', instance.documentClassificationNameLower);
  writeNotNull('DocumentName', instance.documentName);
  writeNotNull('DocumentNameLower', instance.documentNameLower);
  writeNotNull('HasFormFields', instance.hasFormFields);
  writeNotNull('TotalFormFields', instance.totalFormFields);
  writeNotNull('LastViewedPageIndex', instance.lastViewedPageIndex);
  return val;
}
