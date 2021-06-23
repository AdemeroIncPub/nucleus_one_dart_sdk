import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/work_task_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/model/work_task_event.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/work_task_event.dart';

void main() {
  group('WorkTaskEventCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult2<api_mod.WorkTaskEventCollection> apiModel) {
        expect(apiModel.results!.workTaskEvents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.reverseCursor, 'QueryResultB');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.QueryResult2<api_mod.WorkTaskEventCollection>.fromJson(
          jsonDecode(workTaskEventsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled =
          WorkTaskEventCollectionQueryResult.fromApiModelWorkTaskEventCollection(apiModelOrig)
              .toApiModel<api_mod.WorkTaskEventCollection>();
      performTests(apiModelCycled);
    });
  });

  group('WorkTaskEvent tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.WorkTaskEvent apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.workTaskID, 'B');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.createdByUserEmail, 'E');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.type, 'Comment');
        expect(apiModel.workTaskRevision, 0);
        expect(apiModel.detailJson, 'F');
      }

      final apiModelOrig = api_mod.WorkTaskEvent.fromJson(jsonDecode(workTaskEventJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = WorkTaskEvent.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
