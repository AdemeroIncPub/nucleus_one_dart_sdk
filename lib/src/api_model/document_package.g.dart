// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPackage _$DocumentPackageFromJson(Map<String, dynamic> json) {
  return DocumentPackage()
    ..document = json['Document']
    ..documentSubscription = json['DocumentSubscription']
    ..approval = json['Approval']
    ..classificationField = json['ClassificationField']
    ..indexFields = (json['IndexFields'] as List<dynamic>?)
        ?.map((e) => IndexField.fromJson(e as Map<String, dynamic>))
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
