// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_signing_recipient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionSigningRecipient _$DocumentSignatureSessionSigningRecipientFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionSigningRecipient()
      ..email = json['Email'] as String?
      ..fullName = json['FullName'] as String?;

Map<String, dynamic> _$DocumentSignatureSessionSigningRecipientToJson(
    DocumentSignatureSessionSigningRecipient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Email', instance.email);
  writeNotNull('FullName', instance.fullName);
  return val;
}
