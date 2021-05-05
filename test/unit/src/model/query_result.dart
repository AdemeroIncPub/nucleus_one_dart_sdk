import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../api_model/query_result.dart';

void main() {
  group('QueryResult & QueryResult2 Tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    void performTests<T>(api_mod.QueryResult<dynamic> apiModel) {
      expect(apiModel.results.length, 0);
      expect(apiModel.cursor, 'A');
      expect(apiModel.pageSize, 24);

      if (apiModel is api_mod.QueryResult2<dynamic>) {
        expect(apiModel.reverseCursor, 'B');
      }
    }

    group('QueryResult class tests', () {
      test('Serialization test', () {
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

        // Convert it to a model class then back again
        final apiModelCycled = QueryResult_fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    group('QueryResult2 class tests', () {
      test('Serialization test', () {
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

        // Convert it to a model class then back again
        final apiModelCycled = QueryResult2_fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}

QueryResult QueryResult_fromApiModel(api_mod.QueryResult apiModel) {
  return QueryResult(
    results: DummyCollection(items: []),
    cursor: apiModel.cursor!,
    pageSize: apiModel.pageSize!,
  );
}

QueryResult2 QueryResult2_fromApiModel(api_mod.QueryResult2 apiModel) {
  return QueryResult2(
    results: DummyCollection(items: []),
    cursor: apiModel.cursor!,
    reverseCursor: apiModel.reverseCursor!,
    pageSize: apiModel.pageSize!,
  );
}

class DummyCollection extends EntityCollection<Document, List> {
  DummyCollection({
    NucleusOneAppInternal? app,
    List<Document>? items,
  }) : super(app: app, items: items);

  @override
  List toApiModel() => [];
}
