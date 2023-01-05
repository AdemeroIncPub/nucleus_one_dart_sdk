import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:nucleus_one_dart_sdk/src/model/task.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/task.dart';

void main() {
  group('Task tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.Task), 41);
    });

    test('Serialization test', () async {
      void performTests(api_mod.Task apiModel) {
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
        expect(apiModel.dueOn, '0001-01-01T00:00:00Z');
        expect(apiModel.dueOnModifiedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.primaryDocument, isA<api_mod.Document>());
        expect(apiModel.otherDocuments, isA<List<api_mod.Document>>());
        expect(apiModel.parentTaskID, 'T');
        expect(apiModel.processID, 'U');
        expect(apiModel.processName, 'V');
        expect(apiModel.processNameLower, 'W');
        expect(apiModel.processElementID, 'X');
        expect(apiModel.processElementName, 'Y');
        expect(apiModel.processElementNameLower, 'Z');
        expect(apiModel.reminder7Day, '0001-01-01T00:00:00Z');
        expect(apiModel.reminder3Day, '0001-01-01T00:00:00Z');
        expect(apiModel.reminder1Day, '0001-01-01T00:00:00Z');
      }

      final apiModelOrig = api_mod.Task.fromJson(jsonDecode(taskJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = Task.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('TaskCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

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
