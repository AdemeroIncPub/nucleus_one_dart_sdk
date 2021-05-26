// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) {
  return UserPreference()
    ..id = json['ID'] as String?
    ..userID = json['UserID'] as String?
    ..userName = json['UserName'] as String?
    ..userEmail = json['UserEmail'] as String?
    ..stringValue = json['StringValue'] as String?
    ..boolValue = json['BoolValue'] as bool?
    ..intValue = json['IntValue'] as int?
    ..floatValue = (json['FloatValue'] as num?)?.toDouble()
    ..mapValue = json['MapValue'] as String?;
}

Map<String, dynamic> _$UserPreferenceToJson(UserPreference instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('StringValue', instance.stringValue);
  writeNotNull('BoolValue', instance.boolValue);
  writeNotNull('IntValue', instance.intValue);
  writeNotNull('FloatValue', instance.floatValue);
  writeNotNull('MapValue', instance.mapValue);
  return val;
}
