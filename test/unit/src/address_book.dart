import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/nucleus_one.dart';
import 'package:test/test.dart';

import '../../src/mocks/http.dart';

void main() {
  const _addressBookItem1Json =
      '{"EmailLower":"123@abc.com0","Name":"N0","TenantMemberID":"TMID0","RoleID":"RID0","FieldID":"FID0","FormTemplateID":"FTID0","FormTemplateName":"FTN0","FormTemplateFieldID":"FTFID0"}';
  const _addressBookItem2Json =
      '{"EmailLower":"123@abc.com1","Name":"N1","TenantMemberID":"TMID1","RoleID":"RID1","FieldID":"FID1","FormTemplateID":"FTID1","FormTemplateName":"FTN1","FormTemplateFieldID":"FTFID1"}';

  group('AddressBook tests', () {
    const _addressBookJson = '[$_addressBookItem1Json,$_addressBookItem2Json]';

    test('Serialization test', () {
      final ab = AddressBook.fromJson(_addressBookJson);
      const itemCount = 2;
      expect(ab.items.length, itemCount);
      for (var i = 0; i < itemCount; ++i) {
        final abItem = ab.items[i];
        final iAsString = i.toString();

        expect(abItem.emailLower, endsWith(iAsString));
        expect(abItem.tenantMemberID, endsWith(iAsString));
        expect(abItem.roleID, endsWith(iAsString));
        expect(abItem.fieldID, endsWith(iAsString));
        expect(abItem.formTemplateID, endsWith(iAsString));
        expect(abItem.formTemplateName, endsWith(iAsString));
        expect(abItem.formTemplateFieldID, endsWith(iAsString));
      }
    });

    test('get method test', () async {
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
        expect(ab.items.length, greaterThan(0));
      };

      var opResult = await createMockHttpClientScopeForGetRequest(
        callback: () => makeHttpCall(includeTenantMembers: true, includeRoles: false),
        responseBody: _addressBookJson.split(''),
      );

      expect(opResult.requestUri.query, matches(r'\bincludeTenantMembers=true\b'));
      expect(opResult.requestUri.query, matches(r'\bincludeRoles=false\b'));

      opResult = await createMockHttpClientScopeForGetRequest(
        callback: () =>
            makeHttpCall(includeFields: true, includeFormTemplateFields: false, filter: '123'),
        responseBody: _addressBookJson.split(''),
      );

      expect(opResult.requestUri.query, matches(r'\bincludeFields=true\b'));
      expect(opResult.requestUri.query, matches(r'\bincludeFormTemplateFields=false\b'));
      expect(opResult.requestUri.query, matches(r'\bfilter=123\b'));
    });
  });

  group('AddressBookItem tests', () {
    test('Serialization test', () {
      // Since these methods are boilerplate code, we're not currently interested in evaluating
      // anything other than that they can execute without throwing an exception
      try {
        final ab = AddressBookItem.fromJson(_addressBookItem1Json);
        final json = ab.toJson();
        expect(_addressBookItem1Json, json);
      } catch (e) {
        fail(
            'Boilerplate built_value-generated class methods fromJson/toJson failed the (de)serialization process with error:\r\n$e');
      }
    });
  });
}
