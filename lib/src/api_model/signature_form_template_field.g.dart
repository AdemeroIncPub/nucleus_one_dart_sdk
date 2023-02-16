// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_form_template_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureFormTemplateField _$SignatureFormTemplateFieldFromJson(Map<String, dynamic> json) =>
    SignatureFormTemplateField()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..type = json['Type'] as String?
      ..pageIndex = json['PageIndex'] as int?
      ..documentSignatureSessionRecipientID = json['DocumentSignatureSessionRecipientID'] as String?
      ..x = (json['X'] as num?)?.toDouble()
      ..y = (json['Y'] as num?)?.toDouble()
      ..label = json['Label'] as String?
      ..widthPercent = (json['WidthPercent'] as num?)?.toDouble()
      ..sortRank = json['SortRank'] as int?;

Map<String, dynamic> _$SignatureFormTemplateFieldToJson(SignatureFormTemplateField instance) {
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
  writeNotNull('DocumentSignatureSessionRecipientID', instance.documentSignatureSessionRecipientID);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  writeNotNull('Label', instance.label);
  writeNotNull('WidthPercent', instance.widthPercent);
  writeNotNull('SortRank', instance.sortRank);
  return val;
}
