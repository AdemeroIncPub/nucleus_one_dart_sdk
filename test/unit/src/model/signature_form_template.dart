import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/signature_form_template.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/signature_form_template.dart';

void main() {
  group('SignatureFormTemplate class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SignatureFormTemplate), 4);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SignatureFormTemplate apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.name, 'B');
        expect(apiModel.nameLower, 'C');
        expect(apiModel.createdOn, '2021-06-28T18:27:18.205858Z');
      }

      final apiModelOrig =
          api_mod.SignatureFormTemplate.fromJson(jsonDecode(signatureFormTemplateJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SignatureFormTemplate.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('createNew method test', () {
      for (var i = 0; i < 3; ++i) {
        final id = (i == 0) ? null : ((i == 1) ? '' : 'A');
        final epochBefore = DateTime.now().millisecondsSinceEpoch;
        final n1App = getStandardN1App();

        var m = SignatureFormTemplate.createNew(
          app: n1App,
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

  group('SignatureFormTemplateCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SignatureFormTemplateCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SignatureFormTemplateCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.SignatureFormTemplateCollection.fromJson(
          jsonDecode(signatureFormTemplateCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.SignatureFormTemplateCollection apiModelCycled =
            SignatureFormTemplateCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });

  group('SignatureFormTemplateField class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SignatureFormTemplateField), 10);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SignatureFormTemplateField apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.createdOn, '2021-06-28T18:26:57.85540675Z');
        expect(apiModel.type, 'B');
        expect(apiModel.pageIndex, 0);
        expect(apiModel.documentSignatureSessionRecipientID, 'C');
        expect(apiModel.x, 1.23);
        expect(apiModel.y, 4.56);
        expect(apiModel.label, 'C');
        expect(apiModel.widthPercent, 5.67);
        expect(apiModel.sortRank, 6);
      }

      final apiModelOrig =
          api_mod.SignatureFormTemplateField.fromJson(jsonDecode(signatureFormTemplateFieldJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = SignatureFormTemplateField.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('createNew method test', () {
      for (var i = 0; i < 3; ++i) {
        final id = (i == 0) ? null : ((i == 1) ? '' : 'A');
        final epochBefore = DateTime.now().millisecondsSinceEpoch;
        final n1App = getStandardN1App();

        var m = SignatureFormTemplateField.createNew(
          app: n1App,
          id: id,
          createdOn: 'B',
          type: 'C',
          pageIndex: 0,
          documentSignatureSessionRecipientID: 'D',
          x: 1.23,
          y: 2.34,
          label: 'E',
          widthPercent: 3.45,
          sortRank: 4,
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

        expect(m.createdOn, 'B');
        expect(m.type, 'C');
        expect(m.pageIndex, 0);
        expect(m.documentSignatureSessionRecipientID, 'D');
        expect(m.x, 1.23);
        expect(m.y, 2.34);
        expect(m.label, 'E');
        expect(m.widthPercent, 3.45);
        expect(m.sortRank, 4);
      }
    });
  });

  group('SignatureFormTemplateFieldCollection class tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.SignatureFormTemplateFieldCollection), 1);
    });

    test('Serialization test', () async {
      void performTests(api_mod.SignatureFormTemplateFieldCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.SignatureFormTemplateFieldCollection.fromJson(
          jsonDecode(signatureFormTemplateFieldCollectionJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.SignatureFormTemplateFieldCollection apiModelCycled =
            SignatureFormTemplateFieldCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
