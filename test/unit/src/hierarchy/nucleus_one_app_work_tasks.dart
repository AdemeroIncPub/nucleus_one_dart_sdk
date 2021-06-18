import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/work_task.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_work_tasks.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/work_task.dart';
import 'package:test/test.dart';
import '../../../src/assertions.dart';
import '../api_model/work_task.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('NucleusOneAppWorkTasks class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('get method tests', () async {
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

    test('post method tests', () async {
      final expectedUrlPath = http.apiPaths.workTasks;
      final n1App = getStandardN1App();
      // Test assertion error when no tasks are provided
      await testAssertionErrorAsync(
          () => performHttpTest<void>(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => NucleusOneAppWorkTasks(app: n1App)
                    .postWorkTasks(WorkTaskCollection.fromApiModel(api_mod.WorkTaskCollection())),
                responseBody: '',
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
              ),
          'workTasks');

      final wts = api_mod.WorkTaskCollection()
        ..workTasks = [
          api_mod.WorkTask()
          // ..id = '1'
          // ..tenantID = '2'
          // ..tenantMemberID = '3'
          // ..type = '4'
          // ..gridColumn = 5
          // ..columnRank = 6
          // ..name = '7'
          // ..detail = '8'
          // ..jsonData = '9'
        ];
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () =>
            NucleusOneAppWorkTasks(app: n1App).postWorkTasks(WorkTaskCollection.fromApiModel(wts)),
        responseBody: '[' + workTaskJson + ']',
        expectedRequestUrlPath: http.apiPaths.workTasks,
        expectedRequestQueryParams: [],
      );
    });
  });
}
