// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_submission_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormSubmissionPackage _$FormSubmissionPackageFromJson(Map<String, dynamic> json) =>
    FormSubmissionPackage()
      ..tenantID = json['TenantID'] as String?
      ..formTemplateID = json['FormTemplateID'] as String?
      ..formSubmissionFields = (json['FormSubmissionFields'] as List<dynamic>?)
          ?.map((e) => FormSubmissionField.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FormSubmissionPackageToJson(FormSubmissionPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('FormTemplateID', instance.formTemplateID);
  writeNotNull('FormSubmissionFields', instance.formSubmissionFields);
  return val;
}
