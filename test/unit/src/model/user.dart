import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/user_profile.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/http.dart';

import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/address_book.dart';
import '../api_model/user_profile.dart';

void main() {
  group('User class tests', () {
    test('getAddressBook method test', () async {
      await defineN1AppInScopeAsync(getStandardN1App(), () async {
        // Test with default parameters
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () => getStandardTestUser().getAddressBook(),
          responseBody: addressBookJson,
          expectedRequestUrlPath: ApiPaths.userAddressBookItems,
          expectedRequestQueryParams: [
            'includeTenantMembers=true',
            'includeRoles=true',
            'includeFields=true',
            'includeFormTemplateFields=true',
          ],
          additionalValidationsCallback: (x) {
            expect(x.items.length, 1);
          },
        );
      });

      await defineN1AppInScopeAsync(getStandardN1App(), () async {
        // The following two tests test that individual parameters are set correct
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () => getStandardTestUser().getAddressBook(
            includeTenantMembers: true,
            includeRoles: false,
          ),
          responseBody: addressBookJson,
          expectedRequestUrlPath: ApiPaths.userAddressBookItems,
          expectedRequestQueryParams: [
            'includeTenantMembers=true',
            'includeRoles=false',
            'includeFields=true',
            'includeFormTemplateFields=true',
          ],
          additionalValidationsCallback: (x) {
            expect(x.items.length, 1);
          },
        );
      });

      await defineN1AppInScopeAsync(getStandardN1App(), () async {
        // Test with three of the parameters set
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () => getStandardTestUser().getAddressBook(
            includeFields: true,
            includeFormTemplateFields: false,
            filter: '123',
          ),
          responseBody: addressBookJson,
          expectedRequestUrlPath: ApiPaths.userAddressBookItems,
          expectedRequestQueryParams: [
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
    });

    test('clearAddressBook method test', () async {
      await performHttpTest(
        httpMethod: HttpMethods.delete,
        httpCallCallback: () => getStandardTestUser().clearAddressBook(),
        responseBody: '',
        expectedRequestUrlPath: ApiPaths.userAddressBookItems,
        expectedRequestQueryParams: [],
      );
    });

    test('getProfile method test', () async {
      await defineN1AppInScopeAsync(getStandardN1App(), () async {
        await performHttpTest<UserProfile>(
          httpMethod: HttpMethods.get,
          httpCallCallback: () => getStandardTestUser().getProfile(),
          responseBody: userProfileJson,
          expectedRequestUrlPath: ApiPaths.userProfile,
          expectedRequestQueryParams: [],
        );
      });
    });

    test('updateProfile method test', () async {
      final up = api_mod.UserProfile()
        ..userProvider = 'A'
        ..userEmail = 'B'
        ..userName = 'C'
        ..otpsmsNumber = 'D';

      await defineN1AppInScopeAsync(getStandardN1App(), () async {
        await performHttpTest(
          httpMethod: HttpMethods.put,
          httpCallCallback: () => getStandardTestUser().updateProfile(UserProfile.fromApiModel(up)),
          responseBody: '',
          expectedRequestUrlPath: ApiPaths.userProfile,
          expectedRequestQueryParams: [],
          expectedRequestBody:
              '{"UserProvider":"A","UserEmail":"B","UserName":"C","OTPSMSNumber":"D"}',
        );
      });
    });
  });
}
