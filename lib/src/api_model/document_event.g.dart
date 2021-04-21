// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentEvent _$DocumentEventFromJson(Map<String, dynamic> json) {
  return DocumentEvent()
    ..id = json['ID'] as String?
    ..documentID = json['DocumentID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..createdByUserID = json['CreatedByUserID'] as String?
    ..createdByUserName = json['CreatedByUserName'] as String?
    ..createdByUserEmail = json['CreatedByUserEmail'] as String?
    ..type = json['Type'] as String?
    ..detailJson = json['DetailJson'] as String?;
}

Map<String, dynamic> _$DocumentEventToJson(DocumentEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('DocumentID', instance.documentID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('Type', instance.type);
  writeNotNull('DetailJson', instance.detailJson);
  return val;
}
