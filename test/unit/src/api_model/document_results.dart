import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/document_results.dart' as api_mod;
import 'package:test/test.dart';

import 'document.dart';

const documentResultsJson = r'{"Documents":[' + documentJson + r'],"Cursor":"A","PageSize":24}';

void main() {
  group('DocumentResults class tests', () {
    test('Serialization test', () {
      final apiModel = api_mod.DocumentResults.fromJson(jsonDecode(documentResultsJson));

      expect(apiModel.documents!.length, 1);
      expect(apiModel.cursor, 'A');
      expect(apiModel.pageSize, 24);
    });
  });
}
