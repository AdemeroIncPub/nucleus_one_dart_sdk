import 'package:collection/collection.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session_recipient.dart'
    as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session_recipient.dart';

void main() {
  group('DocumentSignatureSessionRecipient class tests', () {
    Function deepEq = const DeepCollectionEquality().equals;

    performStandardModelTests<DocumentSignatureSessionRecipient,
        api_mod.DocumentSignatureSessionRecipient>(
      apiModelJson: documentSignatureSessionRecipientJson,
      expectedPublicFieldCount: 29,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.tenantID: 'B',
        apiModel.documentID: 'C',
        apiModel.documentCreatedOn: '2021-06-21T13:51:14.231757Z',
        apiModel.documentBucketName: 'D',
        apiModel.documentThumbnailObjectName: 'E',
        apiModel.documentName: 'F',
        apiModel.documentNameLower: 'G',
        apiModel.documentPageCount: 0,
        apiModel.documentFileSize: 1,
        apiModel.documentClassificationID: 'H',
        apiModel.documentClassificationName: 'I',
        apiModel.documentClassificationNameLower: 'J',
        deepEq(apiModel.documentPreviewMetadata, [
          <String, String>{'K': 'L'}
        ]): true,
        apiModel.documentSignatureSessionID: 'M',
        apiModel.documentSignatureSessionIsActive: true,
        apiModel.documentSignatureSessionIsComplete: false,
        apiModel.uniqueID: 'N',
        apiModel.rank: 2,
        apiModel.email: 'O',
        apiModel.fullName: 'P',
        apiModel.type: 'Q',
        apiModel.tenantMemberID: 'R',
        apiModel.signingRequestSent: true,
        apiModel.requestedOn: '0001-01-01T00:00:00Z',
        apiModel.isActive: false,
        apiModel.isComplete: true,
        apiModel.completedOn: '0002-01-01T00:00:00Z',
        apiModel.ipAddress: 'S',
      },
    );
  });
}
