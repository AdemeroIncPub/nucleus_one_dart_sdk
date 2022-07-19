import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/task_event.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/task_event.dart';

void main() {
  group('TaskEventCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult2<api_mod.TaskEventCollection> apiModel) {
        expect(apiModel.results!.taskEvents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.reverseCursor, 'QueryResultB');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig =
          api_mod.QueryResult2<api_mod.TaskEventCollection>.fromJson(jsonDecode(taskEventsJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            TaskEventCollectionQueryResult.fromApiModelTaskEventCollection(apiModelOrig)
                .toApiModel<api_mod.TaskEventCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('TaskEvent tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () async {
      void performTests(api_mod.TaskEvent apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.taskID, 'B');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.createdByUserEmail, 'E');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.type, 'Comment');
        expect(apiModel.taskRevision, 0);
        expect(apiModel.detailJson, 'F');
      }

      final apiModelOrig = api_mod.TaskEvent.fromJson(jsonDecode(taskEventJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = TaskEvent.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
