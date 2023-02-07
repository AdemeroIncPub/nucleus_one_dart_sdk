import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/project_packages.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/project_packages.dart';

void main() {
  group('ProjectPackageCollection class tests', () {
    performStandardModelTests<ProjectPackageCollection, api_mod.ProjectPackageCollection>(
      apiModelJson: projectPackageCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });

  group('ProjectPackage class tests', () {
    performStandardModelTests<ProjectPackage, api_mod.ProjectPackage>(
      apiModelJson: projectPackageJson,
      expectedPublicFieldCount: 3,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.tenant: isA<api_mod.Project>(),
        apiModel.tenantMember: isA<api_mod.ProjectMember>(),
        apiModel.isAdmin: isTrue,
      },
    );
  });
}
