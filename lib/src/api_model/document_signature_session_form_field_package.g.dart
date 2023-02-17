// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_form_field_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionFormFieldPackage _$DocumentSignatureSessionFormFieldPackageFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionFormFieldPackage()
      ..formDesignType = json['FormDesignType'] as String?
      ..quickDesignPlaceInitials = json['QuickDesignPlaceInitials'] as bool?
      ..quickDesignPlaceFullName = json['QuickDesignPlaceFullName'] as bool?
      ..quickDesignPlaceEmail = json['QuickDesignPlaceEmail'] as bool?
      ..quickDesignPlaceTitle = json['QuickDesignPlaceTitle'] as bool?
      ..formFields = (json['FormFields'] as List<dynamic>?)
          ?.map(
              (e) => DocumentSignatureSessionRecipientFormField.fromJson(e as Map<String, dynamic>))
          .toList()
      ..completedFormFields = (json['CompletedFormFields'] as List<dynamic>?)
          ?.map(
              (e) => DocumentSignatureSessionRecipientFormField.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DocumentSignatureSessionFormFieldPackageToJson(
    DocumentSignatureSessionFormFieldPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FormDesignType', instance.formDesignType);
  writeNotNull('QuickDesignPlaceInitials', instance.quickDesignPlaceInitials);
  writeNotNull('QuickDesignPlaceFullName', instance.quickDesignPlaceFullName);
  writeNotNull('QuickDesignPlaceEmail', instance.quickDesignPlaceEmail);
  writeNotNull('QuickDesignPlaceTitle', instance.quickDesignPlaceTitle);
  writeNotNull('FormFields', instance.formFields);
  writeNotNull('CompletedFormFields', instance.completedFormFields);
  return val;
}
