import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_support.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/model/support_user.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_organization_tenant.dart';
import 'package:nucleus_one_dart_sdk/src/model/support_error_event.dart';
import 'package:test/test.dart';

import '../api_model/support_user.dart' as api_mod;
import '../api_model/support_organization.dart' as api_mod;
import '../api_model/support_organization_tenant.dart' as api_mod;
import '../api_model/support_error_event.dart' as api_mod;
import '../../../src/common.dart';
import '../../../src/model_helper.dart';
import '../../../src/mocks/http.dart';

void main() {
  group('NucleusOneAppSupport class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getSupportUsers method tests', () async {
      final expectedUrlPath = http.apiPaths.supportUsers;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportUserCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getSupportUsers(),
        responseBody: api_mod.supportUserCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSupportOrganizations method tests', () async {
      final expectedUrlPath = http.apiPaths.supportOrganizations;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportOrganizationCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getSupportOrganizations(),
        responseBody: api_mod.supportOrganizationCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSupportOrganizationTenants method tests', () async {
      final expectedUrlPath =
          http.apiPaths.supportOrganizationsTenantsFormat.replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportOrganizationTenantCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppSupport(app: n1App).getSupportOrganizationTenants(organizationId: '123'),
        responseBody: api_mod.supportOrganizationTenantCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getSupportErrorEvents method tests', () async {
      final expectedUrlPath = http.apiPaths.supportErrorEvents;
      final n1App = getStandardN1App();

      // Test with default parameters
      await performHttpTest<QueryResult<SupportErrorEventCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getSupportErrorEvents(
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

    test('getSupportAdminStatus method tests', () async {
      final expectedUrlPath = http.apiPaths.supportAdmin;
      final n1App = getStandardN1App();

      await performHttpTest<void>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppSupport(app: n1App).getSupportAdminStatus(),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
