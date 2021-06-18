import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/organization_package.dart';
import '../api_model/organization_permissions.dart';
import '../api_model/subscription_invoice.dart';
import '../api_model/tenant.dart';

void main() {
  group('NucleusOneAppOrganization class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getTenants method tests', () async {
      final expectedUrlPath =
          http.apiPaths.organizationsTenantsFormat.replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      try {
        await performHttpTest<QueryResult<TenantCollection>>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              NucleusOneAppOrganization(app: n1App).getTenants(organizationId: ''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
      } on ArgumentError catch (e) {
        expect(e.name, 'organizationId');
      }

      // Test with default parameters
      await performHttpTest<QueryResult<TenantCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppOrganization(app: n1App).getTenants(organizationId: '123'),
        responseBody: tenantCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor and optional arguments
      await performHttpTest<QueryResult<TenantCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppOrganization(app: n1App).getTenants(
          organizationId: '123',
          cursor: 'A',
        ),
        responseBody: tenantCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
        ],
      );
    });

    test('getPermissions method tests', () async {
      final expectedUrlPath =
          http.apiPaths.organizationsPermissionsFormat.replaceFirst('<organizationId>', '123');
      final n1App = getStandardN1App();

      try {
        await performHttpTest<OrganizationPermissions>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              NucleusOneAppOrganization(app: n1App).getPermissions(organizationId: ''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
      } on ArgumentError catch (e) {
        expect(e.name, 'organizationId');
      }

      // Test with default parameters
      await performHttpTest<OrganizationPermissions>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppOrganization(app: n1App).getPermissions(organizationId: '123'),
        responseBody: organizationPermissionsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('adminGetOrganizationPackagesForCurrentUser method tests', () async {
      final expectedUrlPath = http.apiPaths.adminOrganizationPackagesForCurrentUser;
      final n1App = getStandardN1App();

      await performHttpTest<QueryResult<OrganizationPackageCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            NucleusOneAppOrganization(app: n1App).adminGetOrganizationPackagesForCurrentUser(),
        responseBody: organizationPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedQueryResultPageSize: 0,
        expectedQueryResultCursor: '',
      );
    });

    test('acceptInvitation method tests', () async {
      final expectedUrlPath =
          http.apiPaths.organizationInvitationsFormat.replaceFirst('<invitationId>', '123');
      final n1App = getStandardN1App();

      try {
        await performHttpTest<OrganizationPackage>(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () =>
              NucleusOneAppOrganization(app: n1App).acceptInvitation(invitationId: ''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
      } on ArgumentError catch (e) {
        expect(e.name, 'invitationId');
      }

      // Test with default parameters
      await performHttpTest<OrganizationPackage>(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () =>
            NucleusOneAppOrganization(app: n1App).acceptInvitation(invitationId: '123'),
        responseBody: organizationPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
