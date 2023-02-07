import 'package:nucleus_one_dart_sdk/src/api_model/document_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document_comment.dart';
import 'package:nucleus_one_dart_sdk/src/model/query_result.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_comments.dart';

void main() {
  group('DocumentCommentCollection class tests', () {
    performStandardQueryResultModelTests<
        DocumentCommentCollection,
        api_mod.DocumentCommentCollection,
        QueryResult2<DocumentCommentCollection, api_mod.DocumentCommentCollection>,
        api_mod.QueryResult2<api_mod.DocumentCommentCollection>>(
      apiModelJson: documentCommentCollectionJson,
    );
  });
}
