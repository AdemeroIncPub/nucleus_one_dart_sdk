import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_content_package.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/document_content_package.dart';

void main() {
  group('DocumentContentPackage tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentContentPackage apiModel) {
        expect(apiModel.url, 'https://a.b.c/d');
        expect(apiModel.contentType, 'A');
        expect(apiModel.name, 'B');
        expect(apiModel.pageIndex, 0);
        expect(apiModel.pageCount, 1);
      }

      final apiModelOrig =
          api_mod.DocumentContentPackage.fromJson(jsonDecode(documentContentPackageJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentContentPackage.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
