import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/work_task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/work_task.dart';
import 'package:test/test.dart';

import '../api_model/work_task.dart';

void main() {
  group('WorkTask tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.WorkTask apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.modifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.createdByUserID, 'B');
        expect(apiModel.createdByUserEmail, 'C');
        expect(apiModel.createdByUserName, 'D');
        expect(apiModel.completedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.completedByUserID, 'E');
        expect(apiModel.completedByUserEmail, 'F');
        expect(apiModel.completedByUserName, 'G');
        expect(apiModel.modifiedByUserID, 'H');
        expect(apiModel.modifiedByUserEmail, 'I');
        expect(apiModel.modifiedByUserName, 'J');
        expect(apiModel.revision, 0);
        expect(apiModel.result, 'K');
        expect(apiModel.name, 'L');
        expect(apiModel.nameLower, 'M');
        expect(apiModel.description, 'N');
        expect(apiModel.descriptionHtml, 'O');
        expect(apiModel.descriptionRichTextJson, 'P');
        expect(apiModel.roleID, 'Q');
        expect(apiModel.roleName, 'R');
        expect(apiModel.roleNameLower, 'S');
        expect(apiModel.dueOn, '0001-01-01T00:00:00Z');
        expect(apiModel.dueOnModifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.primaryDocument, isA<api_mod.Document>());
        expect(apiModel.otherDocuments, isA<List<api_mod.Document>>());
        expect(apiModel.parentWorkTaskID, 'T');
        expect(apiModel.processID, 'U');
        expect(apiModel.processName, 'V');
        expect(apiModel.processNameLower, 'W');
        expect(apiModel.processElementID, 'X');
        expect(apiModel.processElementName, 'Y');
        expect(apiModel.processElementNameLower, 'Z');
        expect(apiModel.reminder_7_Day, '0001-01-01T00:00:00Z');
        expect(apiModel.reminder_3_Day, '0001-01-01T00:00:00Z');
        expect(apiModel.reminder_1_Day, '0001-01-01T00:00:00Z');
      }

      final apiModelOrig = api_mod.WorkTask.fromJson(jsonDecode(workTaskJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = WorkTask.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('WorkTaskCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.WorkTaskCollection> apiModel) {
        expect(apiModel.results!.workTasks!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.WorkTaskCollection>.fromJson(
          jsonDecode(workTaskCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.WorkTaskCollection> apiModelCycled =
          WorkTaskCollectionQueryResult.fromApiModelWorkTaskCollection(apiModelOrig)
              .toApiModel<api_mod.WorkTaskCollection>();
      performTests(apiModelCycled);
    });
  });
}
