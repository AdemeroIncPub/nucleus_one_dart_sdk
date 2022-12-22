import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/document_results.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/mirrors.dart';
import 'document_for_client.dart';

const documentResultsJson =
    r'{"Documents":[' + documentForClientJson + r'],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  group('DocumentResultCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentResultCollection), 1);
    });

    test('Serialization test', () {
      final apiModel = api_mod.QueryResult<api_mod.DocumentResultCollection>.fromJson(
          jsonDecode(documentResultsJson));

      expect(apiModel.results!.documents!.length, 1);
      expect(apiModel.cursor, 'QueryResultA');
      expect(apiModel.pageSize, 24);
    });
  });
}
