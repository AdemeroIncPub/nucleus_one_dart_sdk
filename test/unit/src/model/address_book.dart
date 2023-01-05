import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/address_book.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/address_book.dart';

void main() {
  group('AddressBook & AddressBookItem Tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    group('AddressBook class tests', () {
      test('Expected class field count test', () {
        expect(getClassPublicFieldCount(api_mod.AddressBook), 1);
      });

      test('Serialization test', () async {
        final apiModelOrig = api_mod.AddressBook.fromJson(jsonDecode(addressBookJson));
        expect(apiModelOrig.items.length, 1);

        final n1App = getStandardN1App();
        await defineN1AppInScope(n1App, () {
          // Convert it to a model class then back again
          final apiModelCycled = AddressBook.fromApiModel(apiModelOrig).toApiModel();
          expect(apiModelCycled.items.length, 1);
        });
      });
    });

    group('AddressBookItem tests', () {
      test('Expected class field count test', () {
        expect(getClassPublicFieldCount(api_mod.AddressBookItem), 8);
      });

      test('Serialization test', () async {
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

        final n1App = getStandardN1App();
        await defineN1AppInScope(n1App, () {
          // Convert it to a model class then back again
          final apiModelCycled = AddressBookItem.fromApiModel(apiModelOrig).toApiModel();
          performTest(apiModelCycled);
        });
      });
    });
  });
}
