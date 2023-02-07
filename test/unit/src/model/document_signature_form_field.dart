import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_form_field.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_signature_form_field.dart';

void main() {
  group('DocumentSignatureFormField tests', () {
    performStandardModelTests<DocumentSignatureFormField, api_mod.DocumentSignatureFormField>(
      apiModelJson: documentSignatureFormFieldJson,
      expectedPublicFieldCount: 7,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-06-22T17:56:43.765773Z',
        apiModel.type: 'B',
        apiModel.pageIndex: 0,
        apiModel.documentSignatureSessionRecipientID: 'C',
        apiModel.x: 1.23,
        apiModel.y: 2.34,
      },
    );

    test('createNew method test', () {
      for (var i = 0; i < 3; ++i) {
        final id = (i == 0) ? null : ((i == 1) ? '' : 'C');
        final epochBefore = DateTime.now().millisecondsSinceEpoch;
        final n1App = getStandardN1App();

        var m = DocumentSignatureFormField.createNew(
          app: n1App,
          id: id,
          createdOn: 'A',
          type: 'B',
          pageIndex: 0,
          documentSignatureSessionRecipientID: 'C',
          x: 1.23,
          y: 2.34,
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

        expect(m.createdOn, 'A');
        expect(m.type, 'B');
        expect(m.pageIndex, 0);
        expect(m.documentSignatureSessionRecipientID, 'C');
        expect(m.x, 1.23);
        expect(m.y, 2.34);
      }
    });
  });

  group('DocumentSignatureFormFieldCollection class tests', () {
    performStandardModelTests<DocumentSignatureFormFieldCollection,
        api_mod.DocumentSignatureFormFieldCollection>(
      apiModelJson: documentSignatureFormFieldCollectionJson,
      expectedPublicFieldCount: 1,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.items.length: 1,
      },
    );
  });
}
