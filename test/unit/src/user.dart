import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

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
        final n1App = NucleusOneAppInternal(
          options: NucleusOneOptions(baseUrl: ''),
        );

        final u = User(app: n1App);
        final ab = await u.getAddressBook(
          includeTenantMembers: includeTenantMembers,
          includeRoles: includeRoles,
          includeFields: includeFields,
          includeFormTemplateFields: includeFormTemplateFields,
          filter: filter,
        );
        expect(ab.items.length, 2);
      };

      var opResult = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(includeTenantMembers: true, includeRoles: false),
        responseBody: addressBookJson.split(''),
      );

      expect(opResult.requestUri.query, matches(r'\bincludeTenantMembers=true\b'));
      expect(opResult.requestUri.query, matches(r'\bincludeRoles=false\b'));

      opResult = await createMockHttpClientScopeForGetRequest(
        callback: () =>
            makeHttpCall(includeFields: true, includeFormTemplateFields: false, filter: '123'),
        responseBody: addressBookJson.split(''),
      );

      expect(opResult.requestUri.query, matches(r'\bincludeFields=true\b'));
      expect(opResult.requestUri.query, matches(r'\bincludeFormTemplateFields=false\b'));
      expect(opResult.requestUri.query, matches(r'\bfilter=123\b'));
    });

    test('clearAddressBook method test', () async {
      final makeHttpCall = () async {
        final n1App = NucleusOneAppInternal(
          options: NucleusOneOptions(baseUrl: ''),
        );

        final u = User(app: n1App);
        await u.clearAddressBook();
      };

      final opResult = await createMockHttpClientScopeForDeleteRequest(
        callback: () => makeHttpCall(),
        responseBody: addressBookJson.split(''),
      );

      expect(opResult.requestUri.query, '');
    });

    test('getDashboardWidgets method test', () async {
      final makeHttpCall = () async {
        final n1App = NucleusOneAppInternal(
          options: NucleusOneOptions(baseUrl: ''),
        );

        final u = User(app: n1App);
        final ab = await u.getDashboardWidgets();
        expect(ab.items.length, 2);
      };

      final opResult = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(),
        responseBody: dashboardWidgetsJson.split(''),
      );

      expect(opResult.requestUri.query, '');
    });
  });
}
