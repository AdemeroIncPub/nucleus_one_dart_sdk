// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_signature_session_recipient_form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentSignatureSessionRecipientFormField _$DocumentSignatureSessionRecipientFormFieldFromJson(
        Map<String, dynamic> json) =>
    DocumentSignatureSessionRecipientFormField()
      ..id = json['ID'] as String?
      ..documentSignatureFormFieldID = json['DocumentSignatureFormFieldID'] as String?
      ..documentSignatureSessionRecipientID = json['DocumentSignatureSessionRecipientID'] as String?
      ..documentSignatureSessionRecipientRank =
          json['DocumentSignatureSessionRecipientRank'] as int?
      ..isComplete = json['IsComplete'] as bool?
      ..type = json['Type'] as String?
      ..pageIndex = json['PageIndex'] as int?
      ..x = (json['X'] as num?)?.toDouble()
      ..y = (json['Y'] as num?)?.toDouble()
      ..value = json['Value'] as String?
      ..placementRank = json['PlacementRank'] as int?;

Map<String, dynamic> _$DocumentSignatureSessionRecipientFormFieldToJson(
    DocumentSignatureSessionRecipientFormField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('DocumentSignatureFormFieldID', instance.documentSignatureFormFieldID);
  writeNotNull('DocumentSignatureSessionRecipientID', instance.documentSignatureSessionRecipientID);
  writeNotNull(
      'DocumentSignatureSessionRecipientRank', instance.documentSignatureSessionRecipientRank);
  writeNotNull('IsComplete', instance.isComplete);
  writeNotNull('Type', instance.type);
  writeNotNull('PageIndex', instance.pageIndex);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  writeNotNull('Value', instance.value);
  writeNotNull('PlacementRank', instance.placementRank);
  return val;
}
