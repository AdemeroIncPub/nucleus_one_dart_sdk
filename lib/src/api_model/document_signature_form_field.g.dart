// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureFormField _$DocumentSignatureFormFieldFromJson(
    Map<String, dynamic> json) {
  return DocumentSignatureFormField()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..type = json['Type'] as String?
    ..pageIndex = json['PageIndex'] as int?
    ..documentSignatureSessionRecipientID =
        json['DocumentSignatureSessionRecipientID'] as String?
    ..x = (json['X'] as num?)?.toDouble()
    ..y = (json['Y'] as num?)?.toDouble();
}

Map<String, dynamic> _$DocumentSignatureFormFieldToJson(
    DocumentSignatureFormField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Type', instance.type);
  writeNotNull('PageIndex', instance.pageIndex);
  writeNotNull('DocumentSignatureSessionRecipientID',
      instance.documentSignatureSessionRecipientID);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  return val;
}
