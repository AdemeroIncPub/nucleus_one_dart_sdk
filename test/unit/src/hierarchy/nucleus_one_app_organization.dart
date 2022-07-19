import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/organization_permissions.dart';
import '../api_model/subscription_details.dart';

void main() {
  group('NucleusOneAppOrganization class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getPermissions method tests', () async {
      final expectedUrlPath =
          http.apiPaths.organizationsPermissionsFormat.replaceFirst('<organizationId>', '123');
      var org = getStandardN1Org();

      try {
        await performHttpTest<OrganizationPermissions>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => org.getPermissions(organizationId: ''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
      } on ArgumentError catch (e) {
        expect(e.name, 'organizationId');
      }

      org = getStandardN1Org();
      // Test with default parameters
      await performHttpTest<OrganizationPermissions>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => org.getPermissions(organizationId: '123'),
        responseBody: organizationPermissionsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getOrganizationSubscription method tests', () async {
      final expectedUrlPath =
          http.apiPaths.organizationsSubscriptionsFormat.replaceOrganizationPlaceholder('orgId');
      final org = getStandardN1Org();

      // Test with default parameters
      await performHttpTest<SubscriptionDetails>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => org.getOrganizationSubscription(
          organizationId: '123',
        ),
        responseBody: subscriptionDetailsJson,
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
  });
}
