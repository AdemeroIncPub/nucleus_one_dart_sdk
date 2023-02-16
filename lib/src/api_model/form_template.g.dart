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

FormSubmissionPackage _$FormSubmissionPackageFromJson(Map<String, dynamic> json) =>
    FormSubmissionPackage()
      ..tenantID = json['TenantID'] as String?
      ..formTemplateID = json['FormTemplateID'] as String?
      ..formSubmissionFields = (json['FormSubmissionFields'] as List<dynamic>?)
          ?.map((e) => FormSubmissionField.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FormSubmissionPackageToJson(FormSubmissionPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('FormTemplateID', instance.formTemplateID);
  writeNotNull('FormSubmissionFields', instance.formSubmissionFields);
  return val;
}

FormSubmissionField _$FormSubmissionFieldFromJson(Map<String, dynamic> json) =>
    FormSubmissionField()
      ..id = json['ID'] as String?
      ..formTemplateID = json['FormTemplateID'] as String?
      ..formTemplateName = json['FormTemplateName'] as String?
      ..formTemplateNameLower = json['FormTemplateNameLower'] as String?
      ..tenantID = json['TenantID'] as String?
      ..uniqueID = json['UniqueID'] as String?
      ..createdOn = json['CreatedOn'] as String?
      ..type = json['Type'] as String?
      ..fieldID = json['FieldID'] as String?
      ..field = json['Field'] == null ? null : Field.fromJson(json['Field'] as Map<String, dynamic>)
      ..pageIndex = json['PageIndex'] as int?
      ..x = (json['X'] as num?)?.toDouble()
      ..y = (json['Y'] as num?)?.toDouble()
      ..width = (json['Width'] as num?)?.toDouble()
      ..fontSize = json['FontSize'] as int?
      ..useColumnLayout = json['UseColumnLayout'] as bool?
      ..assetBucketName = json['AssetBucketName'] as String?
      ..assetObjectName = json['AssetObjectName'] as String?
      ..assetContentType = json['AssetContentType'] as String?
      ..assetSignedUrl = json['AssetSignedUrl'] as String?
      ..defaultValue = json['DefaultValue'] as String?
      ..defaultValues = json['DefaultValues'] as String?
      ..possibleValues =
          (json['PossibleValues'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..value = json['Value'] as String?
      ..values = json['Values'] as String?
      ..formTemplateFieldID = json['FormTemplateFieldID'] as String?;

Map<String, dynamic> _$FormSubmissionFieldToJson(FormSubmissionField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('FormTemplateID', instance.formTemplateID);
  writeNotNull('FormTemplateName', instance.formTemplateName);
  writeNotNull('FormTemplateNameLower', instance.formTemplateNameLower);
  writeNotNull('TenantID', instance.tenantID);
  writeNotNull('UniqueID', instance.uniqueID);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('Type', instance.type);
  writeNotNull('FieldID', instance.fieldID);
  writeNotNull('Field', instance.field);
  writeNotNull('PageIndex', instance.pageIndex);
  writeNotNull('X', instance.x);
  writeNotNull('Y', instance.y);
  writeNotNull('Width', instance.width);
  writeNotNull('FontSize', instance.fontSize);
  writeNotNull('UseColumnLayout', instance.useColumnLayout);
  writeNotNull('AssetBucketName', instance.assetBucketName);
  writeNotNull('AssetObjectName', instance.assetObjectName);
  writeNotNull('AssetContentType', instance.assetContentType);
  writeNotNull('AssetSignedUrl', instance.assetSignedUrl);
  writeNotNull('DefaultValue', instance.defaultValue);
  writeNotNull('DefaultValues', instance.defaultValues);
  writeNotNull('PossibleValues', instance.possibleValues);
  writeNotNull('Value', instance.value);
  writeNotNull('Values', instance.values);
  writeNotNull('FormTemplateFieldID', instance.formTemplateFieldID);
  return val;
}
