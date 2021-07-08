// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPackage _$DocumentPackageFromJson(Map<String, dynamic> json) {
  return DocumentPackage()
    ..document = json['Document'] == null
        ? null
        : Document.fromJson(json['Document'] as Map<String, dynamic>)
    ..documentSubscription = json['DocumentSubscription'] == null
        ? null
        : DocumentSubscriptionForClient.fromJson(
            json['DocumentSubscription'] as Map<String, dynamic>)
    ..approval = json['Approval'] == null
        ? null
        : Approval.fromJson(json['Approval'] as Map<String, dynamic>)
    ..classificationField = json['ClassificationField'] == null
        ? null
        : DocumentPackageField.fromJson(
            json['ClassificationField'] as Map<String, dynamic>)
    ..indexFields = (json['IndexFields'] as List<dynamic>?)
        ?.map((e) => DocumentPackageField.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DocumentPackageToJson(DocumentPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Document', instance.document);
  writeNotNull('DocumentSubscription', instance.documentSubscription);
  writeNotNull('Approval', instance.approval);
  writeNotNull('ClassificationField', instance.classificationField);
  writeNotNull('IndexFields', instance.indexFields);
  return val;
}
