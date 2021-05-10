import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../api_model/classification.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../http.dart' as http;
import '../nucleus_one.dart';
import 'query_result.dart';

class ClassificationCollection
    extends EntityCollection<Classification, api_mod.ClassificationCollection> {
  ClassificationCollection({
    NucleusOneAppInternal? app,
    List<Classification>? items,
  }) : super(app: app, items: items);

  factory ClassificationCollection.fromApiModel(api_mod.ClassificationCollection apiModel) {
    return ClassificationCollection(
        items: apiModel.classifications?.map((x) => Classification.fromApiModel(x)).toList());
  }

  @override
  api_mod.ClassificationCollection toApiModel() {
    return api_mod.ClassificationCollection()
      ..classifications = items.map((x) => x.toApiModel()).toList();
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
}

class Classification with NucleusOneAppDependent {
  Classification._(
      {NucleusOneAppInternal? app,
      required this.id,
      required this.createdOn,
      required this.name,
      required this.nameLower,
      required this.isActive}) {
    this.app = app ?? GetIt.instance.get<NucleusOneApp>() as NucleusOneAppInternal;
  }

  factory Classification.fromApiModel(api_mod.Classification apiModel) {
    return Classification._(
        id: apiModel.id!,
        createdOn: apiModel.createdOn!,
        name: apiModel.name!,
        nameLower: apiModel.nameLower!,
        isActive: apiModel.isActive!);
  }

  String id;

  String createdOn;

  String name;

  String nameLower;

  bool isActive;

  api_mod.Classification toApiModel() {
    return api_mod.Classification()
      ..id = id
      ..createdOn = createdOn
      ..name = name
      ..nameLower = nameLower
      ..isActive = isActive;
  }
}

@immutable
class FieldFilter {
  final String id;
  final String value;
  final String type;
  final String valueType;

  FieldFilter(this.id, this.value, this.type, this.valueType);

  Map<String, String> toQueryStringParams(int itemIndex) {
    final idLocal = Uri.encodeComponent(id);
    final valueLocal = Uri.encodeComponent(value);
    final typeLocal = Uri.encodeComponent(type);
    final valueTypeLocal = Uri.encodeComponent(valueType);
    return {
      'fieldID$itemIndex': idLocal,
      'fieldValue$itemIndex': valueLocal,
      'fieldType$itemIndex': typeLocal,
      'fieldValueType$itemIndex': valueTypeLocal,
    };
  }
}
