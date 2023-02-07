import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/task_comment.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
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
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    const expectedJson =
        r'{"ID":"A","OrganizationID":"X","ProjectID":"Y","ProjectName":"Z","ProjectAccessType":"AA","CreatedOn":"0001-01-01T00:00:00Z","ModifiedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"B","CreatedByUserEmail":"C","CreatedByUserName":"D","CompletedOn":"0001-01-01T00:00:00Z","CompletedByUserID":"E","CompletedByUserEmail":"F","CompletedByUserName":"G","ModifiedByUserID":"H","ModifiedByUserEmail":"I","ModifiedByUserName":"J","Revision":0,"Result":"K","Name":"L","NameLower":"M","Description":"N","DescriptionHtml":"O","DescriptionRichTextJson":"P","AssignmentUserEmail":"AB","AssignmentUserName":"AC","AssignmentUserNameLower":"AD","DueOn":"0001-01-01T00:00:00Z","DueOnModifiedOn":"0001-01-01T00:00:00Z",' +
            r'"PrimaryDocument":{"ID":"J","OrganizationID":"N","ProjectID":"U","ProjectName":"V","ProjectAccessType":"T","DocumentID":"G","DocumentFolderID":"E","DocumentFolderPath":"F","AssignmentUserEmails":["B"],"GroupID":"I","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserEmail":"C","CreatedByUserName":"D","ModifiedOn":"0001-01-01T00:00:00Z","ModifiedByUserEmail":"K","ModifiedByUserName":"L","PurgeDate":"0001-01-01T00:00:00Z","Name":"M","Origin":"O","PageCount":1,"FileSize":1,"ThumbnailUrl":"W","IsSigned":false,"PreviewMetadata":[{"0":"00","1":"11","2":"22"}],"ApprovalID":"A","ApprovalCreatedOn":"0001-01-01T00:00:00Z","IsMarkedForPurge":false,"HasSinglePageImages":false,"SignatureSessionIsActive":false,"SignaturesCompletedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","ProcessName":"S","ProcessElementName":"R","Revision":6,"PaperSize":"Q","PaperOrientation":"P","PaperMarginLeft":3.0,"PaperMarginRight":4.0,"PaperMarginTop":5.0,"PaperMarginBottom":2.0},' +
            r'"OtherDocuments":[{"ID":"J","OrganizationID":"N","ProjectID":"U","ProjectName":"V","ProjectAccessType":"T","DocumentID":"G","DocumentFolderID":"E","DocumentFolderPath":"F","AssignmentUserEmails":["B"],"GroupID":"I","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserEmail":"C","CreatedByUserName":"D","ModifiedOn":"0001-01-01T00:00:00Z","ModifiedByUserEmail":"K","ModifiedByUserName":"L","PurgeDate":"0001-01-01T00:00:00Z","Name":"M","Origin":"O","PageCount":1,"FileSize":1,"ThumbnailUrl":"W","IsSigned":false,"PreviewMetadata":[{"0":"00","1":"11","2":"22"}],"ApprovalID":"A","ApprovalCreatedOn":"0001-01-01T00:00:00Z","IsMarkedForPurge":false,"HasSinglePageImages":false,"SignatureSessionIsActive":false,"SignaturesCompletedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","ProcessName":"S","ProcessElementName":"R","Revision":6,"PaperSize":"Q","PaperOrientation":"P","PaperMarginLeft":3.0,"PaperMarginRight":4.0,"PaperMarginTop":5.0,"PaperMarginBottom":2.0}],' +
            r'"ParentTaskID":"Q","ProcessID":"R","ProcessName":"S","ProcessNameLower":"T","ProcessElementID":"U","ProcessElementName":"V","ProcessElementNameLower":"W","Reminder_7_Day":"0001-01-01T00:00:00Z","Reminder_3_Day":"0001-01-01T00:00:00Z","Reminder_1_Day":"0001-01-01T00:00:00Z"}';
    const expectedJsonCollection = '[$expectedJson]';

    test('getTasks method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsTasksFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project);

      // Test with default parameters
      await performHttpTest<QueryResult<TaskCollection, api_mod.TaskCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.tasks().get(),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with only cursor flag
      await performHttpTest<QueryResult<TaskCollection, api_mod.TaskCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.tasks().get(cursor: 'A'),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['cursor=A'],
      );

      // Test with only activeOnly flag
      await performHttpTest<QueryResult<TaskCollection, api_mod.TaskCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.tasks().get(activeOnly: true),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['activeOnly=true'],
      );

      // Test with only completedOnly flag
      await performHttpTest<QueryResult<TaskCollection, api_mod.TaskCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.tasks().get(completedOnly: true),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['completedOnly=true'],
      );

      // Test with only deniedOnly flag
      await performHttpTest<QueryResult<TaskCollection, api_mod.TaskCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.tasks().get(deniedOnly: true),
        responseBody: taskCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['deniedOnly=true'],
      );
    });

    test('getTasksByTaskId method tests', () async {
      final project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder('123');

      // Test with default parameters
      await performHttpTest<Task>(
        httpMethod: HttpMethods.get,
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
                httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
        httpCallCallback: () =>
            project.tasks().create(TaskCollection.fromApiModel(ts, app: project.app)),
        expectedRequestBody: expectedJsonCollection,
        responseBody: expectedJsonCollection,
        expectedRequestUrlPath: http.ApiPaths.organizationsProjectsTasksFormat
            .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
        expectedRequestQueryParams: [],
      );
    });

    test('put method tests', () async {
      final project = getStandardN1Project();
      final ts = _getTaskCollection(project);
      final expectedUrlPath = http.ApiPaths.organizationsProjectsTasksTaskFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder('A');

      await performHttpTest<void>(
        httpMethod: HttpMethods.put,
        httpCallCallback: () =>
            project.tasks().update(Task.fromApiModel(ts.tasks![0], app: project.app)),
        expectedRequestBody: expectedJson,
        responseBody: expectedJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'taskId=A',
        ],
      );
    });

    test('getTaskComments method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder('123');
      // Test with default parameters
      await performHttpTest<QueryResult2<TaskCommentCollection, api_mod.TaskCommentCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => project.task('123').getComments(),
        responseBody: taskCommentCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      project = getStandardN1Project();
      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<TaskCommentCollection, api_mod.TaskCommentCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () =>
            project.task('123').getComments(sortDescending: false, cursor: 'QueryResultA'),
        responseBody: taskCommentCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=QueryResultA'],
      );
    });

    test('createTaskComments method tests', () async {
      var project = getStandardN1Project();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsTasksTaskCommentsFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project)
          .replaceTaskIdPlaceholder('123');
      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.post,
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
        httpMethod: HttpMethods.post,
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
    ..reminder7Day = '0001-01-01T00:00:00Z'
    ..reminder3Day = '0001-01-01T00:00:00Z'
    ..reminder1Day = '0001-01-01T00:00:00Z'
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
