import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_field.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/model/document_field.dart';
import 'package:test/test.dart';

import '../api_model/document_field.dart';

void main() {
  group('DocumentField tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.DocumentField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.fieldID, 'B');
        expect(apiModel.documentID, 'C');
        expect(apiModel.classificationID, 'D');
        expect(apiModel.value, 'E');
        expect(apiModel.uniqueTextValue, 'F');
        expect(apiModel.uniqueFirst1, 'G');
        expect(apiModel.uniqueFirst2, 'H');
        expect(apiModel.uniqueFirst3, 'I');
        expect(apiModel.uniqueFloatValue, 0.1);
        expect(apiModel.uniqueTimeValue, '2021-02-09T05:23:35.496635Z');
        expect(apiModel.uniqueYear, 'J');
        expect(apiModel.uniqueYearMonth, 'K');
      }

      final apiModelOrig = api_mod.DocumentField.fromJson(jsonDecode(documentFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = DocumentField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('DocumentFieldCollection tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.DocumentFieldCollection> apiModel) {
        expect(apiModel.results!.documentFields!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.DocumentFieldCollection>.fromJson(
          jsonDecode(documentFieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.DocumentFieldCollection> apiModelCycled =
          DocumentFieldCollectionQueryResult.fromApiModelFieldCollection(apiModelOrig)
              .toApiModel<api_mod.DocumentFieldCollection>();
      performTests(apiModelCycled);
    });
  });
}
