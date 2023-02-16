import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/signature_form_template.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/signature_form_template.dart';

void main() {
  group('SignatureFormTemplate class tests', () {
    performStandardModelTests<SignatureFormTemplate, api_mod.SignatureFormTemplate>(
      apiModelJson: signatureFormTemplateJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.name: 'B',
        apiModel.nameLower: 'C',
        apiModel.createdOn: '2021-06-28T18:27:18.205858Z',
      },
    );

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
    performStandardModelTests<SignatureFormTemplateCollection,
        api_mod.SignatureFormTemplateCollection>(
      apiModelJson: signatureFormTemplateCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
