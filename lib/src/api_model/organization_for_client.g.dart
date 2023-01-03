// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_for_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationForClientCollection _$OrganizationForClientCollectionFromJson(
        Map<String, dynamic> json) =>
    OrganizationForClientCollection()
      ..organizations = (json['Organizations'] as List<dynamic>?)
          ?.map((e) => OrganizationForClient.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OrganizationForClientCollectionToJson(
    OrganizationForClientCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Organizations', instance.organizations);
  return val;
}

OrganizationForClient _$OrganizationForClientFromJson(Map<String, dynamic> json) =>
    OrganizationForClient()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..name = json['Name'] as String?
      ..creatingUserID = json['CreatingUserID'] as String?
      ..creatingUserName = json['CreatingUserName'] as String?
      ..creatingUserEmail = json['CreatingUserEmail'] as String?
      ..crmAccountId = json['CrmAccountId'] as String?
      ..subscriptionRequired = json['SubscriptionRequired'] as bool?
      ..subscriptionFreeUsers = json['SubscriptionFreeUsers'] as int?
      ..subscriptionExpiration = json['SubscriptionExpiration'] as String?
      ..searchIndexID = json['SearchIndexID'] as String?
      ..bucketName = json['BucketName'] as String?
      ..disabled = json['Disabled'] as bool?
      ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
      ..purgeDate = json['PurgeDate'] as String?
      ..uniqueNonReadOnlyOrganizationMembers = json['UniqueNonReadOnlyOrganizationMembers'] as int?
      ..uniqueReadOnlyOrganizationMembers = json['UniqueReadOnlyOrganizationMembers'] as int?
      ..uniqueFreeOrganizationMembers = json['UniqueFreeOrganizationMembers'] as int?
      ..uniqueBillableOrganizationMembers = json['UniqueBillableOrganizationMembers'] as int?;

Map<String, dynamic> _$OrganizationForClientToJson(OrganizationForClient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Name', instance.name);
  writeNotNull('CreatingUserID', instance.creatingUserID);
  writeNotNull('CreatingUserName', instance.creatingUserName);
  writeNotNull('CreatingUserEmail', instance.creatingUserEmail);
  writeNotNull('CrmAccountId', instance.crmAccountId);
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('SubscriptionFreeUsers', instance.subscriptionFreeUsers);
  writeNotNull('SubscriptionExpiration', instance.subscriptionExpiration);
  writeNotNull('SearchIndexID', instance.searchIndexID);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('PurgeDate', instance.purgeDate);
  writeNotNull(
      'UniqueNonReadOnlyOrganizationMembers', instance.uniqueNonReadOnlyOrganizationMembers);
  writeNotNull('UniqueReadOnlyOrganizationMembers', instance.uniqueReadOnlyOrganizationMembers);
  writeNotNull('UniqueFreeOrganizationMembers', instance.uniqueFreeOrganizationMembers);
  writeNotNull('UniqueBillableOrganizationMembers', instance.uniqueBillableOrganizationMembers);
  return val;
}
