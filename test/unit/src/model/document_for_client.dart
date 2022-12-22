import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_for_client.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/util.dart';
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../../../src/mirrors.dart';
import '../api_model/document_for_client.dart';

void main() {
  group('DocumentForClient tests', () {
    setUp(() async {
      await NucleusOne.initializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Expected class field count test', () {
      expect(getClassPublicFieldCount(api_mod.DocumentForClient), 25);
    });

    test('Serialization test', () async {
      void performTests(api_mod.DocumentForClient apiModel) {
        expect(apiModel.id, 'A');
        expect(apiModel.documentID, 'B');
        expect(apiModel.createdOn, '2021-01-06T17:37:32.327396Z');
        expect(apiModel.purgeDate, '0001-01-31T00:00:00Z');
        expect(apiModel.name, 'C');
        expect(apiModel.pageCount, 21);
        expect(apiModel.fileSize, 1234);
        expect(apiModel.thumbnailUrl, 'D');
        expect(apiModel.isSigned, false);
        expect(apiModel.classificationID, 'E');
        expect(apiModel.classificationName, 'F');
        expect(apiModel.previewMetadata, isNotNull);
        expect(apiModel.previewMetadata!.length, 1);
        expect(apiModel.documentApprovalID, 'G');
        expect(apiModel.documentApprovalCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentSubscriptionID, 'H');
        expect(apiModel.documentSubscriptionCreatedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.documentSignatureSessionRecipientID, 'I');
        expect(apiModel.documentSignatureSessionID, 'J');
        expect(apiModel.documentSignatureSessionRecipientEmail, 'K');
        expect(apiModel.documentSignatureSessionRecipientFullName, 'L');
        expect(apiModel.documentSignatureSessionRecipientRequestedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.roleName, 'M');
        expect(apiModel.processName, 'N');
        expect(apiModel.processElementName, 'O');
        expect(apiModel.score, 123);
      }

      final apiModelOrig = api_mod.DocumentForClient.fromJson(jsonDecode(documentForClientJson));
      performTests(apiModelOrig);

      await DefineN1AppInScope(getStandardN1App(), () {
        // Convert it to a model class then back again
        final apiModelCycled = DocumentForClient.fromApiModel(apiModelOrig).toApiModel();
        performTests(apiModelCycled);
      });
    });

    test('toApiModel method tests', () async {
      await DefineN1AppInScope(getStandardN1App(), () {
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
