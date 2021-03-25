import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

const addressBookItem1Json =
    r'{"EmailLower":"","Name":"Accounting","TenantMemberID":"","RoleID":"bpetMevFgCmg4ex6ghJD","FieldID":"","FormTemplateID":"","FormTemplateName":"","FormTemplateFieldID":""}';
const addressBookItem2Json =
    r'{"EmailLower":"asdf@ademero.com","Name":"Steve Miller","TenantMemberID":"TqBCvQeNo503gZ5MaWaW","RoleID":"","FieldID":"zR4rlZyX1Gtiv9F5rUjS","FormTemplateID":"PwqBebs6OemnMSvEIp1g","FormTemplateName":"Dev Only","FormTemplateFieldID":"6nWGcZNS7Nl0w4uLBpZu"}';
const addressBookJson = '[$addressBookItem1Json,$addressBookItem2Json]';

void main() {
  group('AddressBook class tests', () {
    test('Serialization test', () {
      final ab = AddressBook.fromJson(addressBookJson);
      expect(ab.items.length, 2);
    });
  });

  group('AddressBookItem tests', () {
    test('Serialization test', () {
      try {
        var abi = AddressBookItem.fromJson(jsonDecode(addressBookItem1Json));

        expect(abi.emailLower, '');
        expect(abi.name, 'Accounting');
        expect(abi.tenantMemberID, '');
        expect(abi.roleID, 'bpetMevFgCmg4ex6ghJD');
        expect(abi.fieldID, '');
        expect(abi.formTemplateID, '');
        expect(abi.formTemplateName, '');
        expect(abi.formTemplateFieldID, '');

        var jsonMap = abi.toJson();
        expect(addressBookItem1Json, jsonEncode(jsonMap));

        abi = AddressBookItem.fromJson(jsonDecode(addressBookItem2Json));

        expect(abi.emailLower, 'asdf@ademero.com');
        expect(abi.name, 'Steve Miller');
        expect(abi.tenantMemberID, 'TqBCvQeNo503gZ5MaWaW');
        expect(abi.roleID, '');
        expect(abi.fieldID, 'zR4rlZyX1Gtiv9F5rUjS');
        expect(abi.formTemplateID, 'PwqBebs6OemnMSvEIp1g');
        expect(abi.formTemplateName, 'Dev Only');
        expect(abi.formTemplateFieldID, '6nWGcZNS7Nl0w4uLBpZu');

        jsonMap = abi.toJson();
        expect(addressBookItem2Json, jsonEncode(jsonMap));
      } catch (e) {
        fail(
            'Boilerplate class methods fromJson/toJson for json_serializable failed the (de)serialization process with the following error.\r\n$e');
      }
    });
  });
}
