import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
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
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.TaskCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult<api_mod.TaskCollection> apiModel) {
        expect(apiModel.results!.tasks!.length, 1);
      }

      final apiModelOrig =
          api_mod.QueryResult<api_mod.TaskCollection>.fromJson(jsonDecode(taskCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult<api_mod.TaskCollection> apiModelCycled =
            TaskCollectionQueryResult.fromApiModelTaskCollection(apiModelOrig)
                .toApiModel<api_mod.TaskCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
