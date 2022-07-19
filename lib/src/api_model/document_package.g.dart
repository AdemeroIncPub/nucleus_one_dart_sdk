// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPackage _$DocumentPackageFromJson(Map<String, dynamic> json) => DocumentPackage()
  ..projectMember = json['ProjectMember'] == null
      ? null
      : ProjectMember.fromJson(json['ProjectMember'] as Map<String, dynamic>)
  ..projectAccessType = json['ProjectAccessType'] as String?
  ..document =
      json['Document'] == null ? null : Document.fromJson(json['Document'] as Map<String, dynamic>)
  ..documentSubscription = json['DocumentSubscription'] == null
      ? null
      : DocumentSubscriptionForClient.fromJson(json['DocumentSubscription'] as Map<String, dynamic>)
  ..approval =
      json['Approval'] == null ? null : Approval.fromJson(json['Approval'] as Map<String, dynamic>)
  ..fields = (json['Fields'] as List<dynamic>?)
      ?.map((e) => DocumentPackageField.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DocumentPackageToJson(DocumentPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ProjectMember', instance.projectMember);
  writeNotNull('ProjectAccessType', instance.projectAccessType);
  writeNotNull('Document', instance.document);
  writeNotNull('DocumentSubscription', instance.documentSubscription);
  writeNotNull('Approval', instance.approval);
  writeNotNull('Fields', instance.fields);
  return val;
}
