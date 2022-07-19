// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_login_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailLoginOptions _$EmailLoginOptionsFromJson(Map<String, dynamic> json) => EmailLoginOptions()
  ..userExists = json['UserExists'] as bool?
  ..smsNumberLast2 = json['SMSNumberLast2'] as String?;

Map<String, dynamic> _$EmailLoginOptionsToJson(EmailLoginOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserExists', instance.userExists);
  writeNotNull('SMSNumberLast2', instance.smsNumberLast2);
  return val;
}
