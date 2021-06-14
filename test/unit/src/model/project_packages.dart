import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/project_packages.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/project_packages.dart';

void main() {
  group('ProjectPackageCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.ProjectPackageCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig =
          api_mod.ProjectPackageCollection.fromJson(jsonDecode(projectPackageCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.ProjectPackageCollection apiModelCycled =
          ProjectPackageCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('ProjectPackage class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTest(api_mod.ProjectPackage apiModel) {
        expect(apiModel.tenant, isA<api_mod.Project>());
        expect(apiModel.tenantMember, isA<api_mod.ProjectMember>());
        expect(apiModel.isAdmin, isTrue);
      }

      final apiModelOrig = api_mod.ProjectPackage.fromJson(jsonDecode(projectPackageJson));
      performTest(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = ProjectPackage.fromApiModel(apiModelOrig).toApiModel();
      performTest(apiModelCycled);
    });
  });
}
