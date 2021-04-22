import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/address_book.dart' as api_mod;
import 'package:test/test.dart';

const addressBookItemJson =
    r'{"EmailLower":"","Name":"Accounting","TenantMemberID":"","RoleID":"bpetMevFgCmg4ex6ghJD","FieldID":"","FormTemplateID":"","FormTemplateName":"","FormTemplateFieldID":""}';
const addressBookJson = '[$addressBookItemJson]';

void main() {
  group('AddressBook & AddressBookItem Tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    group('AddressBook class tests', () {
      test('Serialization test', () {
        final apiModelOrig = api_mod.AddressBook.fromJson(jsonDecode(addressBookJson));
        expect(apiModelOrig.items.length, 1);

        // Convert it to a model class then back again
        final apiModelCycled = AddressBook.fromApiModel(apiModelOrig).toApiModel();
        expect(apiModelCycled.items.length, 1);
      });
    });

    group('AddressBookItem tests', () {
      test('Serialization test', () {
        void performTest(api_mod.AddressBookItem apiModel) {
          expect(apiModel.emailLower, '');
          expect(apiModel.name, 'Accounting');
          expect(apiModel.tenantMemberID, '');
          expect(apiModel.roleID, 'bpetMevFgCmg4ex6ghJD');
          expect(apiModel.fieldID, '');
          expect(apiModel.formTemplateID, '');
          expect(apiModel.formTemplateName, '');
          expect(apiModel.formTemplateFieldID, '');
        }

        final apiModelOrig = api_mod.AddressBookItem.fromJson(jsonDecode(addressBookItemJson));
        performTest(apiModelOrig);

        // Convert it to a model class then back again
        final apiModelCycled = AddressBookItem.fromApiModel(apiModelOrig).toApiModel();
        performTest(apiModelCycled);
      });
    });
  });
}
