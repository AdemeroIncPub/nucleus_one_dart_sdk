import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/task.dart';

void main() {
  group('Task class tests', () {
    performStandardModelTests<api_mod.Task, Task>(
      apiModelJson: taskJson,
      expectedPublicFieldCount: 41,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '0001-01-01T00:00:00Z',
        apiModel.modifiedOn: '0001-01-01T00:00:00Z',
        apiModel.createdByUserID: 'B',
        apiModel.createdByUserEmail: 'C',
        apiModel.createdByUserName: 'D',
        apiModel.completedOn: '0001-01-01T00:00:00Z',
        apiModel.completedByUserID: 'E',
        apiModel.completedByUserEmail: 'F',
        apiModel.completedByUserName: 'G',
        apiModel.modifiedByUserID: 'H',
        apiModel.modifiedByUserEmail: 'I',
        apiModel.modifiedByUserName: 'J',
        apiModel.revision: 0,
        apiModel.result: 'K',
        apiModel.name: 'L',
        apiModel.nameLower: 'M',
        apiModel.description: 'N',
        apiModel.descriptionHtml: 'O',
        apiModel.descriptionRichTextJson: 'P',
        apiModel.dueOn: '0001-01-01T00:00:00Z',
        apiModel.dueOnModifiedOn: '0001-01-01T00:00:00Z',
        apiModel.primaryDocument: isA<api_mod.Document>(),
        apiModel.otherDocuments: isA<List<api_mod.Document>>(),
        apiModel.parentTaskID: 'T',
        apiModel.processID: 'U',
        apiModel.processName: 'V',
        apiModel.processNameLower: 'W',
        apiModel.processElementID: 'X',
        apiModel.processElementName: 'Y',
        apiModel.processElementNameLower: 'Z',
        apiModel.reminder7Day: '0001-01-01T00:00:00Z',
        apiModel.reminder3Day: '0001-01-01T00:00:00Z',
        apiModel.reminder1Day: '0001-01-01T00:00:00Z',
      },
    );
  });

  group('TaskCollection class tests', () {
    performStandardQueryResultModelTests<
        TaskCollection,
        api_mod.TaskCollection,
        QueryResult<TaskCollection, api_mod.TaskCollection>,
        api_mod.QueryResult<api_mod.TaskCollection>>(
      apiModelJson: taskCollectionJson,
    );
  });
}
