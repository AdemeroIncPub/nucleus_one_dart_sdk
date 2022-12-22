import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_event.dart';

void main() {
  group('DocumentEventCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentEventCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult2<api_mod.DocumentEventCollection> apiModel) {
        expect(apiModel.results!.documentEvents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.reverseCursor, 'QueryResultB');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.QueryResult2<api_mod.DocumentEventCollection>.fromJson(
          jsonDecode(documentEventsJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            DocumentEventCollectionQueryResult.fromApiModelDocumentEventCollection(apiModelOrig)
                .toApiModel<api_mod.DocumentEventCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('DocumentEvent tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentEvent), 8);
    });

    test('Serialization test', () async {
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

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentEvent.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
