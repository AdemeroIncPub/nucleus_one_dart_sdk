// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..disabled = json['Disabled'] as bool?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..creatingUserID = json['CreatingUserID'] as String?
    ..creatingUserName = json['CreatingUserName'] as String?
    ..creatingUserEmail = json['CreatingUserEmail'] as String?
    ..crmLeadId = json['CrmLeadId'] as String?
    ..crmAccountId = json['CrmAccountId'] as String?
    ..crmContactId = json['CrmContactId'] as String?
    ..crmDealId = json['CrmDealId'] as String?
    ..subscriptionRequired = json['SubscriptionRequired'] as bool?
    ..subscriptionFreeUsers = json['SubscriptionFreeUsers'] as int?
    ..subscriptionExpiration = json['SubscriptionExpiration'] as String?
    ..maxProjects = json['MaxTenants'] as int?;
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('CreatingUserID', instance.creatingUserID);
  writeNotNull('CreatingUserName', instance.creatingUserName);
  writeNotNull('CreatingUserEmail', instance.creatingUserEmail);
  writeNotNull('CrmLeadId', instance.crmLeadId);
  writeNotNull('CrmAccountId', instance.crmAccountId);
  writeNotNull('CrmContactId', instance.crmContactId);
  writeNotNull('CrmDealId', instance.crmDealId);
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('SubscriptionFreeUsers', instance.subscriptionFreeUsers);
  writeNotNull('SubscriptionExpiration', instance.subscriptionExpiration);
  writeNotNull('MaxTenants', instance.maxProjects);
  return val;
}
