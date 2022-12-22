import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/query_result.dart';

void main() {
  group('QueryResult & QueryResult2 Tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.QueryResult<dynamic>), 3);
      expect(getClassPublicFieldCount(api_mod.QueryResult2<dynamic>), 4);
    });

    void performTests<T>(api_mod.QueryResult<dynamic> apiModel) {
      expect(apiModel.results.length, 0);
      expect(apiModel.cursor, 'QueryResultA');
      expect(apiModel.pageSize, 24);

      if (apiModel is api_mod.QueryResult2<dynamic>) {
        expect(apiModel.reverseCursor, 'QueryResultB');
      }
    }

    group('QueryResult class tests', () {
      test('Serialization test', () async {
        expect(
            () => api_mod.QueryResult.fromJson(jsonDecode(queryResult2Json)),
            throwsA(allOf(
              isUnimplementedError,
              predicate((UnimplementedError e) => e.message
                  .toString()
                  .contains('factory constructor must be explicitly registered')),
            )));

        final apiModelOrig = api_mod.QueryResult.fromJson(jsonDecode(queryResult2Json), (x) => []);
        performTests(apiModelOrig);

        await DefineN1AppInScope(getStandardN1App(), () {
          // Convert it to a model class then back again
          final apiModelCycled = QueryResult_fromApiModel(apiModelOrig).toApiModel();
          performTests(apiModelCycled);
        });
      });
    });

    group('QueryResult2 class tests', () {
      test('Serialization test', () async {
        expect(
            () => api_mod.QueryResult2.fromJson(jsonDecode(queryResult2Json)),
            throwsA(allOf(
              isUnimplementedError,
              predicate((UnimplementedError e) => e.message
                  .toString()
                  .contains('factory constructor must be explicitly registered')),
            )));

        final apiModelOrig = api_mod.QueryResult2.fromJson(jsonDecode(queryResult2Json), (x) => []);
        performTests(apiModelOrig);

        await DefineN1AppInScope(getStandardN1App(), () {
          // Convert it to a model class then back again
          final apiModelCycled = QueryResult2_fromApiModel(apiModelOrig).toApiModel();
          performTests(apiModelCycled);
        });
      });
    });
  });
}

QueryResult QueryResult_fromApiModel(
  api_mod.QueryResult apiModel, {
  NucleusOneApp? app,
}) {
  return QueryResult(
    results: DummyCollection(items: []),
    cursor: apiModel.cursor!,
    pageSize: apiModel.pageSize!,
  );
}

QueryResult2 QueryResult2_fromApiModel(
  api_mod.QueryResult2 apiModel, {
  NucleusOneApp? app,
}) {
  return QueryResult2(
    results: DummyCollection(items: []),
    cursor: apiModel.cursor!,
    reverseCursor: apiModel.reverseCursor!,
    pageSize: apiModel.pageSize!,
  );
}

class DummyCollection extends EntityCollection<DocumentForClient, List> {
  DummyCollection({
    NucleusOneApp? app,
    List<DocumentForClient>? items,
  }) : super(app: app, items: items);

  @override
  List toApiModel() => [];
}
