import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_events.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/document_events.dart';

void main() {
  group('DocumentEvents tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentEvents apiModel) {
        expect(apiModel.documentEvents!.length, 1);
        expect(apiModel.cursor, 'A');
        expect(apiModel.reverseCursor, 'B');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.DocumentEvents.fromJson(jsonDecode(documentEventsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentEvents.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
