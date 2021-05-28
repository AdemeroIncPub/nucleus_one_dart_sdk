import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_field.dart';

import '../nucleus_one.dart';
import '../http.dart' as http;
import '../../nucleus_one_dart_sdk.dart';
import '../api_model/query_result.dart' as api_mod;
import '../api_model/document_field.dart' as api_mod;
import '../api_model/field.dart' as api_mod;
import '../api_model/field_list_item.dart' as api_mod;

class NucleusOneAppFields with NucleusOneAppDependent {
  NucleusOneAppFields({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets DocumentFields.
  ///
  ///
  Future<QueryResult<DocumentFieldCollection>> getDocumentFields({
    String? fieldId,
    String? fieldValueType,
    String? classificationId,
    String? cursor,
    List<FieldFilter>? fieldFilters,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (fieldId != null) {
      qp['fieldID'] = fieldId;
    }
    if (fieldValueType != null) {
      qp['fieldValueType'] = fieldValueType;
    }
    if (classificationId != null) {
      qp['classificationID'] = classificationId;
    }
    if (fieldFilters != null) {
      for (var count = fieldFilters.length, i = 0; i < count; ++i) {
        qp.addAll(fieldFilters[i].toQueryStringParams(i));
      }
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentFields,
      app,
      query: qp,
    );

    final apiModel =
        api_mod.QueryResult<api_mod.DocumentFieldCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: DocumentFieldCollection(
          items:
              apiModel.results!.documentFields?.map((x) => DocumentField.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
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
  Future<QueryResult<FieldCollection>> getFields({
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
  Future<Field> getFieldById(String id) async {
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.fieldsFormat.replaceFirst('<fieldId>', id),
      app,
    );
    final apiModel = api_mod.Field.fromJson(jsonDecode(responseBody));
    return Field.fromApiModel(apiModel);
  }

  Map<String, dynamic> _getFieldListItemsQueryParams(
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
  Future<FieldListItemCollection> getFieldListItems({
    required String id,
    String? parentValue,
    String? valueFilter,
    String? cursor,
  }) async {
    final qp = _getFieldListItemsQueryParams(cursor, parentValue, valueFilter);
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
  Future<void> downloadFieldListItems({
    required String id,
    String? parentValue,
    String? valueFilter,
    required String destinationFilePath,
    String? cursor,
  }) async {
    final qp = _getFieldListItemsQueryParams(cursor, parentValue, valueFilter);
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
  Future<void> addFieldListItems(
      {required String id, required FieldListItemCollection items}) async {
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
  Future<void> setFieldListItems({required String id, required List<String> values}) async {
    if (id.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Value cannot be blank.');
    }
    if (values.isEmpty) {
      throw ArgumentError.value(values, 'values', 'Cannot be empty.');
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
