import 'dart:convert';

import 'package:nucleus_one_dart_sdk/src/api_model/document_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_comments.dart';

void main() {
  group('DocumentCommentCollection tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentCommentCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult2<api_mod.DocumentCommentCollection> apiModel) {
        expect(apiModel.results!.documentEvents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.reverseCursor, 'QueryResultB');
        expect(apiModel.pageSize, 24);
      }

      var apiModelOrig = api_mod.QueryResult2<api_mod.DocumentCommentCollection>.fromJson(
          jsonDecode(documentCommentsJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentCommentCollectionQueryResult.fromApiModelDocumentCommentCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentCommentCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
