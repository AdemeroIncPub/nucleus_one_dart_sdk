// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportErrorEvent _$SupportErrorEventFromJson(Map<String, dynamic> json) => SupportErrorEvent()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..tenantID = json['TenantID'] as String?
  ..tenantName = json['TenantName'] as String?
  ..tenantNameLower = json['TenantNameLower'] as String?
  ..userEmailLower = json['UserEmailLower'] as String?
  ..userID = json['UserID'] as String?
  ..serviceNameLower = json['ServiceNameLower'] as String?
  ..level = json['Level'] as String?
  ..uniqueID = json['UniqueID'] as String?
  ..requestURI = json['RequestURI'] as String?
  ..header = json['Header'] as String?
  ..message = json['Message'] as String?
  ..clientMessage = json['ClientMessage'] as String?
  ..httpStatus = json['HttpStatus'] as int?
  ..otherValues = (json['OtherValues'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..wordsLower = (json['WordsLower'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$SupportErrorEventToJson(SupportErrorEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('TenantName', instance.tenantName);
  writeNotNull('TenantNameLower', instance.tenantNameLower);
  writeNotNull('UserEmailLower', instance.userEmailLower);
  writeNotNull('UserID', instance.userID);
  writeNotNull('ServiceNameLower', instance.serviceNameLower);
  writeNotNull('Level', instance.level);
  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('RequestURI', instance.requestURI);
  writeNotNull('Header', instance.header);
  writeNotNull('Message', instance.message);
  writeNotNull('ClientMessage', instance.clientMessage);
  writeNotNull('HttpStatus', instance.httpStatus);
  writeNotNull('OtherValues', instance.otherValues);
  writeNotNull('WordsLower', instance.wordsLower);
  return val;
}

SupportErrorEventCollection _$SupportErrorEventCollectionFromJson(Map<String, dynamic> json) =>
    SupportErrorEventCollection()
      ..supportErrorEvents = (json['ErrorEvents'] as List<dynamic>?)
          ?.map((e) => SupportErrorEvent.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SupportErrorEventCollectionToJson(SupportErrorEventCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorEvents', instance.supportErrorEvents);
  return val;
}
