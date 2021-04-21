import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_comments.dart' as mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_comments.dart' as api_mod;
import 'package:test/test.dart';

import 'document_event.dart';

const documentCommentsJson = r'{"DocumentEvents":[' +
    documentEventJson +
    r'],"Cursor":"A","ReverseCursor":"B","PageSize":24}';

void main() {
  group('DocumentComments tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentComments apiModel) {
        expect(apiModel.documentEvents!.length, 1);
        expect(apiModel.cursor, 'A');
        expect(apiModel.reverseCursor, 'B');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.DocumentComments.fromJson(jsonDecode(documentCommentsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = mod.DocumentComments.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
