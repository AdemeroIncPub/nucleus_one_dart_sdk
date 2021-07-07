import 'dart:convert';

import '../api_model/classification.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../http.dart' as http;
import '../model/classification.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';

class NucleusOneAppClassifications with NucleusOneAppDependent {
  NucleusOneAppClassifications({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets classifications, by page.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [getAll]: Whether to retrieve all classifications.
  ///
  /// [includeDisabled]: Whether to include disabled fields in the results.  The default is false.
  ///
  /// [filter]: Limits results to fields whose name contains this text.
  ///
  /// [fieldFilters]: Limits results to fields which fit these criteria.
  ///
  /// [includeClassificationIds]: Limits the results to fields beloning to these classifications.
  Future<QueryResult<ClassificationCollection>> get({
    String? cursor,
    bool? getAll,
    bool? includeDisabled,
    String? filter,
    List<FieldFilter>? fieldFilters,
    List<String>? includeClassificationIds,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }
    if (includeDisabled != null) {
      qp['includeDisabled'] = includeDisabled;
    }
    if (filter != null) {
      qp['filter'] = filter;
    }
    if (fieldFilters != null) {
      for (var count = fieldFilters.length, i = 0; i < count; ++i) {
        qp.addAll(fieldFilters[i].toQueryStringParams(i));
      }
    }
    if ((includeClassificationIds != null) && includeClassificationIds.isNotEmpty) {
      qp['includeClassificationIds_json'] = jsonEncode(includeClassificationIds);
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.classifications,
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.ClassificationCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: ClassificationCollection(
          items: apiModel.results!.classifications!
              .map((x) => Classification.fromApiModel(x))
              .toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets a classification's fields.
  ///
  /// [classificationId]: The classification id.
  Future<ClassificationFieldCollection> getFields(
    String classificationId,
  ) async {
    if (classificationId.isEmpty) {
      throw ArgumentError.value(classificationId, 'classificationId', 'Value cannot be blank.');
    }

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.classificationFieldsFormat.replaceFirst('<classificationId>', classificationId),
      app,
    );
    final apiModel = api_mod.ClassificationFieldCollection.fromJson(jsonDecode(responseBody));
    return ClassificationFieldCollection.fromApiModel(apiModel);
  }
}
