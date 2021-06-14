import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/field_list_item.dart' as api_mod;
import '../api_model/form_template.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../http.dart' as http;
import '../nucleus_one.dart';

class FormTemplateCollection
    extends EntityCollection<FormTemplate, api_mod.FormTemplateCollection> {
  FormTemplateCollection({
    NucleusOneAppInternal? app,
    List<FormTemplate>? items,
  }) : super(app: app, items: items);

  factory FormTemplateCollection.fromApiModel(api_mod.FormTemplateCollection apiModel) {
    return FormTemplateCollection(
        items: apiModel.formTemplates?.map((x) => FormTemplate.fromApiModel(x)).toList());
  }

  @override
  api_mod.FormTemplateCollection toApiModel() {
    return api_mod.FormTemplateCollection()
      ..formTemplates = items.map((x) => x.toApiModel()).toList();
  }

  /// Gets form templates, by page.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [sortDescending]: Sort order.
  Future<QueryResult<FormTemplateCollection>> get({
    String? cursor,
    bool sortDescending = false,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplates,
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.FormTemplateCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: FormTemplateCollection(
          items:
              apiModel.results!.formTemplates!.map((x) => FormTemplate.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets a form template by id.
  ///
  /// [id]: The id of the form template.
  ///
  /// [uniqueId]: A unique id that identifies that you are permitted to access this resource.
  Future<FormTemplate> getById(String id, String uniqueId) async {
    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = uniqueId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFormat.replaceFirst('<formTemplateId>', id),
      app,
      query: qp,
    );
    final apiModel = api_mod.FormTemplate.fromJson(jsonDecode(responseBody));
    return FormTemplate.fromApiModel(apiModel);
  }

  /// Gets a form template by id.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  Future<FormTemplateFieldCollection> getFields(String formTemplateId, String projectId) async {
    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFieldsFormat
          .replaceFirst('<formTemplateId>', formTemplateId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return FormTemplateFieldCollection.fromApiModel(apiModel);
  }

  /// Gets a form template field's list items.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [parentValue]: The value of parent field.
  ///
  /// [valueFilter]: Limits results to fields whose value contains this text.
  Future<FieldListItemCollection> getFieldListItems(
    String formTemplateId,
    String formTemplateFieldId,
    String projectId, {
    String? parentValue,
    String? valueFilter,
    // At the time of writing this, cursor was not implemented in the API
    // String? cursor,
  }) async {
    final qp = ListItems.getListItemsQueryParams(null, parentValue, valueFilter);
    qp['tenantId'] = projectId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FieldListItemCollection.fromJson(jsonDecode(responseBody));
    return FieldListItemCollection.fromApiModel(apiModel);
  }

  /// Adds list items to a form template field's selection list.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [items]: The list items to add or update.
  Future<void> addListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required String projectId,
    required FieldListItemCollection items,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }
    if (projectId.isEmpty) {
      throw ArgumentError.value(projectId, 'projectId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    await ListItems.addListItems(
      app: app,
      apiRelativeUrlPath: http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      items: items,
      additionalQueryParams: qp,
    );
  }

  /// Sets or replaces a form template field's selection list items.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [listItems]: The list items to add or update.
  Future<void> setListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required String projectId,
    required List<String> values,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }
    if (projectId.isEmpty) {
      throw ArgumentError.value(projectId, 'projectId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    await ListItems.setListItems(
      app: app,
      apiRelativeUrlPath: http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      values: values,
      additionalQueryParams: qp,
    );
  }
}

class FormTemplate with NucleusOneAppDependent {
  FormTemplate._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.tenantID,
      required this.uniqueID,
      required this.createdOn,
      required this.name,
      required this.nameLower,
      required this.pageCount,
      required this.isPublic,
      required this.classificationID,
      required this.classificationName,
      required this.classificationNameLower,
      required this.aspect}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FormTemplate.fromApiModel(api_mod.FormTemplate apiModel) {
    return FormTemplate._(
        id: apiModel.id!,
        tenantID: apiModel.tenantID!,
        uniqueID: apiModel.uniqueID!,
        createdOn: apiModel.createdOn!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        pageCount: apiModel.pageCount!,
        isPublic: apiModel.isPublic!,
        classificationID: apiModel.classificationID!,
        classificationName: apiModel.classificationName!,
        classificationNameLower: apiModel.classificationNameLower!,
        aspect: apiModel.aspect!);
  }

  String id;

  String tenantID;

  String uniqueID;

  String createdOn;

  String name;

  String nameLower;

  int pageCount;

  bool isPublic;

  String classificationID;

  String classificationName;

  String classificationNameLower;

  double aspect;

  api_mod.FormTemplate toApiModel() {
    return api_mod.FormTemplate()
      ..id = id
      ..tenantID = tenantID
      ..uniqueID = uniqueID
      ..createdOn = createdOn
      ..name = name
      ..nameLower = nameLower
      ..pageCount = pageCount
      ..isPublic = isPublic
      ..classificationID = classificationID
      ..classificationName = classificationName
      ..classificationNameLower = classificationNameLower
      ..aspect = aspect;
  }
}

class FormTemplateFieldCollection
    extends EntityCollection<FormTemplateFieldItem, api_mod.FormTemplateFieldCollection> {
  FormTemplateFieldCollection({
    NucleusOneAppInternal? app,
    List<FormTemplateFieldItem>? items,
  }) : super(app: app, items: items);

  factory FormTemplateFieldCollection.fromApiModel(api_mod.FormTemplateFieldCollection apiModel) {
    return FormTemplateFieldCollection(
        items: apiModel.items.map((x) => FormTemplateFieldItem.fromApiModel(x)).toList());
  }

  @override
  api_mod.FormTemplateFieldCollection toApiModel() {
    return api_mod.FormTemplateFieldCollection()..items = items.map((x) => x.toApiModel()).toList();
  }
}

class FormTemplateFieldItem with NucleusOneAppDependent {
  FormTemplateFieldItem._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.formTemplateID,
      required this.formTemplateName,
      required this.formTemplateNameLower,
      required this.tenantID,
      required this.uniqueID,
      required this.createdOn,
      required this.type,
      required this.fieldID,
      required this.field,
      required this.pageIndex,
      required this.x,
      required this.y,
      required this.width,
      required this.fontSize,
      required this.useColumnLayout,
      required this.assetBucketName,
      required this.assetObjectName,
      required this.assetContentType,
      required this.assetSignedUrl,
      required this.defaultValue,
      required this.defaultValues,
      required this.possibleValues,
      required this.value,
      required this.values}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FormTemplateFieldItem.fromApiModel(api_mod.FormTemplateFieldItem apiModel) {
    return FormTemplateFieldItem._(
        id: apiModel.id!,
        formTemplateID: apiModel.formTemplateID!,
        formTemplateName: apiModel.formTemplateName!,
        formTemplateNameLower: apiModel.formTemplateNameLower!,
        tenantID: apiModel.tenantID!,
        uniqueID: apiModel.uniqueID!,
        createdOn: apiModel.createdOn!,
        type: apiModel.type!,
        fieldID: apiModel.fieldID!,
        field: FormTemplateField.fromApiModel(apiModel.field!),
        pageIndex: apiModel.pageIndex!,
        x: apiModel.x!,
        y: apiModel.y!,
        width: apiModel.width!,
        fontSize: apiModel.fontSize!,
        useColumnLayout: apiModel.useColumnLayout!,
        assetBucketName: apiModel.assetBucketName!,
        assetObjectName: apiModel.assetObjectName!,
        assetContentType: apiModel.assetContentType!,
        assetSignedUrl: apiModel.assetSignedUrl!,
        defaultValue: apiModel.defaultValue!,
        defaultValues: apiModel.defaultValues!,
        possibleValues: apiModel.possibleValues,
        value: apiModel.value!,
        values: apiModel.values!);
  }

  String id;

  String formTemplateID;

  String formTemplateName;

  String formTemplateNameLower;

  String tenantID;

  String uniqueID;

  String createdOn;

  String type;

  String fieldID;

  FormTemplateField field;

  int pageIndex;

  double x;

  double y;

  double width;

  int fontSize;

  bool useColumnLayout;

  String assetBucketName;

  String assetObjectName;

  String assetContentType;

  String assetSignedUrl;

  String defaultValue;

  String defaultValues;

  dynamic? possibleValues;

  String value;

  String values;

  api_mod.FormTemplateFieldItem toApiModel() {
    return api_mod.FormTemplateFieldItem()
      ..id = id
      ..formTemplateID = formTemplateID
      ..formTemplateName = formTemplateName
      ..formTemplateNameLower = formTemplateNameLower
      ..tenantID = tenantID
      ..uniqueID = uniqueID
      ..createdOn = createdOn
      ..type = type
      ..fieldID = fieldID
      ..field = field.toApiModel()
      ..pageIndex = pageIndex
      ..x = x
      ..y = y
      ..width = width
      ..fontSize = fontSize
      ..useColumnLayout = useColumnLayout
      ..assetBucketName = assetBucketName
      ..assetObjectName = assetObjectName
      ..assetContentType = assetContentType
      ..assetSignedUrl = assetSignedUrl
      ..defaultValue = defaultValue
      ..defaultValues = defaultValues
      ..possibleValues = possibleValues
      ..value = value
      ..values = values;
  }
}

class FormTemplateField with NucleusOneAppDependent {
  FormTemplateField._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.parentFieldID,
      required this.name,
      required this.nameLower,
      required this.label,
      required this.labelLower,
      required this.labelOrName,
      required this.labelOrNameLower,
      required this.type,
      required this.displaySelectionList,
      required this.allowMultipleLines,
      required this.rows,
      required this.allowMultipleValues,
      required this.allowNewSelectionListItems,
      required this.saveNewSelectionListItems,
      required this.decimalPlaces,
      required this.mask,
      required this.required,
      required this.sensitive,
      required this.useCreationDate,
      required this.textMatchType}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory FormTemplateField.fromApiModel(api_mod.FormTemplateField apiModel) {
    return FormTemplateField._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        parentFieldID: apiModel.parentFieldID!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        label: apiModel.label!,
        labelLower: apiModel.labelLower!,
        labelOrName: apiModel.labelOrName!,
        labelOrNameLower: apiModel.labelOrNameLower!,
        type: apiModel.type!,
        displaySelectionList: apiModel.displaySelectionList!,
        allowMultipleLines: apiModel.allowMultipleLines!,
        rows: apiModel.rows!,
        allowMultipleValues: apiModel.allowMultipleValues!,
        allowNewSelectionListItems: apiModel.allowNewSelectionListItems!,
        saveNewSelectionListItems: apiModel.saveNewSelectionListItems!,
        decimalPlaces: apiModel.decimalPlaces!,
        mask: apiModel.mask!,
        required: apiModel.required!,
        sensitive: apiModel.sensitive!,
        useCreationDate: apiModel.useCreationDate!,
        textMatchType: apiModel.textMatchType!);
  }

  String id;

  String createdOn;

  String parentFieldID;

  String name;

  String nameLower;

  String label;

  String labelLower;

  String labelOrName;

  String labelOrNameLower;

  String type;

  bool displaySelectionList;

  bool allowMultipleLines;

  int rows;

  bool allowMultipleValues;

  bool allowNewSelectionListItems;

  bool saveNewSelectionListItems;

  int decimalPlaces;

  String mask;

  bool required;

  bool sensitive;

  bool useCreationDate;

  String textMatchType;

  api_mod.FormTemplateField toApiModel() {
    return api_mod.FormTemplateField()
      ..id = id
      ..createdOn = createdOn
      ..parentFieldID = parentFieldID
      ..name = name
      ..nameLower = nameLower
      ..label = label
      ..labelLower = labelLower
      ..labelOrName = labelOrName
      ..labelOrNameLower = labelOrNameLower
      ..type = type
      ..displaySelectionList = displaySelectionList
      ..allowMultipleLines = allowMultipleLines
      ..rows = rows
      ..allowMultipleValues = allowMultipleValues
      ..allowNewSelectionListItems = allowNewSelectionListItems
      ..saveNewSelectionListItems = saveNewSelectionListItems
      ..decimalPlaces = decimalPlaces
      ..mask = mask
      ..required = required
      ..sensitive = sensitive
      ..useCreationDate = useCreationDate
      ..textMatchType = textMatchType;
  }
}
