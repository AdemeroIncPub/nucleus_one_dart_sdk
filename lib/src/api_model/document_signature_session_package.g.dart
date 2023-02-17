// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionPackage _$DocumentSignatureSessionPackageFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionPackage()
      ..session = json['Session'] == null
          ? null
          : DocumentSignatureSession.fromJson(json['Session'] as Map<String, dynamic>)
      ..recipients = (json['Recipients'] as List<dynamic>?)
          ?.map((e) => DocumentSignatureSessionRecipient.fromJson(e as Map<String, dynamic>))
          .toList()
      ..beginSession = json['BeginSession'] as bool?
      ..resetSession = json['ResetSession'] as bool?;

Map<String, dynamic> _$DocumentSignatureSessionPackageToJson(
    DocumentSignatureSessionPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Session', instance.session);
  writeNotNull('Recipients', instance.recipients);
  writeNotNull('BeginSession', instance.beginSession);
  writeNotNull('ResetSession', instance.resetSession);
  return val;
}
