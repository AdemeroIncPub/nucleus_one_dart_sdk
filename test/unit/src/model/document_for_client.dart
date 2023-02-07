import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_for_client.dart';

void main() {
  group('DocumentForClient class tests', () {
    performStandardModelTests<DocumentForClient, api_mod.DocumentForClient>(
      apiModelJson: documentForClientJson,
      expectedPublicFieldCount: 25,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.documentID: 'B',
        apiModel.createdOn: '2021-01-06T17:37:32.327396Z',
        apiModel.purgeDate: '0001-01-31T00:00:00Z',
        apiModel.name: 'C',
        apiModel.pageCount: 21,
        apiModel.fileSize: 1234,
        apiModel.thumbnailUrl: 'D',
        apiModel.isSigned: false,
        apiModel.classificationID: 'E',
        apiModel.classificationName: 'F',
        apiModel.previewMetadata: isNotNull,
        apiModel.previewMetadata!.length: 1,
        apiModel.documentApprovalID: 'G',
        apiModel.documentApprovalCreatedOn: '0001-01-01T00:00:00Z',
        apiModel.documentSubscriptionID: 'H',
        apiModel.documentSubscriptionCreatedOn: '0001-01-01T00:00:00Z',
        apiModel.documentSignatureSessionRecipientID: 'I',
        apiModel.documentSignatureSessionID: 'J',
        apiModel.documentSignatureSessionRecipientEmail: 'K',
        apiModel.documentSignatureSessionRecipientFullName: 'L',
        apiModel.documentSignatureSessionRecipientRequestedOn: '0001-01-01T00:00:00Z',
        apiModel.roleName: 'M',
        apiModel.processName: 'N',
        apiModel.processElementName: 'O',
        apiModel.score: 123,
      },
    );

    test('toApiModel method tests', () async {
      await defineN1AppInScope(getStandardN1App(), () {
        expect(
            () => DocumentForClientCollection().toApiModel(),
            throwsA(allOf(
              isUnsupportedError,
              predicate((UnsupportedError e) =>
                  e.message.toString() ==
                  'toApiModel() is not supported for this collection type.'),
            )));
      });
    });
  });
}
