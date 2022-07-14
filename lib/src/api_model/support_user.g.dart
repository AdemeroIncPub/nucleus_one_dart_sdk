// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportUserCollection _$SupportUserCollectionFromJson(
        Map<String, dynamic> json) =>
    SupportUserCollection()
      ..supportUsers = (json['Users'] as List<dynamic>?)
          ?.map((e) => SupportUser.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SupportUserCollectionToJson(
    SupportUserCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Users', instance.supportUsers);
  return val;
}

SupportUser _$SupportUserFromJson(Map<String, dynamic> json) => SupportUser()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..lastSignIn = json['LastSignIn'] as String?
  ..lastActivity = json['LastActivity'] as String?
  ..email = json['Email'] as String?
  ..provider = json['Provider'] as String?
  ..name = json['Name'] as String?;

Map<String, dynamic> _$SupportUserToJson(SupportUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('LastSignIn', instance.lastSignIn);
  writeNotNull('LastActivity', instance.lastActivity);
  writeNotNull('Email', instance.email);
  writeNotNull('Provider', instance.provider);
  writeNotNull('Name', instance.name);
  return val;
}
