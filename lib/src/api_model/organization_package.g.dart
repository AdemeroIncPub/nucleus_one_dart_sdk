// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationPackageCollection _$OrganizationPackageCollectionFromJson(
    Map<String, dynamic> json) {
  return OrganizationPackageCollection()
    ..organizationPackages =
        (json['OrganizationPackagesForCurrentUser'] as List<dynamic>?)
            ?.map(
                (e) => OrganizationPackage.fromJson(e as Map<String, dynamic>))
            .toList();
}

Map<String, dynamic> _$OrganizationPackageCollectionToJson(
    OrganizationPackageCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OrganizationPackagesForCurrentUser',
      instance.organizationPackages);
  return val;
}

OrganizationPackage _$OrganizationPackageFromJson(Map<String, dynamic> json) {
  return OrganizationPackage()
    ..organization = json['Organization'] == null
        ? null
        : Organization.fromJson(json['Organization'] as Map<String, dynamic>)
    ..userID = json['UserID'] as String?
    ..isMember = json['IsMember'] as bool?
    ..isExpiringSoon = json['IsExpiringSoon'] as bool?
    ..expiration = json['Expiration'] as String?
    ..freeUsers = json['FreeUsers'] as int?
    ..isExpired = json['IsExpired'] as bool?;
}

Map<String, dynamic> _$OrganizationPackageToJson(OrganizationPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Organization', instance.organization);
  writeNotNull('UserID', instance.userID);
  writeNotNull('IsMember', instance.isMember);
  writeNotNull('IsExpiringSoon', instance.isExpiringSoon);
  writeNotNull('Expiration', instance.expiration);
  writeNotNull('FreeUsers', instance.freeUsers);
  writeNotNull('IsExpired', instance.isExpired);
  return val;
}
