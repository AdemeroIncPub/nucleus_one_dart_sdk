import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_approvals.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/approval.dart';
import 'package:test/test.dart';

import '../api_model/approval.dart';
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('NucleusOneAppApprovals class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('get method tests', () async {
      final expectedUrlPath = http.apiPaths.approvals;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<ApprovalCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppApprovals(app: n1App).getApprovals(
          processElementId: 'A',
          sortDescending: false,
          processId: 'B',
          sortType: 'C',
        ),
        responseBody: approvalCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'processElementID=A',
          'sortDescending=false',
          'processID=B',
          'sortType=C',
        ],
      );
    });
  });
}
