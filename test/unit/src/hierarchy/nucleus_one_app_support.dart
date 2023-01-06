import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_support.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/support_user.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:test/test.dart';

import '../api_model/support_user.dart' as api_mod;
import '../api_model/support_organization.dart' as api_mod;
import '../api_model/support_error_event.dart' as api_mod;
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('NucleusOneAppSupport class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getUsers method tests', () async {
      final expectedUrlPath = http.ApiPaths.supportUsers;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportUserCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getUsers(),
        responseBody: api_mod.supportUserCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrganizations method tests', () async {
      final expectedUrlPath = http.ApiPaths.supportOrganizations;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportOrganizationCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getOrganizations(),
        responseBody: api_mod.supportOrganizationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getErrorEvents method tests', () async {
      final expectedUrlPath = http.ApiPaths.supportErrorEvents;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportErrorEventCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getErrorEvents(
          serviceNameFilter: 'A',
          levelFilter: 'B',
          tenantIdFilter: 'C',
          tenantNameFilter: 'D',
          userEmailFilter: 'E',
          uniqueIdFilter: 'F',
          keywordFilter: 'G',
          sortDescending: false,
        ),
        responseBody: api_mod.supportErrorEventCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'serviceNameFilter=A',
          'levelFilter=B',
          'tenantIDFilter=C',
          'tenantNameFilter=D',
          'userEmailFilter=E',
          'uniqueIdFilter=F',
          'keywordFilter=G',
          'sortDescending=false',
        ],
      );
    });

    test('getAdminStatus method tests', () async {
      final expectedUrlPath = http.ApiPaths.supportAdmin;
      final tests = <String, bool>{
        '': false,
        'false': false,
        'true': true,
      };

      for (var test in tests.entries) {
        final n1App = getStandardN1App();

        await performHttpTest<bool>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () => NucleusOneAppSupport(app: n1App).getAdminStatus(),
          responseBody: test.key,
          expectedRequestUrlPath: expectedUrlPath,
          expectedRequestQueryParams: [],
          additionalValidationsCallback: (result) {
            expect(result, test.value);
          },
        );
      }
    });
  });
}
