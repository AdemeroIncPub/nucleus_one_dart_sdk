// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantCollection _$TenantCollectionFromJson(Map<String, dynamic> json) =>
    TenantCollection()
      ..tenants = (json['Tenants'] as List<dynamic>?)
          ?.map((e) => Tenant.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TenantCollectionToJson(TenantCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Tenants', instance.tenants);
  return val;
}

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant()
  ..id = json['ID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..name = json['Name'] as String?
  ..creatingUserName = json['CreatingUserName'] as String?
  ..creatingUserEmail = json['CreatingUserEmail'] as String?
  ..crmAccountId = json['CrmAccountId'] as String?
  ..organizationID = json['OrganizationID'] as String?
  ..organizationName = json['OrganizationName'] as String?
  ..organizationSubscriptionRequired =
      json['OrganizationSubscriptionRequired'] as bool?
  ..organizationSubscriptionExpiration =
      json['OrganizationSubscriptionExpiration'] as String?
  ..searchIndexID = json['SearchIndexID'] as String?
  ..bucketName = json['BucketName'] as String?
  ..disabled = json['Disabled'] as bool?
  ..isMarkedForPurge = json['IsMarkedForPurge'] as bool?
  ..purgeDate = json['PurgeDate'] as String?
  ..documentCount = json['DocumentCount'] as int?;

Map<String, dynamic> _$TenantToJson(Tenant instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Name', instance.name);
  writeNotNull('CreatingUserName', instance.creatingUserName);
  writeNotNull('CreatingUserEmail', instance.creatingUserEmail);
  writeNotNull('CrmAccountId', instance.crmAccountId);
  writeNotNull('OrganizationID', instance.organizationID);
  writeNotNull('OrganizationName', instance.organizationName);
  writeNotNull('OrganizationSubscriptionRequired',
      instance.organizationSubscriptionRequired);
  writeNotNull('OrganizationSubscriptionExpiration',
      instance.organizationSubscriptionExpiration);
  writeNotNull('SearchIndexID', instance.searchIndexID);
  writeNotNull('BucketName', instance.bucketName);
  writeNotNull('Disabled', instance.disabled);
  writeNotNull('IsMarkedForPurge', instance.isMarkedForPurge);
  writeNotNull('PurgeDate', instance.purgeDate);
  writeNotNull('DocumentCount', instance.documentCount);
  return val;
}
