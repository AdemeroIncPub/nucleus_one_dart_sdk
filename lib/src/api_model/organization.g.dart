// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..bucketName = json['BucketName'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?
  ..creatingUserID = json['CreatingUserID'] as String?
  ..creatingUserName = json['CreatingUserName'] as String?
  ..creatingUserEmail = json['CreatingUserEmail'] as String?
  ..crmAccountId = json['CrmAccountId'] as String?
  ..crmLeadId = json['CrmLeadId'] as String?
  ..crmContactId = json['CrmContactId'] as String?
  ..crmDealId = json['CrmDealId'] as String?
  ..disabled = json['Disabled'] as bool?
  ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
  ..purgeMarkedOn = json['PurgeMarkedOn'] as String?
  ..purgeMarkedByUserID = json['PurgeMarkedByUserID'] as String?
  ..purgeMarkedByUserName = json['PurgeMarkedByUserName'] as String?
  ..purgeMarkedByUserEmail = json['PurgeMarkedByUserEmail'] as String?
  ..subscriptionRequired = json['SubscriptionRequired'] as bool?
  ..subscriptionFreeUsers = json['SubscriptionFreeUsers'] as int?
  ..subscriptionExpiration = json['SubscriptionExpiration'] as String?
  ..searchIndexRemovedForCostSavings = json['SearchIndexRemovedForCostSavings'] as bool?
  ..searchIndexRestoredAtLeastOnce = json['SearchIndexRestoredAtLeastOnce'] as bool?;

Map<String, dynamic> _$OrganizationToJson(Organization instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('CreatingUserID', instance.creatingUserID);
  writeNotNull('CreatingUserName', instance.creatingUserName);
  writeNotNull('CreatingUserEmail', instance.creatingUserEmail);
  writeNotNull('CrmAccountId', instance.crmAccountId);
  writeNotNull('CrmLeadId', instance.crmLeadId);
  writeNotNull('CrmContactId', instance.crmContactId);
  writeNotNull('CrmDealId', instance.crmDealId);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('PurgeMarkedOn', instance.purgeMarkedOn);
  writeNotNull('PurgeMarkedByUserID', instance.purgeMarkedByUserID);
  writeNotNull('PurgeMarkedByUserName', instance.purgeMarkedByUserName);
  writeNotNull('PurgeMarkedByUserEmail', instance.purgeMarkedByUserEmail);
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('SubscriptionFreeUsers', instance.subscriptionFreeUsers);
  writeNotNull('SubscriptionExpiration', instance.subscriptionExpiration);
  writeNotNull('SearchIndexRemovedForCostSavings', instance.searchIndexRemovedForCostSavings);
  writeNotNull('SearchIndexRestoredAtLeastOnce', instance.searchIndexRestoredAtLeastOnce);
  return val;
}
