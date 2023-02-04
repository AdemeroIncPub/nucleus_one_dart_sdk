import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_signature_session.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_signature_session.dart';

void main() {
  group('DocumentSignatureSession class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSession, DocumentSignatureSession>(
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

  group('DocumentSignatureSessionRecipient class tests', () {
    Function deepEq = const DeepCollectionEquality().equals;

    // !~!~!
    // DocumentSignatureSession
    // 27
    performStandardModelTests<api_mod.DocumentSignatureSessionRecipient,
        DocumentSignatureSessionRecipient>(
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

  group('DocumentSignatureSessionPackage class tests', () {
    performStandardModelTests<api_mod.DocumentSignatureSessionPackage,
        DocumentSignatureSessionPackage>(
      apiModelJson: documentSignatureSessionPackageJson,
      expectedPublicFieldCount: 4,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.session: isA<api_mod.DocumentSignatureSession>(),
        apiModel.recipients: isA<List<api_mod.DocumentSignatureSessionRecipient>>(),
        apiModel.recipients!.length: 1,
        apiModel.beginSession: true,
        apiModel.resetSession: false,
      },
    );
  });

  group('DocumentSignatureSessionPackageCollection class tests', () {
    // !~!~!
    // DocumentSignatureSessionPackageCollection
    // 1

    test('Serialization test', () async {
      void performTests(api_mod.DocumentSignatureSessionPackageCollection apiModel) {
        expect(apiModel.items.length, 1);
      }

      final apiModelOrig = api_mod.DocumentSignatureSessionPackageCollection.fromJson(
          jsonDecode(documentSignatureSessionPackageCollectionJson));
      performTests(apiModelOrig);

      await defineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final api_mod.DocumentSignatureSessionPackageCollection apiModelCycled =
            DocumentSignatureSessionPackageCollection.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });
  });
}
