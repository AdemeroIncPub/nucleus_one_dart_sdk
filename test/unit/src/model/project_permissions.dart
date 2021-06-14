import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project_permissions.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/project_permissions.dart';

void main() {
  group('ProjectPermissions class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTest(api_mod.ProjectPermissions apiModel) {
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
        expect(apiModel.isReadOnly, false);
      }

      final apiModelOrig =
          api_mod.ProjectPermissions.fromJson(jsonDecode(activeProjectPermissionsJson));
      performTest(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = ProjectPermissions.fromApiModel(apiModelOrig).toApiModel();
      performTest(apiModelCycled);
    });
  });
}
