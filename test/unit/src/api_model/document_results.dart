import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/document_results.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import 'document.dart';

const documentResultsJson = r'{"Documents":[' + documentJson + r'],"Cursor":"A","PageSize":24}';

void main() {
  group('DocumentResultCollection class tests', () {
    test('Serialization test', () {
      final apiModel = api_mod.QueryResult<api_mod.DocumentResultCollection>.fromJson(
          jsonDecode(documentResultsJson));

      expect(apiModel.results!.documents!.length, 1);
      expect(apiModel.cursor, 'A');
      expect(apiModel.pageSize, 24);
    });
  });
}
