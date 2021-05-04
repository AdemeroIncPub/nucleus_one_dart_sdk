import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import '../api_model/document_comments.dart';

void main() {
  group('DocumentCommentCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentCommentCollection apiModel) {
        expect(apiModel.documentEvents!.length, 1);
        expect(apiModel.cursor, 'A');
        expect(apiModel.reverseCursor, 'B');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.DocumentCommentCollection.fromJson(jsonDecode(documentCommentsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentCommentCollectionQueryResult.fromApiModelDocumentCommentCollection(apiModelOrig).results.toApiModel();
      performTests(apiModelCycled);
    });
  });
}
