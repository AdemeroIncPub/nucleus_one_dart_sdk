import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/classification.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/api_model/query_result.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:test/test.dart';

import '../api_model/classification.dart';

void main() {
  group('Classification class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Classification apiModel) {
        expect(apiModel.createdOn, '2020-09-03T20:03:35.964878Z');
        expect(apiModel.id, 'B');
        expect(apiModel.name, 'C');
        expect(apiModel.nameLower, 'D');
        expect(apiModel.isActive, true);
      }

      final apiModelOrig = api_mod.Classification.fromJson(jsonDecode(classificationJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Classification.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('ClassificationCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.QueryResult<api_mod.ClassificationCollection> apiModel) {
        expect(apiModel.results!.classifications!.length, 1);
      }

      final apiModelOrig = api_mod.QueryResult<api_mod.ClassificationCollection>.fromJson(
          jsonDecode(classificationCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.QueryResult<api_mod.ClassificationCollection> apiModelCycled =
          ClassificationCollectionQueryResult.fromApiModelClassificationCollection(apiModelOrig)
              .toApiModel<api_mod.ClassificationCollection>();
      performTests(apiModelCycled);
    });
  });

  group('ClassificationFieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.ClassificationFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.ClassificationFieldCollection.fromJson(
          jsonDecode(classificationFieldCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = ClassificationFieldCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('ClassificationField class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.ClassificationField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.classificationID, 'B');
        expect(apiModel.classificationName, 'C');
        expect(apiModel.fieldID, 'D');
        expect(apiModel.fieldName, 'E');
        expect(apiModel.fieldNameLower, 'F');
        expect(apiModel.rank, 0.1);
        expect(apiModel.mapped, true);
      }

      final apiModelOrig =
          api_mod.ClassificationField.fromJson(jsonDecode(classificationFieldJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = ClassificationField.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
