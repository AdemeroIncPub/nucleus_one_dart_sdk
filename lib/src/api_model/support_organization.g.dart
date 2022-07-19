// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportOrganizationCollection _$SupportOrganizationCollectionFromJson(Map<String, dynamic> json) =>
    SupportOrganizationCollection()
      ..supportOrganizations = (json['Organizations'] as List<dynamic>?)
          ?.map((e) => SupportOrganization.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SupportOrganizationCollectionToJson(SupportOrganizationCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Organizations', instance.supportOrganizations);
  return val;
}

SupportOrganization _$SupportOrganizationFromJson(Map<String, dynamic> json) =>
    SupportOrganization()
      ..id = json['ID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..name = json['Name'] as String?
      ..creatingUserName = json['CreatingUserName'] as String?
      ..creatingUserEmail = json['CreatingUserEmail'] as String?
      ..subscriptionRequired = json['SubscriptionRequired'] as bool?
      ..subscriptionFreeUsers = json['SubscriptionFreeUsers'] as int?
      ..subscriptionExpiration = json['SubscriptionExpiration'] as String?
      ..uniqueNonReadOnlyTenantMembers = json['UniqueNonReadOnlyTenantMembers'] as int?
      ..uniqueReadOnlyTenantMembers = json['UniqueReadOnlyTenantMembers'] as int?;

Map<String, dynamic> _$SupportOrganizationToJson(SupportOrganization instance) {
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
  writeNotNull('SubscriptionRequired', instance.subscriptionRequired);
  writeNotNull('SubscriptionFreeUsers', instance.subscriptionFreeUsers);
  writeNotNull('SubscriptionExpiration', instance.subscriptionExpiration);
  writeNotNull('UniqueNonReadOnlyTenantMembers', instance.uniqueNonReadOnlyTenantMembers);
  writeNotNull('UniqueReadOnlyTenantMembers', instance.uniqueReadOnlyTenantMembers);
  return val;
}
