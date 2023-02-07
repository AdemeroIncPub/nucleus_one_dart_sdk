import 'package:nucleus_one_dart_sdk/src/api_model/task_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/query_result.dart';
import 'package:nucleus_one_dart_sdk/src/model/task_comment.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/task_comment.dart';

void main() {
  group('TaskCommentCollection class tests', () {
    performStandardQueryResultModelTests<
        TaskCommentCollection,
        api_mod.TaskCommentCollection,
        QueryResult2<TaskCommentCollection, api_mod.TaskCommentCollection>,
        api_mod.QueryResult2<api_mod.TaskCommentCollection>>(
      apiModelJson: taskCommentCollectionJson,
    );
  });
}
