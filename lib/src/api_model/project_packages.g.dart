// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectPackage _$ProjectPackageFromJson(Map<String, dynamic> json) {
  return ProjectPackage()
    ..tenant = json['Tenant'] == null
        ? null
        : Project.fromJson(json['Tenant'] as Map<String, dynamic>)
    ..tenantMember = json['TenantMember'] == null
        ? null
        : ProjectMember.fromJson(json['TenantMember'] as Map<String, dynamic>)
    ..isAdmin = json['IsAdmin'] as bool?;
}

Map<String, dynamic> _$ProjectPackageToJson(ProjectPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Tenant', instance.tenant);
  writeNotNull('TenantMember', instance.tenantMember);
  writeNotNull('IsAdmin', instance.isAdmin);
  return val;
}
