import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/dashboard_widget.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/user_profile.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart';

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/address_book.dart';
import '../api_model/dashboard_widget.dart';
import '../api_model/user_profile.dart';

void main() {
  group('User class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getAddressBook method test', () async {
      // Test with default parameters
      await performHttpTest<AddressBook>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => getStandardTestUser().getAddressBook(),
        responseBody: addressBookJson,
        expectedUrlPath: apiPaths.addressBookItems,
        expectedQueryParams: [
          'includeTenantMembers=true',
          'includeRoles=true',
          'includeFields=true',
          'includeFormTemplateFields=true',
        ],
        additionalValidationsCallback: (x) {
          expect(x.items.length, 1);
        },
      );

      // The following two tests test that individual parameters are set correct

      await performHttpTest<AddressBook>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => getStandardTestUser().getAddressBook(
          includeTenantMembers: true,
          includeRoles: false,
        ),
        responseBody: addressBookJson,
        expectedUrlPath: apiPaths.addressBookItems,
        expectedQueryParams: [
          'includeTenantMembers=true',
          'includeRoles=false',
          'includeFields=true',
          'includeFormTemplateFields=true',
        ],
        additionalValidationsCallback: (x) {
          expect(x.items.length, 1);
        },
      );

      // Test with three of the parameters set
      await performHttpTest<AddressBook>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => getStandardTestUser().getAddressBook(
          includeFields: true,
          includeFormTemplateFields: false,
          filter: '123',
        ),
        responseBody: addressBookJson,
        expectedUrlPath: apiPaths.addressBookItems,
        expectedQueryParams: [
          'includeTenantMembers=true',
          'includeRoles=true',
          'includeFields=true',
          'includeFormTemplateFields=false',
          'filter=123',
        ],
        additionalValidationsCallback: (x) {
          expect(x.items.length, 1);
        },
      );
    });

    test('clearAddressBook method test', () async {
      await performHttpTest(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => getStandardTestUser().clearAddressBook(),
        responseBody: '',
        expectedUrlPath: apiPaths.addressBookItems,
        expectedQueryParams: [],
      );
    });

    test('getDashboardWidgets method test', () async {
      await performHttpTest<DashboardWidgetCollection>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => getStandardTestUser().getDashboardWidgets(),
        responseBody: dashboardWidgetsJson,
        expectedUrlPath: apiPaths.dashboardWidgets,
        expectedQueryParams: [],
        additionalValidationsCallback: (x) {
          expect(x.items.length, 2);
        },
      );
    });

    test('deleteDashboardWidgets method test', () async {
      // It is a known issue that, when debugging tests, the debugger breaks at the handled
      // exception thrown by one or more of the below method calls.  While annoying, it is not
      // otherwise harmful.  This should be addressed shortly in Dart 2.13.
      // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686

      // Test assertion error when no widgets are provided
      await testAssertionErrorAsync(
          () => performHttpTest(
                httpMethod: HttpMethods.DELETE,
                httpCallCallback: () => getStandardTestUser().deleteDashboardWidgets([]),
                responseBody: '',
                expectedUrlPath: '',
                expectedQueryParams: [],
              ),
          'ids');

      await performHttpTest(
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => getStandardTestUser().deleteDashboardWidgets(['abc', 'def']),
        responseBody: '{"IDs":["abc","def"]}',
        expectedUrlPath: apiPaths.dashboardWidgets,
        expectedQueryParams: [],
      );
    });

    // See note on [User.updateDashboardWidget] method, as to why this is commented out.
    // Nonetheless, the following tests should be fully functional.
    // Needs to be updated to us standard HTTP testing methods, though.
    /*
    test('updateDashboardWidget method test', () async {
      Future<HttpClientOperationResult> performTest(DashboardWidget dashboardWidget) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by one or more of the below method calls.  While annoying, it is not
          // otherwise harmful.  This should be addressed shortly in Dart 2.13.
          // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686
          await getStandardTestUser().updateDashboardWidget(dashboardWidget);
        };

        return await createMockHttpClientScopeForPutRequest(
          callback: () => makeHttpCall(),
          responseBody: '',
        );
      }

      await testAssertionErrorAsync(() => performTest(DashboardWidget()), 'id');

      final dw = DashboardWidget()
        ..id = '1'
        ..tenantID = '2'
        ..tenantMemberID = '3'
        ..type = '4'
        ..gridColumn = 5
        ..columnRank = 6
        ..name = '7'
        ..detail = '8'
        ..jsonData = '9';

      final result = await performTest(dw);
      expect(result.request.method, HttpMethods.PUT);
      expect(
          result.request.uri.path, apiRequestPathMatches(apiPaths.dashboardWidgets + '/' + dw.id!));
      expect(result.request.uri.query, '');
      expect(result.getBodyAsString(),
          '{"ID":"1","TenantID":"2","TenantMemberID":"3","Type":"4","GridColumn":5,"ColumnRank":6,"Name":"7","Detail":"8","JsonData":"9"}');
    });
    */

    test('createDashboardWidgets method test', () async {
      // Test assertion error when no widgets are provided
      await testAssertionErrorAsync(
          () => performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => getStandardTestUser().createDashboardWidgets(
                    DashboardWidgetCollection.fromApiModel(api_mod.DashboardWidgetCollection())),
                responseBody: '',
                expectedUrlPath: '',
                expectedQueryParams: [],
              ),
          'widgets');

      final dws = api_mod.DashboardWidgetCollection()
        ..items = [
          api_mod.DashboardWidget()
            ..id = '1'
            ..tenantID = '2'
            ..tenantMemberID = '3'
            ..type = '4'
            ..gridColumn = 5
            ..columnRank = 6
            ..name = '7'
            ..detail = '8'
            ..jsonData = '9'
        ];
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => getStandardTestUser()
            .createDashboardWidgets(DashboardWidgetCollection.fromApiModel(dws)),
        responseBody:
            '[{"ID":"1","TenantID":"2","TenantMemberID":"3","Type":"4","GridColumn":5.0,"ColumnRank":6.0,"Name":"7","Detail":"8","JsonData":"9"}]',
        expectedUrlPath: apiPaths.dashboardWidgets,
        expectedQueryParams: [],
      );
    });

    test('updateDashboardWidgetRanks method test', () async {
      // It is a known issue that, when debugging tests, the debugger breaks at the handled
      // exception thrown by one or more of the below method calls.  While annoying, it is not
      // otherwise harmful.  This should be addressed shortly in Dart 2.13.
      // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686

      // Test assertion error when no widgets are provided
      await testAssertionErrorAsync(
          () => performHttpTest(
                httpMethod: HttpMethods.PUT,
                httpCallCallback: () => getStandardTestUser().updateDashboardWidgetRanks(
                    DashboardWidgetCollection.fromApiModel(api_mod.DashboardWidgetCollection())),
                responseBody: '',
                expectedUrlPath: '',
                expectedQueryParams: [],
              ),
          'widgets');

      // Test with valid request
      final dws = api_mod.DashboardWidgetCollection()
        ..items = [
          api_mod.DashboardWidget.forRankUpdate('abc', 0, 1),
          api_mod.DashboardWidget.forRankUpdate('def', 2, 3),
        ];
      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => getStandardTestUser()
            .updateDashboardWidgetRanks(DashboardWidgetCollection.fromApiModel(dws)),
        responseBody:
            '[{"ID":"abc","GridColumn":0.0,"ColumnRank":1.0},{"ID":"def","GridColumn":2.0,"ColumnRank":3.0}]',
        expectedUrlPath: apiPaths.dashboardWidgets,
        expectedQueryParams: ['onlyRank=true'],
      );
    });

    test('getProfile method test', () async {
      await performHttpTest<UserProfile>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => getStandardTestUser().getProfile(),
        responseBody: userProfileJson,
        expectedUrlPath: apiPaths.userProfile,
        expectedQueryParams: [],
      );
    });

    test('updateProfile method test', () async {
      final up = api_mod.UserProfile()
        ..userProvider = 'A'
        ..userEmail = 'B'
        ..userName = 'C'
        ..otpsmsNumber = 'D';

      await performHttpTest(
        httpMethod: HttpMethods.PUT,
        httpCallCallback: () => getStandardTestUser().updateProfile(UserProfile.fromApiModel(up)),
        responseBody: '',
        expectedUrlPath: apiPaths.userProfile,
        expectedQueryParams: [],
        expectedBody: '{"UserProvider":"A","UserEmail":"B","UserName":"C","OTPSMSNumber":"D"}',
      );
    });
  });
}
