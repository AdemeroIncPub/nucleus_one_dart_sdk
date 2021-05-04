import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';

import '../api_model/classification.dart' as api_mod;
import '../http.dart' as http;
import '../nucleus_one.dart';

abstract class _ClassificationCollectionQueryResult {
  static QueryResult<ClassificationCollection> fromApiModelClassificationCollection(
      api_mod.ClassificationCollection apiModel) {
    return QueryResult(
      results: ClassificationCollection(
          items: apiModel.classifications!.map((x) => Classification.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }
}

class ClassificationCollection extends EntityCollection<Classification> {
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
    final api = api_mod.ClassificationCollection.fromJson(jsonDecode(responseBody));
    return _ClassificationCollectionQueryResult.fromApiModelClassificationCollection(api);
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
