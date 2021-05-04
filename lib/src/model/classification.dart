import 'dart:convert';

import 'package:get_it/get_it.dart';

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

  // https://client-api.multi-tenant-dms-staging.com/api/v1/classifications?getAll=true&includeDisabled=true

  /// Gets recent documents, by page.
  ///
  /// [sortType]: Which field to sort on.
  ///
  /// [sortDescending]: Sort order.
  ///
  /// [offset]: The number of initial results to skip.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [singleRecord]: Limits the results to a single document.
  Future<QueryResult<ClassificationCollection>> get({
    String sortType = 'CreatedOn',
    bool sortDescending = true,
    int? offset,
    String? cursor,
    bool? getAll,
    bool? includeDisabled,
  }) async {
    final qp = http.StandardQueryParams.get([
      // (sqp) => sqp.sortType(sortType),
      // (sqp) => sqp.sortDescending(sortDescending),
      // (sqp) => sqp.cursor(cursor),
      // (sqp) => sqp.offset(offset),
    ]);
    if (getAll != null) {
      qp['getAll'] = getAll;
    }
    if (includeDisabled != null) {
      qp['includeDisabled'] = includeDisabled;
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

  @override
  api_mod.ClassificationCollection toApiModel() {
    return api_mod.ClassificationCollection()
      ..classifications = items.map((x) => x.toApiModel()).toList();
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
