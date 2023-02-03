import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription_for_client.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_package.dart';

void main() {
  group('DocumentPackage class tests', () {
    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentPackage), 6);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentPackage apiModel) {
        expect(apiModel.document, isA<api_mod.Document>());
        expect(apiModel.documentSubscription, isA<api_mod.DocumentSubscriptionForClient>());
        expect(apiModel.approval, isA<api_mod.Approval>());
        expect(apiModel.projectMember, isA<api_mod.ProjectMember>());
        expect(apiModel.projectAccessType, 'A');
        expect(apiModel.fields, isA<List<api_mod.DocumentPackageField>>());
      }

      final apiModelOrig = api_mod.DocumentPackage.fromJson(jsonDecode(documentPackageJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentPackage.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
