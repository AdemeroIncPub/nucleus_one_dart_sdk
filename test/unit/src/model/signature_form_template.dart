import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/signature_form_template.dart' as api_mod;
import 'package:test/test.dart';

import '../api_model/signature_form_template.dart';

void main() {
  group('SignatureFormTemplate class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.SignatureFormTemplate apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.name, 'B');
        expect(apiModel.nameLower, 'C');
        expect(apiModel.createdOn, '2021-06-28T18:27:18.205858Z');
      }

      final apiModelOrig =
          api_mod.SignatureFormTemplate.fromJson(jsonDecode(signatureFormTemplateJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = SignatureFormTemplate.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });

  group('SignatureFormTemplateCollection class tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.SignatureFormTemplateCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.SignatureFormTemplateCollection.fromJson(
          jsonDecode(signatureFormTemplateCollectionJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final api_mod.SignatureFormTemplateCollection apiModelCycled =
          SignatureFormTemplateCollection.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('createNew method test', () {
      for (var i = 0; i < 3; ++i) {
        final id = (i == 0) ? null : ((i == 1) ? '' : 'A');
        final epochBefore = DateTime.now().millisecondsSinceEpoch;

        var m = SignatureFormTemplate.createNew(
          id: id,
          name: 'B',
          createdOn: 'C',
        );

        // If the id was not provided, ensure that it was correctly defaulted
        if (i < 2) {
          final epochAfter = DateTime.now().millisecondsSinceEpoch;
          final idAsInt = int.parse(m.id);
          expect(idAsInt >= epochBefore, isTrue);
          expect(idAsInt <= epochAfter, isTrue);
        } else {
          expect(m.id, id);
        }

        expect(m.name, 'B');
        expect(m.nameLower, 'b');
        expect(m.createdOn, 'C');
      }
    });
  });
}
