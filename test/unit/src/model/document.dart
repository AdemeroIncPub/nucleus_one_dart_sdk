import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:test/test.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;

import '../../../src/assertions.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import 'document_comments.dart';
import 'document_events.dart';
import 'document_results.dart';

const documentJson =
    r'{"ID":"A","DocumentID":"B","CreatedOn":"2021-01-06T17:37:32.327396Z","PurgeDate":"0001-01-31T00:00:00Z","Name":"C","PageCount":21,"FileSize":1234,"ThumbnailUrl":"D","IsSigned":false,"ClassificationID":"E","ClassificationName":"F","PreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentApprovalID":"G","DocumentApprovalCreatedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","DocumentSignatureSessionRecipientID":"I","DocumentSignatureSessionID":"J","DocumentSignatureSessionRecipientEmail":"K","DocumentSignatureSessionRecipientFullName":"L","DocumentSignatureSessionRecipientRequestedOn":"0001-01-01T00:00:00Z","RoleName":"M","ProcessName":"N","ProcessElementName":"O","Score":123}';

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

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Document.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    group('_getRecentInternal method consumers tests', () {
      test('getRecent method test', () async {
        // Test with default parameters
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });

        // Test with optional arguments
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                Document().getRecent(offset: 1, cursor: 'B', singleRecord: true),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'sortType=CreatedOn',
              'sortDescending=true',
              'offset=1',
              'cursor=B',
              'singleRecord=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });
      });

      test('getInboxRecent method test', () async {
        // Test with default parameters
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getInboxRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'inbox=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getInboxRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'inbox=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });
      });

      test('getDocumentSubscriptionsRecent method test', () async {
        // Test with default parameters
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getDocumentSubscriptionsRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'documentSubscriptions=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                Document().getDocumentSubscriptionsRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'documentSubscriptions=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });
      });

      test('getRecycleBinRecent method test', () async {
        // Test with default parameters
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => Document().getRecycleBinRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'recycleBin=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<DocumentResults>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                Document().getRecycleBinRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'recycleBin=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.documents.length, 1);
            });
      });
    });

    test('getComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');

      // Test with default parameters
      await performHttpTest<DocumentComments>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => Document().getComments(documentId: '123'),
          responseBody: documentCommentsJson,
          expectedUrlPath: expectedUrlPath,
          expectedQueryParams: ['sortDescending=true'],
          additionalValidationsCallback: (x) {
            expect(x.documentEvents.length, 1);
          });

      // Test with custom sorting and optional arguments
      await performHttpTest<DocumentComments>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            Document().getComments(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentCommentsJson,
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('postComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');

      // Test with no comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => Document().postComments(
          documentId: '123',
          comments: [],
        ),
        responseBody: '',
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
        expectedBody: '{"Comments":[]}',
      );

      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => Document().postComments(
          documentId: '123',
          comments: ['A', 'B'],
        ),
        responseBody: '',
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
        expectedBody: '{"Comments":["A","B"]}',
      );
    });

    test('getEvents method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsEventsFormat.replaceFirst('<documentId>', '123');

      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => Document().getEvents(documentId: '123'),
        responseBody: documentEventsJson,
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            Document().getEvents(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentEventsJson,
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: ['sortDescending=false', 'cursor=A'],
      );
    });

    test('restoreFromRecycleBin method tests', () async {
      final expectedUrlPath = http.apiPaths.documentActionsRestoreFromRecycleBin;

      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => Document().restoreFromRecycleBin([]),
                responseBody: '',
                expectedUrlPath: expectedUrlPath,
                expectedQueryParams: [],
                expectedBody: '',
              ),
          'documentIds');

      // Test with document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => Document().restoreFromRecycleBin(['A', 'B']),
        responseBody: '',
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
        expectedBody: '{"IDs":["A","B"]}',
      );
    });

    test('sendToRecycleBin method tests', () async {
      final expectedUrlPath = http.apiPaths.documentActionsSendToRecycleBin;

      // Test with no document ids
      testAssertionErrorAsync(
          () async => await performHttpTest(
                httpMethod: HttpMethods.POST,
                httpCallCallback: () => Document().sendToRecycleBin([]),
                responseBody: '',
                expectedUrlPath: expectedUrlPath,
                expectedQueryParams: [],
                expectedBody: '',
              ),
          'documentIds');

      // Test with some document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => Document().sendToRecycleBin(['A', 'B']),
        responseBody: '',
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
        expectedBody: '{"IDs":["A","B"]}',
      );
    });
  });
}
