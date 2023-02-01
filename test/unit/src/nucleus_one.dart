import 'package:file/file.dart' as file;
import 'package:file/local.dart' as file;
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/common/get_it.dart';
import 'package:nucleus_one_dart_sdk/src/common/string.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';
import '../../src/mocks/http.dart';
import '../../src/model_helper.dart';
import 'api_model/organization_for_client.dart';
import 'api_model/organization_membership_package.dart';

void main() {
  group('NucleusOne class tests', () {
    test('initializeSdk & resetSdk methods test', () async {
      expect(getIt.isRegistered<file.FileSystem>(), isFalse);
      await NucleusOne.initializeSdk();
      expect(getIt.isRegistered<file.FileSystem>(), isTrue);
      expect(getIt.get<file.FileSystem>(), isA<file.LocalFileSystem>());

      await NucleusOne.resetSdk();
      expect(getIt.isRegistered<file.FileSystem>(), isFalse);
    });
  });

  group('NucleusOneOptions class tests', () {
    test('Constructor tests', () {
      testValidAssertion(() => NucleusOneOptions(apiBaseUrl: ''));

      testValidAssertion(() => NucleusOneOptions(apiBaseUrl: '', apiKey: ''));

      final n1Opts = NucleusOneOptions(apiBaseUrl: 'abc', apiKey: 'bcd');
      expect(n1Opts.apiBaseUrl, 'abc');
      expect(n1Opts.apiKey, 'bcd');
    });
  });

  group('NucleusOneApp class tests', () {
    test('Constructor tests', () {
      final n1Options = NucleusOneOptions(apiBaseUrl: '');
      final n1App = NucleusOneApp(options: n1Options);
      expect(n1App.options, n1Options);
    });

    test('getFullUrl method tests', () {
      const baseUrl = 'https://abc.com';
      final n1App = getStandardN1App(baseUrl: baseUrl);

      expect(n1App.getFullUrl('/test'), '$baseUrl${NucleusOneApp.apiBaseUrlPath}/test');
    });

    test('user method tests', () {
      final n1App = getStandardN1App();

      final user = n1App.user();
      expect(user, isA<NucleusOneAppUser>());
      expect(user.app, n1App);
    });

    test('organization method tests', () {
      final n1App = getStandardN1App();

      final org = n1App.organization('123');
      expect(org, isA<NucleusOneAppOrganization>());
      expect(org.app, n1App);
    });

    test('getOrganization method tests', () async {
      // final org = getStandardN1Org();
      // final expectedUrlPath =
      //     http.apiPaths.organizationsOrganizationFormat.replaceOrgIdPlaceholder(org.id);
      final expectedUrlPath = http.ApiPaths.organizations;

      await performHttpTest<void>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganization(organizationId: 'A'),
        responseBody: organizationForClientCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test that an eror is thrown when the requested org is not found.  This is only necessary
      // untilthe proper implementation is in place in the N1 API.  See the getOrganization method
      // for details.
      final pt = performHttpTest<void>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganization(organizationId: '123'),
        responseBody: organizationForClientCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      expect(
          () => pt,
          throwsA(allOf(
            TypeMatcher<NucleusOneHttpException>(),
            predicate((NucleusOneHttpException e) => (e.status == 404)),
          )));
    });

    test('getOrganizations method tests', () async {
      final expectedUrlPath = http.ApiPaths.organizations;

      // Test with default parameters
      await performHttpTest<QueryResult<OrganizationForClientCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganizations(),
        responseBody: organizationForClientCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      // Test with cursor parameter
      await performHttpTest<QueryResult<OrganizationForClientCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganizations(cursor: 'A'),
        responseBody: organizationForClientCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'cursor=A',
        ],
      );
    });

    test('log method tests', () async {
      final app = getStandardN1App();
      final expectedUrlPath = http.ApiPaths.logs;

      // Test with default parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => app.log(
          message: 'A',
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Value1":"A"}',
      );

      // Test with optional parameters
      await performHttpTest<void>(
        httpMethod: HttpMethods.post,
        httpCallCallback: () => app.log(
          eventHeader: 'A',
          message: 'B',
          message2: 'C',
          message3: 'D',
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Header":"A","Value1":"B","Value2":"C","Value3":"D"}',
      );
    });

    test('getOrganizationMembershipPackages method tests', () async {
      String expectedUrlPath = http.ApiPaths.organizationMembershipPackages;

      // Test with default parameters
      await performHttpTest<QueryResult<OrganizationMembershipPackageCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganizationMembershipPackages(),
        responseBody: organizationMembershipPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );

      const organizationId = 'orgId';
      expectedUrlPath = http.ApiPaths.organizationMembershipPackagesFormat
          .replaceOrgIdPlaceholder(organizationId);

      // Test with an organization parameter
      await performHttpTest<QueryResult<OrganizationMembershipPackageCollection>>(
        httpMethod: HttpMethods.get,
        httpCallCallback: () => getStandardN1App().getOrganizationMembershipPackages(
          organizationId: organizationId,
        ),
        responseBody: organizationMembershipPackageCollectionJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
      );
    });
  });

  // group('DocumentForClient class tests', () {
  //   test('Constructor tests', () {
  //     final n1App = getStandardN1App();

  //     final doc = DocumentForClient(app: n1App);
  //     expect(doc.app, n1App);
  //   });

  //   test('getDocumentCount method tests', () async {
  //     final returnValue = 123;
  //     final queryParamCombinations = [
  //       [false, true],
  //       [true, false],
  //     ];

  //     for (var queryParamCombination in queryParamCombinations) {
  //       final opResult = await createMockHttpClientScopeForGetRequest(
  //         callback: () async {
  //           final n1App = getStandardN1App();
  //           final ignoreInbox = queryParamCombination[0],
  //               ignoreRecycleBin = queryParamCombination[1];
  //           final docCount = await NucleusOneAppDocument(app: n1App)
  //               .getDocumentCount(ignoreInbox, ignoreRecycleBin);
  //           expect(docCount, returnValue);
  //         },
  //         responseBody: returnValue.toString(),
  //       );

  //       expect(opResult.request.uri.query,
  //           matches(r'\bignoreInbox=' + queryParamCombination[0].toString() + r'\b'));
  //       expect(opResult.request.uri.query,
  //           matches(r'\bignoreRecycleBin=' + queryParamCombination[1].toString() + r'\b'));

  //       expect(opResult.headers.headers.length, 5);
  //       opResult.headers.expectContainsAllKeys([
  //         'Pragma',
  //         'Cache-Control',
  //         'Accept',
  //         'Content-Type',
  //         'Accept-Encoding' /*, 'Cookie'*/
  //       ]);
  //     }
  //   });
  // });

  group('LoginResult class tests', () {
    test('Constructor tests', () {
      testAssertionError(() => LoginResult(success: true, sessionId: null), 'sessionId');
      testAssertionError(() => LoginResult(success: true, sessionId: ''), 'sessionId');

      testValidAssertion(() => LoginResult(success: false, sessionId: null));

      final lr = LoginResult(success: true, sessionId: '123');
      expect(lr.success, true);
      expect(lr.sessionId, '123');
    });
  });
}
