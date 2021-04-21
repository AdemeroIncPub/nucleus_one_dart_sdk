import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_results.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document_results.dart' as mod;
import 'package:test/test.dart';

import 'document.dart';

const documentResultsJson = r'{"Documents":[' + documentJson + r'],"Cursor":"abc","PageSize":24}';

void main() {
  group('DocumentResults class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentResults apiModel) {
        expect(apiModel.documents!.length, 1);
        expect(apiModel.cursor, 'abc');
        expect(apiModel.pageSize, 24);
      }

      final apiModelOrig = api_mod.DocumentResults.fromJson(jsonDecode(documentResultsJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = mod.DocumentResults.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
