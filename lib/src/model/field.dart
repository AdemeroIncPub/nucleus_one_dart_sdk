import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/string.dart';

import '../../nucleus_one_dart_sdk.dart';
import '../api_model/field.dart' as api_mod;
import '../api_model/field_list_item.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../http.dart' as http;
import '../nucleus_one.dart';

class FieldCollection extends EntityCollection<Field, api_mod.FieldCollection> {
  FieldCollection({
    NucleusOneAppInternal? app,
    List<Field>? items,
  }) : super(app: app, items: items);

  factory FieldCollection.fromApiModel(api_mod.FieldCollection apiModel) {
    return FieldCollection(items: apiModel.fields?.map((x) => Field.fromApiModel(x)).toList());
  }

  @override
  api_mod.FieldCollection toApiModel() {
    return api_mod.FieldCollection()..fields = items.map((x) => x.toApiModel()).toList();
  }

  /// Gets fields, by page.
  ///
  /// [getAll]: Whether to retrieve all fields.
  ///
  /// [filter]: Limits results to fields whose name contains this text.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [includeClassificationIds]: Limits the results to fields beloning to these classifications.
  Future<QueryResult<FieldCollection>> get({
    String? cursor,
    bool? getAll,
    String? filter,
    List<String>? includeClassificationIds,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }
    if (filter != null) {
      qp['filter'] = filter;
    }
    if ((includeClassificationIds != null) && includeClassificationIds.isNotEmpty) {
      final json = jsonEncode(includeClassificationIds);
      final base64 = base64Encode(utf8.encode(json));
      qp['classificationIDs_json_base64'] = base64;
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.fields,
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.FieldCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: FieldCollection(
          items: apiModel.results!.fields!.map((x) => Field.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets as field by its id.
  ///
  /// [id]: The id of the field.
  Future<Field> getById(String id) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.fieldsFormat.replaceFirst('<fieldId>', id),
      app,
    );
    final apiModel = api_mod.Field.fromJson(jsonDecode(responseBody));
    return Field.fromApiModel(apiModel);
  }

  Map<String, dynamic> _getListItemsQueryParams(
      String? cursor, String? parentValue, String? valueFilter) {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (parentValue != null) {
      qp['parentValue'] = parentValue;
    }
    if (valueFilter != null) {
      qp['valueFilter'] = valueFilter;
    }
    return qp;
  }

  /// Gets a field's list items, by page.
  ///
  /// [id]: The id of the field.
  ///
  /// [parentValue]: The value of parent field.
  ///
  /// [valueFilter]: Limits results to fields whose value contains this text.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<FieldListItemCollection> getListItems({
    required String id,
    String? parentValue,
    String? valueFilter,
    String? cursor,
  }) async {
    final qp = _getListItemsQueryParams(cursor, parentValue, valueFilter);
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', id),
      app,
      query: qp,
    );
    final apiModel = api_mod.FieldListItemCollection.fromJson(jsonDecode(responseBody));
    return FieldListItemCollection.fromApiModel(apiModel);
  }

  /// Downloads a field's list items, by page.
  ///
  /// [id]: The id of the field.
  ///
  /// [parentValue]: The value of parent field.
  ///
  /// [valueFilter]: Limits results to fields whose value contains this text.
  ///
  /// [destinationFilePath]: The file path where the download should be saved.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  Future<void> downloadListItems({
    required String id,
    String? parentValue,
    String? valueFilter,
    required String destinationFilePath,
    String? cursor,
  }) async {
    final qp = _getListItemsQueryParams(cursor, parentValue, valueFilter);
    qp['getAllAsFlatFile'] = true;
    await http.downloadAuthenticated(
        http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', id), destinationFilePath, app,
        query: qp);
  }

  /// Adds list items to a field's selection list.
  ///
  /// [id]: The id of the field.
  ///
  /// [listItems]: The list items to add or update.
  Future<void> addListItems({required String id, required FieldListItemCollection items}) async {
    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
    if (items.items.isEmpty) {
      throw ArgumentError.value(items, 'items', 'Cannot be empty.');
    }

    final bodyList = items.toApiModel().items;

    // Only keep the properties needed for this operation
    final jsonList = bodyList.map((x) {
      final jsonMap = x.toJson();
      jsonMap.removeWhere((key, value) {
        return (key == 'ID') ? isNullOrEmpty(value) : false;
      });
      return jsonMap;
    }).toList();

    final qp = http.StandardQueryParams.get();

    await http.executePostRequest(
      http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', id),
      app,
      query: qp,
      body: jsonEncode(jsonList),
    );
  }

  /// Sets or replaces a field's selection list items.
  ///
  /// [id]: The id of the field.
  ///
  /// [listItems]: The list items to add or update.
  Future<void> setListItems({required String id, required List<String> values}) async {
    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
    if (values.isEmpty) {
      throw ArgumentError.value(items, 'values', 'Cannot be empty.');
    }

    final qp = http.StandardQueryParams.get();
    qp['type'] = 'file';

    await http.executePostRequest(
      http.apiPaths.fieldsListItemsFormat.replaceFirst('<fieldId>', id),
      app,
      query: qp,
      body: values.join('\n') + '\n',
    );
  }
}

class Field with NucleusOneAppDependent {
  Field._(
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

  factory Field.fromApiModel(api_mod.Field apiModel) {
    return Field._(
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

  api_mod.Field toApiModel() {
    return api_mod.Field()
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
