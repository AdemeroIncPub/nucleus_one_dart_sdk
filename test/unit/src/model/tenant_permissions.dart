import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/tenant_permissions.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/tenant_permissions.dart' as mod;
import 'package:test/test.dart';

const activeTenantPermissionsJson =
    r'{"OrganizationID":"A","OrganizationName":"B","TenantID":"C","TenantName":"D","TenantMemberID":"E","UserID":"F","UserName":"G","UserEmail":"H","Disabled":false,"IsAdmin":true}';

void main() {
  group('AddressBookItem tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTest(api_mod.TenantPermissions apiModel) {
        expect(apiModel.organizationID, 'A');
        expect(apiModel.organizationName, 'B');
        expect(apiModel.tenantID, 'C');
        expect(apiModel.tenantName, 'D');
        expect(apiModel.tenantMemberID, 'E');
        expect(apiModel.userID, 'F');
        expect(apiModel.userName, 'G');
        expect(apiModel.userEmail, 'H');
        expect(apiModel.disabled, false);
        expect(apiModel.isAdmin, true);
      }

      final apiModelOrig =
          api_mod.TenantPermissions.fromJson(jsonDecode(activeTenantPermissionsJson));
      performTest(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = mod.TenantPermissions.fromApiModel(apiModelOrig).toApiModel();
      performTest(apiModelCycled);
    });
  });
}
