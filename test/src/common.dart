import 'dart:convert';
import 'dart:mirrors';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_task.dart';
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
Future<void> performStandardModelTests<TApiModel, TModel>({
  required int expectedPublicFieldCount,
  required Map<dynamic, dynamic> Function(TApiModel apiModel) fieldsAndExpectedValues,
  required String apiModelJson,
}) async {
  test('Expected class field count test', () {
    expect(getClassPublicFieldCount(TApiModel), expectedPublicFieldCount);
  });

  test('Serialization test', () async {
    void performTests(TApiModel apiModel) {
      for (var fieldKvp in fieldsAndExpectedValues(apiModel).entries) {
        expect(fieldKvp.key, fieldKvp.value);
      }
    }

    final TApiModel apiModelOrig;

    {
      final apiMirror = reflectType(TApiModel) as ClassMirror;
      final fromJsonSymbol = Symbol('${getSymbolName(apiMirror.simpleName)}.fromJson');
      final fromJsonCtorMirror = apiMirror.declarations[fromJsonSymbol] as MethodMirror;
      apiModelOrig = apiMirror.newInstance(
          fromJsonCtorMirror.constructorName, [jsonDecode(apiModelJson)]).reflectee as TApiModel;

      performTests(apiModelOrig);
    }

    await defineN1AppInScope(getStandardN1App(), () {
      final modelMirror = reflectType(TModel) as ClassMirror;
      final fromApiModelSymbol = Symbol('${getSymbolName(modelMirror.simpleName)}.fromApiModel');
      final fromApiModelMirror = modelMirror.declarations[fromApiModelSymbol] as MethodMirror;

      // Convert it to a model class then back again
      final asModel = modelMirror
          .newInstance(fromApiModelMirror.constructorName, [apiModelOrig]).reflectee as TModel;
      final apiModelCycled = (asModel as dynamic).toApiModel() as TApiModel;
      performTests(apiModelCycled);
    });
  });
}
