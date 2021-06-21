// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureFormField _$DocumentSignatureFormFieldFromJson(
    Map<String, dynamic> json) {
  return DocumentSignatureFormField()
    ..type = json['Type'] as String?
    ..label = json['Label'] as String?
    ..widthPercent = (json['WidthPercent'] as num?)?.toDouble()
    ..sortRank = json['SortRank'] as int?
    ..id = json['ID'] as String?
    ..documentSignatureSessionRecipientID =
        json['DocumentSignatureSessionRecipientID'] as String?
    ..x = (json['X'] as num?)?.toDouble()
    ..y = (json['Y'] as num?)?.toDouble()
    ..pageIndex = json['PageIndex'] as int?;
}

Map<String, dynamic> _$DocumentSignatureFormFieldToJson(
    DocumentSignatureFormField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', instance.type);
  writeNotNull('Label', instance.label);
  writeNotNull('WidthPercent', instance.widthPercent);
  writeNotNull('SortRank', instance.sortRank);
  writeNotNull('ID', instance.id);
  writeNotNull('DocumentSignatureSessionRecipientID',
      instance.documentSignatureSessionRecipientID);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  writeNotNull('PageIndex', instance.pageIndex);
  return val;
}
