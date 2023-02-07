import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/query_result.dart';

void main() {
  group('QueryResult & QueryResult2 class tests', () {
    void performTests<
        TModel extends EntityCollection<NucleusOneAppDependent, dynamic>,
        TApiModel,
        TColModel extends QueryResult<TModel, TApiModel>,
        TColApiModel extends api_mod.QueryResult<TApiModel>>() {
      final isQueryResult2 = (TColApiModel == api_mod.QueryResult2<TApiModel>);
      performStandardModelTests<TColModel, TColApiModel>(
        apiModelJson: queryResult2Json,
        expectedPublicFieldCount: isQueryResult2 ? 4 : 3,
        fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
          apiModel.results: isNotNull,
          apiModel.cursor: 'QueryResultA',
          apiModel.pageSize: 24,
          if (isQueryResult2)
            (apiModel as api_mod.QueryResult2<TApiModel>).reverseCursor: 'QueryResultB',
        },
      );
    }

    group('QueryResult class tests', () {
      performTests<
          OrganizationForClientCollection,
          api_mod.OrganizationForClientCollection,
          QueryResult<OrganizationForClientCollection, api_mod.OrganizationForClientCollection>,
          api_mod.QueryResult<api_mod.OrganizationForClientCollection>>();

      test('Serialization test', () async {
        expect(
            () => api_mod.QueryResult.fromJson(jsonDecode(queryResult2Json)),
            throwsA(allOf(
              isUnimplementedError,
              predicate((UnimplementedError e) => e.message
                  .toString()
                  .contains('factory constructor must be explicitly registered')),
            )));

        expect(
            () => QueryResult.fromApiModel(api_mod.QueryResult()),
            throwsA(allOf(
              isUnimplementedError,
              predicate((UnimplementedError e) => e.message
                  .toString()
                  .contains('factory constructor must be explicitly registered')),
            )));
      });
    });

    group('QueryResult2 class tests', () {
      performTests<
          DocumentCommentCollection,
          api_mod.DocumentCommentCollection,
          QueryResult2<DocumentCommentCollection, api_mod.DocumentCommentCollection>,
          api_mod.QueryResult2<api_mod.DocumentCommentCollection>>();

      test('Serialization test', () async {
        expect(
            () => api_mod.QueryResult2.fromJson(jsonDecode(queryResult2Json)),
            throwsA(allOf(
              isUnimplementedError,
              predicate((UnimplementedError e) => e.message
                  .toString()
                  .contains('factory constructor must be explicitly registered')),
            )));
      });
    });
  });
}
