import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/organization_package.dart';
import '../api_model/organization_permissions.dart';
import '../api_model/tenant.dart';

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
  });
}
