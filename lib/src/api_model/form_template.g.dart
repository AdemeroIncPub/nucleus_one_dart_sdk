// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormTemplateCollection _$FormTemplateCollectionFromJson(
    Map<String, dynamic> json) {
  return FormTemplateCollection()
    ..formTemplates = (json['FormTemplates'] as List<dynamic>?)
        ?.map((e) => FormTemplate.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FormTemplateCollectionToJson(
    FormTemplateCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FormTemplates', instance.formTemplates);
  return val;
}

FormTemplate _$FormTemplateFromJson(Map<String, dynamic> json) {
  return FormTemplate()
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
}

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

FormTemplateFieldItem _$FormTemplateFieldItemFromJson(
    Map<String, dynamic> json) {
  return FormTemplateFieldItem()
    ..id = json['ID'] as String?
    ..formTemplateID = json['FormTemplateID'] as String?
    ..formTemplateName = json['FormTemplateName'] as String?
    ..formTemplateNameLower = json['FormTemplateNameLower'] as String?
    ..tenantID = json['TenantID'] as String?
    ..uniqueID = json['UniqueID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..type = json['Type'] as String?
    ..fieldID = json['FieldID'] as String?
    ..field = json['Field'] == null
        ? null
        : FormTemplateField.fromJson(json['Field'] as Map<String, dynamic>)
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
    ..possibleValues = json['PossibleValues']
    ..value = json['Value'] as String?
    ..values = json['Values'] as String?;
}

Map<String, dynamic> _$FormTemplateFieldItemToJson(
    FormTemplateFieldItem instance) {
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

FormTemplateField _$FormTemplateFieldFromJson(Map<String, dynamic> json) {
  return FormTemplateField()
    ..id = json['ID'] as String?
    ..createdOn = json['CreatedOn'] as String?
    ..parentFieldID = json['ParentFieldID'] as String?
    ..name = json['Name'] as String?
    ..nameLower = json['NameLower'] as String?
    ..label = json['Label'] as String?
    ..labelLower = json['LabelLower'] as String?
    ..labelOrName = json['LabelOrName'] as String?
    ..labelOrNameLower = json['LabelOrNameLower'] as String?
    ..type = json['Type'] as String?
    ..displaySelectionList = json['DisplaySelectionList'] as bool?
    ..allowMultipleLines = json['AllowMultipleLines'] as bool?
    ..rows = json['Rows'] as int?
    ..allowMultipleValues = json['AllowMultipleValues'] as bool?
    ..allowNewSelectionListItems = json['AllowNewSelectionListItems'] as bool?
    ..saveNewSelectionListItems = json['SaveNewSelectionListItems'] as bool?
    ..decimalPlaces = json['DecimalPlaces'] as int?
    ..mask = json['Mask'] as String?
    ..required = json['Required'] as bool?
    ..sensitive = json['Sensitive'] as bool?
    ..useCreationDate = json['UseCreationDate'] as bool?
    ..textMatchType = json['TextMatchType'] as String?;
}

Map<String, dynamic> _$FormTemplateFieldToJson(FormTemplateField instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ID', instance.id);
  writeNotNull('CreatedOn', instance.createdOn);
  writeNotNull('ParentFieldID', instance.parentFieldID);
  writeNotNull('Name', instance.name);
  writeNotNull('NameLower', instance.nameLower);
  writeNotNull('Label', instance.label);
  writeNotNull('LabelLower', instance.labelLower);
  writeNotNull('LabelOrName', instance.labelOrName);
  writeNotNull('LabelOrNameLower', instance.labelOrNameLower);
  writeNotNull('Type', instance.type);
  writeNotNull('DisplaySelectionList', instance.displaySelectionList);
  writeNotNull('AllowMultipleLines', instance.allowMultipleLines);
  writeNotNull('Rows', instance.rows);
  writeNotNull('AllowMultipleValues', instance.allowMultipleValues);
  writeNotNull(
      'AllowNewSelectionListItems', instance.allowNewSelectionListItems);
  writeNotNull('SaveNewSelectionListItems', instance.saveNewSelectionListItems);
  writeNotNull('DecimalPlaces', instance.decimalPlaces);
  writeNotNull('Mask', instance.mask);
  writeNotNull('Required', instance.required);
  writeNotNull('Sensitive', instance.sensitive);
  writeNotNull('UseCreationDate', instance.useCreationDate);
  writeNotNull('TextMatchType', instance.textMatchType);
  return val;
}
