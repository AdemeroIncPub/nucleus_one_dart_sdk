import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_event.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/document_event.dart';

void main() {
  group('DocumentEvent tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentEvent apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.documentID, 'B');
        expect(apiModel.createdOn, '2020-09-10T18:55:56.901688Z');
        expect(apiModel.createdByUserID, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.createdByUserEmail, 'E');
        expect(apiModel.type, 'Comment');
        expect(apiModel.detailJson, 'F');
      }

      final apiModelOrig = api_mod.DocumentEvent.fromJson(jsonDecode(documentEventJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentEvent.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
