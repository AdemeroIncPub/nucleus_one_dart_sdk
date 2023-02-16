// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_template_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormTemplateField _$FormTemplateFieldFromJson(Map<String, dynamic> json) => FormTemplateField()
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
  ..possibleValues = (json['PossibleValues'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..value = json['Value'] as String?
  ..values = json['Values'] as String?;

Map<String, dynamic> _$FormTemplateFieldToJson(FormTemplateField instance) {
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
  return val;
}
