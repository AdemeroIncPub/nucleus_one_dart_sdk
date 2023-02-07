import 'dart:convert';
import 'dart:mirrors';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_task.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import 'mirrors.dart';

User getStandardTestUser() {
  return User(
    app: getStandardN1App(),
  );
}

NucleusOneApp getStandardN1App({
  String baseUrl = '',
  String apiKey = '',
}) {
  return NucleusOneApp(
    options: NucleusOneOptions(
      apiBaseUrl: baseUrl,
      apiKey: apiKey,
    ),
  );
}

NucleusOneAppOrganization getStandardN1Org([String id = 'orgId']) {
  return NucleusOneAppOrganization(
    app: getStandardN1App(),
    id: id,
  );
}

NucleusOneAppProject getStandardN1Project([String id = 'projId']) {
  return NucleusOneAppProject(
    organization: getStandardN1Org(),
    id: id,
  );
}

NucleusOneAppTask getStandardN1Task([String id = 'taskId']) {
  return NucleusOneAppTask(
    project: getStandardN1Project(),
    taskId: id,
  );
}

/// Returns a matcher that tests if the value equals the API call's full URL.
Matcher apiRequestPathMatches(String relativePath) =>
    wrapMatcher(getStandardN1App().getFullUrl(relativePath));

/// Performs standard model tests, including:
/// - Field count verification
/// - Serialization
///   - From JSON
///   - API-Model -> Model -> API Model
void performStandardQueryResultModelTests<
    TModel extends EntityCollection<NucleusOneAppDependent, dynamic>,
    TApiModel,
    TColModel extends QueryResult<TModel, TApiModel>,
    TColApiModel extends api_mod.QueryResult<TApiModel>>({
  bool requiresAppAndProjectInScope = false,
  required String apiModelJson,
}) {
  // QueryResult (and QueryResult2) classes should always have 1 field; the "result" field.
  performStandardModelTests<TApiModel, TModel>(
    requiresAppAndProjectInScope: requiresAppAndProjectInScope,
    expectedPublicFieldCount: 1,
    fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{},
    apiModelJson: '{}',
  );

  final isQueryResult2 = (TColModel == QueryResult2<TModel, TApiModel>);

  performStandardModelTests<TColApiModel, TColModel>(
    requiresAppAndProjectInScope: requiresAppAndProjectInScope,
    apiModelJson: apiModelJson,
    expectedPublicFieldCount: isQueryResult2 ? 4 : 3,
    fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
      _getSinglePublicResultFieldValue<TApiModel>(apiModel).length: 1,
      apiModel.cursor: 'QueryResultA',
      if (isQueryResult2)
        (apiModel as api_mod.QueryResult2<TApiModel>).reverseCursor: 'QueryResultB',
      apiModel.pageSize: 24,
    },
  );
}

/// QueryResult (and QueryResult2) classes should always have only one field; the one that contains
/// the results list for that type.
List _getSinglePublicResultFieldValue<TApiModel>(dynamic apiModel) {
  final resultFieldMirror = getClassPublicFields(TApiModel)[0];
  return reflect(apiModel.results).getField(resultFieldMirror.simpleName).reflectee as List;
}

void testObjectFieldValues<T>({
  required T object,
  required Map<dynamic, dynamic> Function(T object) fieldsAndExpectedValues,
}) {
  for (var fieldKvp in fieldsAndExpectedValues(object).entries) {
    expect(fieldKvp.key, fieldKvp.value);
  }
}

/// Performs standard model tests, including:
/// - Field count verification
/// - Serialization
///   - From JSON
///   - API-Model -> Model -> API Model
void performStandardModelTests<TApiModel, TModel>({
  bool requiresAppAndProjectInScope = false,
  required int expectedPublicFieldCount,
  required Map<dynamic, dynamic> Function(TApiModel apiModel) fieldsAndExpectedValues,
  required String apiModelJson,
}) {
  final apiMirror = reflectType(TApiModel) as ClassMirror;

  test('Expected class field count test', () {
    expect(getClassPublicFieldCount(TApiModel), expectedPublicFieldCount);
  });

  test('Serialization test', () async {
    final TApiModel apiModelOrig;

    {
      final fromJsonSymbol = Symbol('${getSymbolName(apiMirror.simpleName)}.fromJson');
      final MethodMirror fromJsonCtorMirror;
      fromJsonCtorMirror = apiMirror.declarations[fromJsonSymbol] as MethodMirror;

      dynamic deserializedJson;
      // Some "fromJson" methods take in a Map, while others take in a List<Map>
      if (getSymbolName(fromJsonCtorMirror.parameters[0].type.simpleName) == 'List') {
        deserializedJson = jsonDecodeListOfMap(apiModelJson);
      } else {
        deserializedJson = jsonDecode(apiModelJson);
      }

      apiModelOrig = apiMirror.newInstance(
        fromJsonCtorMirror.constructorName,
        [deserializedJson],
      ).reflectee as TApiModel;

      testObjectFieldValues(
        object: apiModelOrig,
        fieldsAndExpectedValues: fieldsAndExpectedValues,
      );
    }

    void modelCycleHandler() {
      final modelMirror = reflectType(TModel) as ClassMirror;
      final fromApiModelSymbol = Symbol('${getSymbolName(modelMirror.simpleName)}.fromApiModel');
      final fromApiModelMirror = modelMirror.declarations[fromApiModelSymbol] as MethodMirror;

      // Convert it to a model class then back again
      final asModel = modelMirror
          .newInstance(fromApiModelMirror.constructorName, [apiModelOrig]).reflectee as TModel;
      final apiModelCycled = (asModel as dynamic).toApiModel() as TApiModel;

      testObjectFieldValues(
        object: apiModelCycled,
        fieldsAndExpectedValues: fieldsAndExpectedValues,
      );
    }

    if (requiresAppAndProjectInScope) {
      await defineN1AppAndProjectInScope(getStandardN1Project(), modelCycleHandler);
    } else {
      await defineN1AppInScope(getStandardN1App(), modelCycleHandler);
    }
  });
}
