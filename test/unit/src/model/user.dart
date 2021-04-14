import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/src/api_model/dashboard_widget.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart';
import 'package:nucleus_one_dart_sdk/src/model/dashboard_widget.dart' as mod;

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import 'dashboard_widget.dart';
import 'address_book.dart';

void main() {
  group('User class tests', () {
    test('getAddressBook method test', () async {
      final makeHttpCall = ({
        bool includeTenantMembers = true,
        bool includeRoles = true,
        bool includeFields = true,
        bool includeFormTemplateFields = true,
        String? filter,
      }) async {
        final u = getStandardTestUser();
        final ab = await u.getAddressBook(
          includeTenantMembers: includeTenantMembers,
          includeRoles: includeRoles,
          includeFields: includeFields,
          includeFormTemplateFields: includeFormTemplateFields,
          filter: filter,
        );
        expect(ab.items.length, 1);
      };

      var result = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(includeTenantMembers: true, includeRoles: false),
        responseBody: addressBookJson,
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.addressBookItems));
      expect(result.requestUri!.query, matches(r'\bincludeTenantMembers=true\b'));
      expect(result.requestUri!.query, matches(r'\bincludeRoles=false\b'));

      result = await createMockHttpClientScopeForGetRequest(
        callback: () =>
            makeHttpCall(includeFields: true, includeFormTemplateFields: false, filter: '123'),
        responseBody: addressBookJson,
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.addressBookItems));
      expect(result.requestUri!.query, matches(r'\bincludeFields=true\b'));
      expect(result.requestUri!.query, matches(r'\bincludeFormTemplateFields=false\b'));
      expect(result.requestUri!.query, matches(r'\bfilter=123\b'));
    });

    test('clearAddressBook method test', () async {
      final makeHttpCall = () async {
        await getStandardTestUser().clearAddressBook();
      };

      final result = await createMockHttpClientScopeForDeleteRequest(
        callback: () => makeHttpCall(),
        responseBody: '',
      );

      expect(result.request.method, HttpMethods.DELETE);
      expect(result.requestUri!.query, '');
    });

    test('getDashboardWidgets method test', () async {
      final makeHttpCall = () async {
        final ab = await getStandardTestUser().getDashboardWidgets();
        expect(ab.items.length, 2);
      };

      final result = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(),
        responseBody: dashboardWidgetsJson,
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri!.query, '');
    });

    test('deleteDashboardWidgets method test', () async {
      Future<HttpClientOperationResult> performTest(List<String> ids) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by the below method call.  While annoying, it is not otherwise harmful.
          // This should be addressed shortly in Dart 2.13.
          // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686
          await getStandardTestUser().deleteDashboardWidgets(ids);
        };

        return await createMockHttpClientScopeForDeleteRequest(
          callback: () => makeHttpCall(),
          responseBody: '',
        );
      }

      await testAssertionErrorAsync(() => performTest([]), 'ids');

      final result = await performTest(['abc', 'def']);
      expect(result.request.method, HttpMethods.DELETE);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri!.query, '');
      expect(result.request.getBodyAsString(), '{"IDs":["abc","def"]}');
    });

    // See note on [User.updateDashboardWidget] method, as to why this is commented out.
    // Nonetheless, the following tests should be fully functional.
    /*
    test('updateDashboardWidget method test', () async {
      Future<HttpClientOperationResult> performTest(DashboardWidget dashboardWidget) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by the below method call.  While annoying, it is not otherwise harmful.
          // This should be addressed shortly in Dart 2.13.
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
          result.requestUri!.path, apiRequestPathMatches(apiPaths.dashboardWidgets + '/' + dw.id!));
      expect(result.requestUri!.query, '');
      expect(result.getBodyAsString(),
          '{"ID":"1","TenantID":"2","TenantMemberID":"3","Type":"4","GridColumn":5,"ColumnRank":6,"Name":"7","Detail":"8","JsonData":"9"}');
    });
    */

    test('createDashboardWidgets method test', () async {
      Future<HttpClientOperationResult> performTest(
          api_mod.DashboardWidgets dashboardWidgets) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by the below method call.  While annoying, it is not otherwise harmful.
          // This should be addressed shortly in Dart 2.13.
          // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686
          await getStandardTestUser()
              .createDashboardWidgets(mod.DashboardWidgets.fromApiModel(dashboardWidgets));
        };

        return await createMockHttpClientScopeForPostRequest(
          callback: () => makeHttpCall(),
          responseBody: '',
        );
      }

      await testAssertionErrorAsync(() => performTest(api_mod.DashboardWidgets()), 'widgets');

      final dws = api_mod.DashboardWidgets()
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

      final result = await performTest(dws);
      expect(result.request.method, HttpMethods.POST);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri!.query, '');
      expect(result.request.getBodyAsString(),
          '[{"ID":"1","TenantID":"2","TenantMemberID":"3","Type":"4","GridColumn":5.0,"ColumnRank":6.0,"Name":"7","Detail":"8","JsonData":"9"}]');
    });

    test('updateDashboardWidgetRanks method test', () async {
      Future<HttpClientOperationResult> performTest(
          api_mod.DashboardWidgets dashboardWidgets) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by the below method call.  While annoying, it is not otherwise harmful.
          // This should be addressed shortly in Dart 2.13.
          // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686
          await getStandardTestUser()
              .updateDashboardWidgetRanks(mod.DashboardWidgets.fromApiModel(dashboardWidgets));
        };

        return await createMockHttpClientScopeForPutRequest(
          callback: () => makeHttpCall(),
          responseBody: '',
        );
      }

      await testAssertionErrorAsync(() => performTest(api_mod.DashboardWidgets()), 'widgets');

      final dws = api_mod.DashboardWidgets()
        ..items = [
          api_mod.DashboardWidget.forRankUpdate('abc', 0, 1),
          api_mod.DashboardWidget.forRankUpdate('def', 2, 3),
        ];
      final result = await performTest(dws);
      expect(result.request.method, HttpMethods.PUT);
      expect(result.requestUri!.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri!.query, 'onlyRank=true');
      expect(result.request.getBodyAsString(),
          '[{"ID":"abc","GridColumn":0.0,"ColumnRank":1.0},{"ID":"def","GridColumn":2.0,"ColumnRank":3.0}]');
    });
  });
}
