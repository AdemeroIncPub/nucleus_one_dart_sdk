import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/model/document.dart' as mod;
import 'package:test/test.dart';

const documentJson =
    r'{"UniqueID":"A","DocumentID":"B","CreatedOn":"2021-01-06T17:37:32.327396Z","PurgeDate":"0001-01-31T00:00:00Z","Name":"C","PageCount":21,"FileSize":1234,"ThumbnailUrl":"D","IsSigned":false,"ClassificationID":"E","ClassificationName":"F","PreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentApprovalID":"G","DocumentApprovalCreatedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","DocumentSignatureSessionRecipientID":"I","DocumentSignatureSessionID":"J","DocumentSignatureSessionRecipientEmail":"K","DocumentSignatureSessionRecipientFullName":"L","DocumentSignatureSessionRecipientRequestedOn":"0001-01-01T00:00:00Z","RoleName":"M","ProcessName":"N","ProcessElementName":"O","Score":123}';

void main() {
  group('Document tests', () {
    setUp(() async {
      await NucleusOne.intializeSdk();
    });

    tearDown(() async {
      await NucleusOne.resetSdk();
    });

    test('Serialization test', () {
      void performTests(api_mod.Document apiModel) {
        expect(apiModel.uniqueID, 'A');
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

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = mod.Document.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });
  });
}
