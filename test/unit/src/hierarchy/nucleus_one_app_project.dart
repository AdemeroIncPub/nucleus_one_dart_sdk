import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/folder_hierarchies.dart';
import '../api_model/project_packages.dart';
import '../api_model/project_permissions.dart';

void main() {
  group('NucleusOneAppProjects class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getPermissions method tests', () async {
      final expectedUrlPath =
          http.apiPaths.tenantPermissionsFormat.replaceFirst('<tenantId>', '123');
      final n1App = getStandardN1App();

      try {
        await performHttpTest(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => NucleusOneAppProjects(app: n1App).getPermissions(''),
          responseBody: '',
          expectedRequestUrlPath: '',
          expectedRequestQueryParams: [],
        );
        fail('An error should have been thrown.');
      } on ArgumentError catch (e) {
        expect(e.name, 'projectId');
      }

      await performHttpTest<ProjectPermissions>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppProjects(app: n1App).getPermissions('123'),
        responseBody: activeProjectPermissionsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });

    test('getPackages method tests', () async {
      final expectedUrlPath = http.apiPaths.tenantPackagesForCurrentUser;
      final n1App = getStandardN1App();

      await performHttpTest<ProjectPackageCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppProjects(app: n1App).getPackages(),
        responseBody: projectPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });
}
