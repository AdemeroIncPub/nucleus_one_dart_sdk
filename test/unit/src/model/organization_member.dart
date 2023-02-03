import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/organization_member.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/organization_member.dart';

void main() {
  group('OrganizationMember class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.OrganizationMember), 11);
    });

    test('Serialization test', () async {
      void performTests(api_mod.OrganizationMember apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '0001-01-01T00:00:00Z');
        expect(apiModel.organizationID, 'B');
        expect(apiModel.organizationName, 'C');
        expect(apiModel.userID, 'D');
        expect(apiModel.userName, 'E');
        expect(apiModel.userNameLower, 'F');
        expect(apiModel.userEmail, 'G');
        expect(apiModel.disabled, true);
        expect(apiModel.isReadOnly, false);
        expect(apiModel.isAdmin, true);
      }

      final apiModelOrig = api_mod.OrganizationMember.fromJson(jsonDecode(organizationMemberJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = OrganizationMember.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
