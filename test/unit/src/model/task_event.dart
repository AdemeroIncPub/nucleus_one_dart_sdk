import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task_event.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/task_event.dart';

void main() {
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

  group('TaskEventCollection class tests', () {
    performStandardQueryResultModelTests<
        TaskEventCollection,
        api_mod.TaskEventCollection,
        QueryResult2<TaskEventCollection, api_mod.TaskEventCollection>,
        api_mod.QueryResult2<api_mod.TaskEventCollection>>(
      apiModelJson: taskEventCollectionJson,
    );
  });
}
