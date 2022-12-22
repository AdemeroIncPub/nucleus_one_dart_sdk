import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/task_comment.dart';

void main() {
  group('TaskCommentCollection tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.TaskCommentCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.QueryResult2<api_mod.TaskCommentCollection> apiModel) {
        expect(apiModel.results!.taskEvents!.length, 1);
        expect(apiModel.cursor, 'QueryResultA');
        expect(apiModel.reverseCursor, 'QueryResultB');
        expect(apiModel.pageSize, 24);
      }

      var apiModelOrig = api_mod.QueryResult2<api_mod.TaskCommentCollection>.fromJson(
          jsonDecode(taskCommentsJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.QueryResult2<api_mod.TaskCommentCollection> apiModelCycled =
            TaskCommentCollectionQueryResult.fromApiModelTaskCommentCollection(apiModelOrig)
                .toApiModel<api_mod.TaskCommentCollection>();
        performTests(apiModelCycled);
      });
    });
  });
}
