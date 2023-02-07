import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription_for_client.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_membership_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/organization_project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document_subscription_for_client.dart';
import '../api_model/organization_membership_package.dart';
import '../api_model/organization_permissions.dart';
import '../api_model/organization_project.dart';
import '../api_model/subscription_details.dart';

void main() {
  group('NucleusOneAppOrganization class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Constructor test', () {
      final app = getStandardN1App();
      final org = NucleusOneAppOrganization(app: app, id: '123');
      expect(org.app, app);
      expect(org.id, '123');

      expect(
          () => NucleusOneAppOrganization(app: app, id: ''),
          throwsA(allOf(
            isArgumentError,
            predicate(
                (ArgumentError e) => (e.name == 'id') && (e.message == 'Value cannot be blank.')),
          )));
    });

    test('getPermissions method tests', () async {
      final expectedUrlPath =
          http.ApiPaths.organizationsPermissionsFormat.replaceOrgIdPlaceholder('orgId');
      var org = getStandardN1Org();

      org = getStandardN1Org();
      // Test with default parameters
      await performHttpTest<OrganizationPermissions>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getPermissions(),
        responseBody: organizationPermissionsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrganizationSubscription method tests', () async {
      final expectedUrlPath =
          http.ApiPaths.organizationsSubscriptionsFormat.replaceOrgIdPlaceholder('orgId');
      final org = getStandardN1Org();

      // Test with default parameters
      await performHttpTest<SubscriptionDetails>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getOrganizationSubscription(
          organizationId: '123',
        ),
        responseBody: subscriptionDetailsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getDocumentSubscriptions method tests', () async {
      final expectedUrlPath = http.ApiPaths.organizationsOrganizationDocumentSubscriptionsFormat
          .replaceOrgIdPlaceholder('orgId');
      final org = getStandardN1Org();

      // Test with default parameters
      await performHttpTest<
          QueryResult<DocumentSubscriptionForClientCollection,
              api_mod.DocumentSubscriptionForClientCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getDocumentSubscriptions(),
        responseBody: documentSubscriptionForClientCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getProject method tests', () async {
      final org = getStandardN1Org();
      final expectedUrlPath = http.ApiPaths.organizationsProjectsProjectFormat
          .replaceOrgIdAndProjectIdPlaceholders(org.id, 'projId');

      // Test with default parameters
      await performHttpTest<OrganizationProject>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getProject(
          projectId: 'projId',
        ),
        responseBody: organizationProjectJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('project method tests', () {
      final org = getStandardN1Org();

      final project = org.project('123');
      expect(project, isA<NucleusOneAppProject>());
      expect(project.id, '123');
      expect(project.app, org.app);
    });

    test('getProjects method tests', () async {
      var org = getStandardN1Org();
      final expectedUrlPath =
          http.ApiPaths.organizationsProjectsFormat.replaceOrgIdPlaceholder('orgId');

      // Test with default parameters
      await performHttpTest<
          QueryResult<OrganizationProjectCollection, api_mod.OrganizationProjectCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getProjects(),
        responseBody: organizationProjectCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      org = getStandardN1Org();
      // Test with custom sorting and optional arguments
      await performHttpTest<
          QueryResult<OrganizationProjectCollection, api_mod.OrganizationProjectCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getProjects(
          cursor: 'A',
          projectAccessType: 'B',
          nameFilter: 'D',
          getAll: true,
          adminOnly: false,
        ),
        responseBody: organizationProjectCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
          'projectAccessType=B',
          'nameFilter=D',
          'getAll=true',
          'adminOnly=false',
        ],
      );
    });

    test('getOrganizationMembershipPackages method tests', () async {
      final org = getStandardN1Org();
      final expectedUrlPath =
          http.ApiPaths.organizationMembershipPackagesFormat.replaceOrgIdPlaceholder('orgId');

      // Test with default parameters
      await performHttpTest<
          QueryResult<OrganizationMembershipPackageCollection,
              api_mod.OrganizationMembershipPackageCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => org.getMembershipPackages(),
        responseBody: organizationMembershipPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
