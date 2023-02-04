import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/address_book.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/address_book.dart';

void main() {
  group('AddressBook & AddressBookItem Tests', () {
    group('AddressBook class tests', () {
      performStandardModelTests<api_mod.AddressBook, AddressBook>(
        apiModelJson: addressBookJson,
        expectedPublicFieldCount: 1,
        fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
          apiModel.items.length: 1,
        },
      );
    });

    group('AddressBookItem class tests', () {
      performStandardModelTests<api_mod.AddressBookItem, AddressBookItem>(
        apiModelJson: addressBookItemJson,
        expectedPublicFieldCount: 8,
        fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
          apiModel.emailLower: '',
          apiModel.name: 'Accounting',
          apiModel.tenantMemberID: '',
          apiModel.roleID: 'bpetMevFgCmg4ex6ghJD',
          apiModel.fieldID: '',
          apiModel.formTemplateID: '',
          apiModel.formTemplateName: '',
          apiModel.formTemplateFieldID: '',
        },
      );
    });
  });
}
