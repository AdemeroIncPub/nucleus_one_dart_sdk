import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/task_event.dart';

void main() {
  group('TaskEventCollection class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.TaskEventCollection), 1);
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

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled =
            TaskEventCollectionQueryResult.fromApiModelTaskEventCollection(apiModelOrig)
                .toApiModel<api_mod.TaskEventCollection>();
        performTests(apiModelCycled);
      });
    });
  });

  group('TaskEvent class tests', () {
    performStandardModelTests<api_mod.TaskEvent, TaskEvent>(
      apiModelJson: taskEventJson,
      expectedPublicFieldCount: 10,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.taskID: 'B',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.createdByUserID: 'C',
        apiModel.createdByUserName: 'D',
        apiModel.createdByUserEmail: 'E',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.type: 'Comment',
        apiModel.taskRevision: 0,
        apiModel.detailJson: 'F',
      },
    );
  });
}
