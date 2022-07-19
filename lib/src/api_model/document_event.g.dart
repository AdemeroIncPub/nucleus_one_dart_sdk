// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentEventCollection _$DocumentEventCollectionFromJson(Map<String, dynamic> json) =>
    DocumentEventCollection()
      ..documentEvents = (json['DocumentEvents'] as List<dynamic>?)
          ?.map((e) => DocumentEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DocumentEventCollectionToJson(DocumentEventCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DocumentEvents', instance.documentEvents);
  return val;
}

DocumentEvent _$DocumentEventFromJson(Map<String, dynamic> json) => DocumentEvent()
  ..id = json['ID'] as String?
  ..documentID = json['DocumentID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..createdByUserID = json['CreatedByUserID'] as String?
  ..createdByUserName = json['CreatedByUserName'] as String?
  ..createdByUserEmail = json['CreatedByUserEmail'] as String?
  ..type = json['Type'] as String?
  ..detailJson = json['DetailJson'] as String?;

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
