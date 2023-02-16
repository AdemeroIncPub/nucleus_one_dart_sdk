// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormTemplate _$FormTemplateFromJson(Map<String, dynamic> json) => FormTemplate()
  ..id = json['ID'] as String?
  ..tenantID = json['TenantID'] as String?
  ..uniqueID = json['UniqueID'] as String?
  ..createdOn = json['CreatedOn'] as String?
  ..name = json['Name'] as String?
  ..nameLower = json['NameLower'] as String?
  ..pageCount = json['PageCount'] as int?
  ..isPublic = json['IsPublic'] as bool?
  ..classificationID = json['ClassificationID'] as String?
  ..classificationName = json['ClassificationName'] as String?
  ..classificationNameLower = json['ClassificationNameLower'] as String?
  ..aspect = (json['Aspect'] as num?)?.toDouble();

Map<String, dynamic> _$FormTemplateToJson(FormTemplate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('PageCount', instance.pageCount);
  writeNotNull('IsPublic', instance.isPublic);
  writeNotNull('ClassificationID', instance.classificationID);
  writeNotNull('ClassificationName', instance.classificationName);
  writeNotNull('ClassificationNameLower', instance.classificationNameLower);
  writeNotNull('Aspect', instance.aspect);
  return val;
}

FormTemplateCollection _$FormTemplateCollectionFromJson(Map<String, dynamic> json) =>
    FormTemplateCollection()
      ..formTemplates = (json['FormTemplates'] as List<dynamic>?)
          ?.map((e) => FormTemplate.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FormTemplateCollectionToJson(FormTemplateCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FormTemplates', instance.formTemplates);
  return val;
}
