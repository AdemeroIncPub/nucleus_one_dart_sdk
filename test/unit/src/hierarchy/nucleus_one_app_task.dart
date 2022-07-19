import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/task.dart';
import 'package:nucleus_one_dart_sdk/src/model/task_comment.dart';
import 'package:test/test.dart';
import '../../../src/assertions.dart';
import '../api_model/task.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';
import '../api_model/task_comment.dart';

void main() {
  group('NucleusOneAppTasks class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getTasks method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsTasksFormat
          .replaceOrganizationAndProjectPlaceholders(project);

      // Test with default parameters
      await performHttpTest<QueryResult<TaskCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.tasks().get(),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getTasksByTaskId method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceTaskIdPlaceholder('123');

      // Test with default parameters
      await performHttpTest<Task>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.task('123').get(),
        responseBody: taskJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'taskId=123',
        ],
      );
    });

    test('post method tests', () async {
      var project = getStandardN1Project();
      // Test assertion error when no tasks are provided
      await testAssertionErrorAsync(
          () => performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => project.tasks().create(
                    TaskCollection.fromApiModel(api_mod.TaskCollection(), app: project.app)),
                responseBody: '',
                expectedRequestUrlPath: '',
                expectedRequestQueryParams: [],
              ),
          'tasks');

      project = getStandardN1Project();
      final ts = _getTaskCollection(project);

      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            project.tasks().create(TaskCollection.fromApiModel(ts, app: project.app)),
        responseBody: '[' + taskJson + ']',
        expectedRequestUrlPath: http.apiPaths.organizationsProjectsTasksFormat
            .replaceOrganizationAndProjectPlaceholders(project),
        expectedRequestQueryParams: [],
      );
    });

    test('put method tests', () async {
      final project = getStandardN1Project();
      final ts = _getTaskCollection(project);
      final expectedUrlPath = http.apiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceTaskIdPlaceholder('A');

      await performHttpTest<void>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () =>
            project.tasks().update(Task.fromApiModel(ts.tasks![0], app: project.app)),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'taskId=A',
        ],
      );
    });

    test('getTaskComments method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceTaskIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest<QueryResult2<TaskCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => project.task('123').getComments(),
        responseBody: taskCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      project = getStandardN1Project();
      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<TaskCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            project.task('123').getComments(sortDescending: false, cursor: 'QueryResultA'),
        responseBody: taskCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=QueryResultA'],
      );
    });

    test('createTaskComments method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.apiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrganizationAndProjectPlaceholders(project)
          .replaceTaskIdPlaceholder('123');
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => project.task('123').createComments(
          comments: [],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":[]}',
      );

      project = getStandardN1Project();
      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => project.task('123').createComments(
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

api_mod.TaskCollection _getTaskCollection(NucleusOneAppProject project) {
  Document document = Document.fromApiModel(
    api_mod.Document()
      ..approvalCreatedOn = '0001-01-01T00:00:00Z'
      ..approvalID = 'A'
      ..assignmentUserEmails = ['B']
      ..createdByUserEmail = 'C'
      ..createdByUserName = 'D'
      ..createdOn = '0001-01-01T00:00:00Z'
      ..documentFolderID = 'E'
      ..documentFolderPath = 'F'
      ..documentID = 'G'
      ..documentSubscriptionCreatedOn = '0001-01-01T00:00:00Z'
      ..documentSubscriptionID = 'H'
      ..fileSize = 1
      ..groupID = 'I'
      ..hasSinglePageImages = false
      ..id = 'J'
      ..isMarkedForPurge = false
      ..isSigned = false
      ..modifiedByUserEmail = 'K'
      ..modifiedByUserName = 'L'
      ..modifiedOn = '0001-01-01T00:00:00Z'
      ..name = 'M'
      ..organizationID = 'N'
      ..origin = 'O'
      ..pageCount = 1
      ..paperMarginBottom = 2
      ..paperMarginLeft = 3
      ..paperMarginRight = 4
      ..paperMarginTop = 5
      ..paperOrientation = 'P'
      ..paperSize = 'Q'
      ..previewMetadata = [
        {
          '0': '00',
          '1': '11',
          '2': '22',
        }
      ]
      ..processElementName = 'R'
      ..processName = 'S'
      ..projectAccessType = 'T'
      ..projectID = 'U'
      ..projectName = 'V'
      ..purgeDate = '0001-01-01T00:00:00Z'
      ..revision = 6
      ..signaturesCompletedOn = '0001-01-01T00:00:00Z'
      ..signatureSessionIsActive = false
      ..thumbnailUrl = 'W',
    app: project.app,
  );
  final t = api_mod.Task()
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
    ..dueOn = '0001-01-01T00:00:00Z'
    ..dueOnModifiedOn = '0001-01-01T00:00:00Z'
    ..primaryDocument = document.toApiModel()
    ..otherDocuments = [document.toApiModel()]
    ..parentTaskID = 'Q'
    ..processID = 'R'
    ..processName = 'S'
    ..processNameLower = 'T'
    ..processElementID = 'U'
    ..processElementName = 'V'
    ..processElementNameLower = 'W'
    ..reminder_7_Day = '0001-01-01T00:00:00Z'
    ..reminder_3_Day = '0001-01-01T00:00:00Z'
    ..reminder_1_Day = '0001-01-01T00:00:00Z'
    ..organizationID = 'X'
    ..projectID = 'Y'
    ..projectName = 'Z'
    ..projectAccessType = 'AA'
    ..assignmentUserEmail = 'AB'
    ..assignmentUserName = 'AC'
    ..assignmentUserNameLower = 'AD';
  final ts = api_mod.TaskCollection()..tasks = [t];
  return ts;
}
