// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile()
  ..userProvider = json['UserProvider'] as String?
  ..userEmail = json['UserEmail'] as String?
  ..userName = json['UserName'] as String?
  ..otpsmsNumber = json['OTPSMSNumber'] as String?;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserProvider', instance.userProvider);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('UserName', instance.userName);
  writeNotNull('OTPSMSNumber', instance.otpsmsNumber);
  return val;
}
