import 'package:test/test.dart';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;

import '../../../src/common.dart';
import '../api_model/document_signature_session.dart';

void main() {
  group('DocumentSignatureSession class tests', () {
    performStandardModelTests<DocumentSignatureSession, api_mod.DocumentSignatureSession>(
      apiModelJson: documentSignatureSessionJson,
      expectedPublicFieldCount: 27,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.id: 'A',
        apiModel.createdOn: '2021-06-21T15:21:18.483838807Z',
        apiModel.modifiedOn: '0001-01-01T00:00:00Z',
        apiModel.createdByUserID: 'B',
        apiModel.createdByUserEmail: 'C',
        apiModel.createdByUserName: 'D',
        apiModel.lastModifiedByUserID: 'E',
        apiModel.lastModifiedByUserEmail: 'F',
        apiModel.lastModifiedByUserName: 'G',
        apiModel.documentID: 'H',
        apiModel.documentRevisionID: 'I',
        apiModel.isActive: true,
        apiModel.isComplete: false,
        apiModel.wasStopped: true,
        apiModel.completedOn: '0001-01-01T00:00:00Z',
        apiModel.isRendered: false,
        apiModel.renderedOn: '0001-01-01T00:00:00Z',
        apiModel.formDesignType: 'J',
        apiModel.useAccessCode: true,
        apiModel.accessCode: 'K',
        apiModel.useCustomSubjectAndBody: false,
        apiModel.customSubject: 'L',
        apiModel.customBody: 'M',
        apiModel.quickDesignPlaceInitials: true,
        apiModel.quickDesignPlaceFullName: false,
        apiModel.quickDesignPlaceEmail: true,
        apiModel.quickDesignPlaceTitle: false,
      },
    );
  });
}
