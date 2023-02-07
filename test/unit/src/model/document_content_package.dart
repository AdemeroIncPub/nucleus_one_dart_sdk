import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_content_package.dart';

void main() {
  group('DocumentContentPackage tests', () {
    performStandardModelTests<DocumentContentPackage, api_mod.DocumentContentPackage>(
      apiModelJson: documentContentPackageJson,
      expectedPublicFieldCount: 5,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.url: 'https://a.b.c/d',
        apiModel.contentType: 'A',
        apiModel.name: 'B',
        apiModel.pageIndex: 0,
        apiModel.pageCount: 1,
      },
    );
  });
}
