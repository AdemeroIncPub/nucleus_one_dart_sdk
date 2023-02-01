// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_membership_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationMembershipPackage _$OrganizationMembershipPackageFromJson(Map<String, dynamic> json) =>
    OrganizationMembershipPackage()
      ..organization = json['Organization'] == null
          ? null
          : Organization.fromJson(json['Organization'] as Map<String, dynamic>)
      ..organizationMember = json['OrganizationMember'] == null
          ? null
          : OrganizationMember.fromJson(json['OrganizationMember'] as Map<String, dynamic>)
      ..userID = json['UserID'] as String?
      ..isAdmin = json['IsAdmin'] as bool?
      ..isExpiringSoon = json['IsExpiringSoon'] as bool?
      ..expiration = json['Expiration'] as String?
      ..freeUsers = json['FreeUsers'] as int?
      ..isExpired = json['IsExpired'] as bool?;

Map<String, dynamic> _$OrganizationMembershipPackageToJson(OrganizationMembershipPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Organization', instance.organization);
  writeNotNull('OrganizationMember', instance.organizationMember);
  writeNotNull('UserID', instance.userID);
  writeNotNull('IsAdmin', instance.isAdmin);
  writeNotNull('IsExpiringSoon', instance.isExpiringSoon);
  writeNotNull('Expiration', instance.expiration);
  writeNotNull('FreeUsers', instance.freeUsers);
  writeNotNull('IsExpired', instance.isExpired);
  return val;
}

OrganizationMembershipPackageCollection _$OrganizationMembershipPackageCollectionFromJson(
        Map<String, dynamic> json) =>
    OrganizationMembershipPackageCollection()
      ..membershipPackages = (json['OrganizationMembershipPackages'] as List<dynamic>?)
          ?.map((e) => OrganizationMembershipPackage.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OrganizationMembershipPackageCollectionToJson(
    OrganizationMembershipPackageCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OrganizationMembershipPackages', instance.membershipPackages);
  return val;
}
