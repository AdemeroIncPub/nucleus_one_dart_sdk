// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_for_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationForClient _$OrganizationForClientFromJson(Map<String, dynamic> json) =>
    OrganizationForClient()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..name = json['Name'] as String?
      ..createdByUserID = json['CreatedByUserID'] as String?
      ..createdByUserName = json['CreatedByUserName'] as String?
      ..createdByUserEmail = json['CreatedByUserEmail'] as String?
      ..subscriptionRequired = json['SubscriptionRequired'] as bool?
      ..subscriptionFreeUsers = json['SubscriptionFreeUsers'] as int?
      ..subscriptionExpiration = json['SubscriptionExpiration'] as String?
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
  writeNotNull('CreatedByUserID', instance.createdByUserID);
  writeNotNull('CreatedByUserName', instance.createdByUserName);
  writeNotNull('CreatedByUserEmail', instance.createdByUserEmail);
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('SubscriptionFreeUsers', instance.subscriptionFreeUsers);
  writeNotNull('SubscriptionExpiration', instance.subscriptionExpiration);
  writeNotNull(
      'UniqueNonReadOnlyOrganizationMembers', instance.uniqueNonReadOnlyOrganizationMembers);
  writeNotNull('UniqueReadOnlyOrganizationMembers', instance.uniqueReadOnlyOrganizationMembers);
  writeNotNull('UniqueFreeOrganizationMembers', instance.uniqueFreeOrganizationMembers);
  writeNotNull('UniqueBillableOrganizationMembers', instance.uniqueBillableOrganizationMembers);
  return val;
}

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
