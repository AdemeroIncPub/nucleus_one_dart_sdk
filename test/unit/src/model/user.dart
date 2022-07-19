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
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('getAddressBook method test', () async {
      await DefineN1AppInScopeAsync(getStandardN1App(), () async {
        // Test with default parameters
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => getStandardTestUser().getAddressBook(),
          responseBody: addressBookJson,
          expectedRequestUrlPath: apiPaths.userAddressBookItems,
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

      await DefineN1AppInScopeAsync(getStandardN1App(), () async {
        // The following two tests test that individual parameters are set correct
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => getStandardTestUser().getAddressBook(
            includeTenantMembers: true,
            includeRoles: false,
          ),
          responseBody: addressBookJson,
          expectedRequestUrlPath: apiPaths.userAddressBookItems,
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

      await DefineN1AppInScopeAsync(getStandardN1App(), () async {
        // Test with three of the parameters set
        await performHttpTest<AddressBook>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => getStandardTestUser().getAddressBook(
            includeFields: true,
            includeFormTemplateFields: false,
            filter: '123',
          ),
          responseBody: addressBookJson,
          expectedRequestUrlPath: apiPaths.userAddressBookItems,
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
        httpMethod: HttpMethods.DELETE,
        httpCallCallback: () => getStandardTestUser().clearAddressBook(),
        responseBody: '',
        expectedRequestUrlPath: apiPaths.userAddressBookItems,
        expectedRequestQueryParams: [],
      );
    });

    test('getProfile method test', () async {
      await DefineN1AppInScopeAsync(getStandardN1App(), () async {
        await performHttpTest<UserProfile>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => getStandardTestUser().getProfile(),
          responseBody: userProfileJson,
          expectedRequestUrlPath: apiPaths.userProfile,
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

      await DefineN1AppInScopeAsync(getStandardN1App(), () async {
        await performHttpTest(
          httpMethod: HttpMethods.PUT,
          httpCallCallback: () => getStandardTestUser().updateProfile(UserProfile.fromApiModel(up)),
          responseBody: '',
          expectedRequestUrlPath: apiPaths.userProfile,
          expectedRequestQueryParams: [],
          expectedRequestBody:
              '{"UserProvider":"A","UserEmail":"B","UserName":"C","OTPSMSNumber":"D"}',
        );
      });
    });
  });
}
