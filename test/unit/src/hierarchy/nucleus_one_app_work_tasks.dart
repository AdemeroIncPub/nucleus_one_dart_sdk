import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/work_task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_work_tasks.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/work_task.dart';
import 'package:nucleus_one_dart_sdk/src/model/work_task_comment.dart';
import 'package:test/test.dart';
import '../../../src/assertions.dart';
import '../api_model/work_task.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';
import '../api_model/work_task_comment.dart';

Document document = Document.fromApiModel(api_mod.Document()
  ..id = 'A'
  ..createdOn = '0001-01-01T00:00:00Z'
  ..createdByUserID = 'B'
  ..createdByUserEmail = 'C'
  ..createdByUserName = 'D'
  ..name = 'E'
  ..nameLower = 'F'
  ..origin = 'G'
  ..isActive = false
  ..isClassified = false
  ..isMarkedForPurge = false
  ..isSigned = false
  ..signatureSessionIsActive = false
  ..hasSinglePageImages = false
  ..signaturesCompletedOn = '0001-01-01T00:00:00Z'
  ..purgeMarkedOn = '0001-01-01T00:00:00Z'
  ..failedBuildAttempts = false
  ..lastError = 'H'
  ..pageCount = 0
  ..fileSize = 1
  ..bucketName = 'I'
  ..sourceObjectName = 'J'
  ..thumbnailObjectName = 'K'
  ..classificationID = 'L'
  ..classificationName = 'M'
  ..classificationNameLower = 'N'
  ..previewMetadata = [
    {
      '0': '00',
      '1': '11',
      '2': '22',
    }
  ]);
final wt = api_mod.WorkTask()
  ..id = 'A'
  ..createdOn = '0001-01-01T00:00:00Z'
  ..modifiedOn = '0001-01-01T00:00:00Z'
  ..createdByUserID = 'B'
  ..createdByUserEmail = 'C'
  ..createdByUserName = 'D'
  ..completedOn = '0001-01-01T00:00:00Z'
  ..completedByUserID = 'E'
  ..completedByUserEmail = 'F'
  ..completedByUserName = 'G'
  ..modifiedByUserID = 'H'
  ..modifiedByUserEmail = 'I'
  ..modifiedByUserName = 'J'
  ..revision = 0
  ..result = 'K'
  ..name = 'L'
  ..nameLower = 'M'
  ..description = 'N'
  ..descriptionHtml = 'O'
  ..descriptionRichTextJson = 'P'
  ..roleID = 'Q'
  ..roleName = 'R'
  ..roleNameLower = 'S'
  ..dueOn = '0001-01-01T00:00:00Z'
  ..dueOnModifiedOn = '0001-01-01T00:00:00Z'
  ..primaryDocument = document.toApiModel()
  ..otherDocuments = [document.toApiModel()]
  ..parentWorkTaskID = 'T'
  ..processID = 'U'
  ..processName = 'V'
  ..processNameLower = 'W'
  ..processElementID = 'X'
  ..processElementName = 'Y'
  ..processElementNameLower = 'Z'
  ..reminder_7_Day = '0001-01-01T00:00:00Z'
  ..reminder_3_Day = '0001-01-01T00:00:00Z'
  ..reminder_1_Day = '0001-01-01T00:00:00Z';
final wts = api_mod.WorkTaskCollection()..workTasks = [wt];

void main() {
  group('NucleusOneAppWorkTasks class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getWorkTasks method tests', () async {
      final expectedUrlPath = http.apiPaths.workTasks;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<WorkTaskCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App).getWorkTasks(),
        responseBody: workTaskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getWorkTasksByWorkTaskId method tests', () async {
      final expectedUrlPath = http.apiPaths.workTasksFormat.replaceFirst('<workTaskId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<WorkTaskCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App).getWorkTasksByWorkTaskId('123'),
        responseBody: workTaskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'workTaskId=123',
        ],
      );
    });

    test('post method tests', () async {
      final n1App = getStandardN1App();
      // Test assertion error when no tasks are provided
      await testAssertionErrorAsync(
          () => performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App)
                    .createWorkTasks(WorkTaskCollection.fromApiModel(api_mod.WorkTaskCollection())),
                responseBody: '',
                expectedRequestUrlPath: '',
                expectedRequestQueryParams: [],
              ),
          'tasks');

      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App)
            .createWorkTasks(WorkTaskCollection.fromApiModel(wts)),
        responseBody: '[' + workTaskJson + ']',
        expectedRequestUrlPath: http.apiPaths.workTasks,
        expectedRequestQueryParams: [],
      );
    });

    test('put method tests', () async {
      final expectedUrlPath = http.apiPaths.workTasksFormat.replaceFirst('<workTaskId>', 'A');
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () =>
            NucleusOneAppWorkTasks(app: n1App).updateWorkTask(WorkTask.fromApiModel(wt)),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'workTaskId=A',
        ],
      );
    });

    test('getWorkTaskComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.workTasksCommentsFormat.replaceFirst('<workTaskId>', '123');
      final n1App = getStandardN1App();
      // Test with default parameters
      await performHttpTest<QueryResult2<WorkTaskCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppWorkTasks(app: n1App).getWorkTaskComments(workTaskId: '123'),
        responseBody: workTaskCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<WorkTaskCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App)
            .getWorkTaskComments(workTaskId: '123', sortDescending: false, cursor: 'QueryResultA'),
        responseBody: workTaskCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=QueryResultA'],
      );
    });

    test('createWorkTaskComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.workTasksCommentsFormat.replaceFirst('<workTaskId>', '123');
      final n1App = getStandardN1App();
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App).createWorkTaskComments(
          workTaskId: '123',
          comments: [],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":[]}',
      );

      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App).createWorkTaskComments(
          workTaskId: '123',
          comments: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":["A","B"]}',
      );
    });
  });
}
