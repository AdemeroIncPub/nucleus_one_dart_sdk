// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_form_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureFormTemplate _$SignatureFormTemplateFromJson(
    Map<String, dynamic> json) {
  return SignatureFormTemplate()
    ..id = json['ID'] as String?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..createdOn = json['CreatedOn'] as String?;
}

Map<String, dynamic> _$SignatureFormTemplateToJson(
    SignatureFormTemplate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('CreatedOn', instance.createdOn);
  return val;
}
