// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences()
      ..userID = json['UserID'] as String?
      ..userName = json['UserName'] as String?
      ..userEmail = json['UserEmail'] as String?
      ..activeOrganizationID = json['ActiveOrganizationID'] as String?
      ..activeOrganizationName = json['ActiveOrganizationName'] as String?
      ..activeTenantID = json['ActiveTenantID'] as String?
      ..activeTenantName = json['ActiveTenantName'] as String?
      ..viewType = json['ViewType'] as String?
      ..documentPropertiesOpen = json['DocumentPropertiesOpen'] as bool?
      ..documentCommentsOpen = json['DocumentCommentsOpen'] as bool?
      ..singlePagePreview = json['SinglePagePreview'] as bool?
      ..selectedTwainDevice = json['SelectedTwainDevice'] == null
          ? null
          : SelectedTwainDevice.fromJson(
              json['SelectedTwainDevice'] as Map<String, dynamic>)
      ..disableTwainDeviceSoftware =
          json['DisableTwainDeviceSoftware'] as bool?;

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserID', instance.userID);
  writeNotNull('UserName', instance.userName);
  writeNotNull('UserEmail', instance.userEmail);
  writeNotNull('ActiveOrganizationID', instance.activeOrganizationID);
  writeNotNull('ActiveOrganizationName', instance.activeOrganizationName);
  writeNotNull('ActiveTenantID', instance.activeTenantID);
  writeNotNull('ActiveTenantName', instance.activeTenantName);
  writeNotNull('ViewType', instance.viewType);
  writeNotNull('DocumentPropertiesOpen', instance.documentPropertiesOpen);
  writeNotNull('DocumentCommentsOpen', instance.documentCommentsOpen);
  writeNotNull('SinglePagePreview', instance.singlePagePreview);
  writeNotNull('SelectedTwainDevice', instance.selectedTwainDevice);
  writeNotNull(
      'DisableTwainDeviceSoftware', instance.disableTwainDeviceSoftware);
  return val;
}
