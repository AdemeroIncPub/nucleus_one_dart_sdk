import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart';
import 'package:test/test.dart';

import '../../src/assertions.dart';
import '../../src/common.dart';
import '../../src/mocks/http.dart';
import 'address_book.dart';
import 'dashboard_widget.dart';

void main() {
  group('User class tests', () {
    test('getAddressBook method test', () async {
      final makeHttpCall = ({
        bool includeTenantMembers = true,
        bool includeRoles = true,
        bool includeFields = true,
        bool includeFormTemplateFields = true,
        String filter,
      }) async {
        final u = getStandardTestUser();
        final ab = await u.getAddressBook(
          includeTenantMembers: includeTenantMembers,
          includeRoles: includeRoles,
          includeFields: includeFields,
          includeFormTemplateFields: includeFormTemplateFields,
          filter: filter,
        );
        expect(ab.items.length, 2);
      };

      var result = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(includeTenantMembers: true, includeRoles: false),
        responseBody: addressBookJson.split(''),
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri.path, apiRequestPathMatches(apiPaths.addressBookItems));
      expect(result.requestUri.query, matches(r'\bincludeTenantMembers=true\b'));
      expect(result.requestUri.query, matches(r'\bincludeRoles=false\b'));

      result = await createMockHttpClientScopeForGetRequest(
        callback: () =>
            makeHttpCall(includeFields: true, includeFormTemplateFields: false, filter: '123'),
        responseBody: addressBookJson.split(''),
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri.path, apiRequestPathMatches(apiPaths.addressBookItems));
      expect(result.requestUri.query, matches(r'\bincludeFields=true\b'));
      expect(result.requestUri.query, matches(r'\bincludeFormTemplateFields=false\b'));
      expect(result.requestUri.query, matches(r'\bfilter=123\b'));
    });

    test('clearAddressBook method test', () async {
      final makeHttpCall = () async {
        await getStandardTestUser().clearAddressBook();
      };

      final result = await createMockHttpClientScopeForDeleteRequest(
        callback: () => makeHttpCall(),
        responseBody: addressBookJson.split(''),
      );

      expect(result.request.method, HttpMethods.DELETE);
      expect(result.requestUri.query, '');
    });

    test('getDashboardWidgets method test', () async {
      final makeHttpCall = () async {
        final ab = await getStandardTestUser().getDashboardWidgets();
        expect(ab.items.length, 2);
      };

      final result = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(),
        responseBody: dashboardWidgetsJson.split(''),
      );

      expect(result.request.method, HttpMethods.GET);
      expect(result.requestUri.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri.query, '');
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
          responseBody: dashboardWidgetsJson.split(''),
        );
      }

      await testAssertionErrorAsync(() => performTest(null), 'ids');

      final result = await performTest(['abc', 'def']);
      expect(result.request.method, HttpMethods.DELETE);
      expect(result.requestUri.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri.query, '');
      expect(result.getBodyAsString(), '{"IDs":["abc","def"]}');
    });

    test('updateDashboardWidgetRanks method test', () async {
      Future<HttpClientOperationResult> performTest(
          List<DashboardWidgetToUpdate> dashboardWidgets) async {
        final makeHttpCall = () async {
          // It is a known issue that, when debugging tests, the debugger breaks at the handled
          // exception thrown by the below method call.  While annoying, it is not otherwise harmful.
          // This should be addressed shortly in Dart 2.13.
          // https://github.com/dart-lang/sdk/issues/37953#issuecomment-792305686
          await getStandardTestUser().updateDashboardWidgetRanks(dashboardWidgets);
        };

        return await createMockHttpClientScopeForPutRequest(
          callback: () => makeHttpCall(),
          responseBody: dashboardWidgetsJson.split(''),
        );
      }

      await testAssertionErrorAsync(() => performTest(null), 'widgetsToUpdate');
      await testAssertionErrorAsync(() => performTest([]), 'widgetsToUpdate');

      final result = await performTest([
        DashboardWidgetToUpdate.forRankUpdate('abc', 0, 1),
        DashboardWidgetToUpdate.forRankUpdate('def', 2, 3),
      ]);
      expect(result.request.method, HttpMethods.PUT);
      expect(result.requestUri.path, apiRequestPathMatches(apiPaths.dashboardWidgets));
      expect(result.requestUri.query, 'onlyRank=true');
      expect(result.getBodyAsString(),
          '[{"ID":"abc","GridColumn":0,"ColumnRank":1},{"ID":"def","GridColumn":2,"ColumnRank":3}]');
    });
  });
}
