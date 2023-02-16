// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_signing_recipient_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionSigningRecipientPackage
    _$DocumentSignatureSessionSigningRecipientPackageFromJson(Map<String, dynamic> json) =>
        DocumentSignatureSessionSigningRecipientPackage()
          ..requireAccessCode = json['RequireAccessCode'] as bool?
          ..signingRecipient = json['SigningRecipient'] == null
              ? null
              : DocumentSignatureSessionSigningRecipient.fromJson(
                  json['SigningRecipient'] as Map<String, dynamic>)
          ..formFieldPackage = json['FormFieldPackage'] == null
              ? null
              : DocumentSignatureSessionFormFieldPackage.fromJson(
                  json['FormFieldPackage'] as Map<String, dynamic>)
          ..serverDate = json['ServerDate'] as String?
          ..contentPackage = json['ContentPackage'] == null
              ? null
              : DocumentContentPackage.fromJson(json['ContentPackage'] as Map<String, dynamic>);

Map<String, dynamic> _$DocumentSignatureSessionSigningRecipientPackageToJson(
    DocumentSignatureSessionSigningRecipientPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('RequireAccessCode', instance.requireAccessCode);
  writeNotNull('SigningRecipient', instance.signingRecipient);
  writeNotNull('FormFieldPackage', instance.formFieldPackage);
  writeNotNull('ServerDate', instance.serverDate);
  writeNotNull('ContentPackage', instance.contentPackage);
  return val;
}
