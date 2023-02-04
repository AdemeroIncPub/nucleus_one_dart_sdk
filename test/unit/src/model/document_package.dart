import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/approval.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_subscription_for_client.dart'
    as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/document_package_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/project.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_package.dart';

void main() {
  group('DocumentPackage class tests', () {
    performStandardModelTests<api_mod.DocumentPackage, DocumentPackage>(
      apiModelJson: documentPackageJson,
      expectedPublicFieldCount: 6,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.document: isA<api_mod.Document>(),
        apiModel.documentSubscription: isA<api_mod.DocumentSubscriptionForClient>(),
        apiModel.approval: isA<api_mod.Approval>(),
        apiModel.projectMember: isA<api_mod.ProjectMember>(),
        apiModel.projectAccessType: 'A',
        apiModel.fields: isA<List<api_mod.DocumentPackageField>>(),
      },
    );
  });
}
