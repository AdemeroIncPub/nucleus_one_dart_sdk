import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/common/model.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/assertions.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document.dart';
import '../api_model/document_comments.dart';
import '../api_model/document_events.dart';
import '../api_model/document_results.dart';

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
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => DocumentCollection().getRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                DocumentCollection().getRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });

        // Test with optional arguments
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                DocumentCollection().getRecent(offset: 1, cursor: 'B', singleRecord: true),
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
              expect(x.results.items.length, 1);
            });
      });

      test('getInboxRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => DocumentCollection().getInboxRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'inbox=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                DocumentCollection().getInboxRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'inbox=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });
      });

      test('getDocumentSubscriptionsRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => DocumentCollection().getDocumentSubscriptionsRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'documentSubscriptions=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => DocumentCollection()
                .getDocumentSubscriptionsRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'documentSubscriptions=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });
      });

      test('getRecycleBinRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () => DocumentCollection().getRecycleBinRecent(),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'recycleBin=true',
              'sortType=CreatedOn',
              'sortDescending=true',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });

        // Test with custom sorting
        await performHttpTest<QueryResult>(
            httpMethod: HttpMethods.GET,
            httpCallCallback: () =>
                DocumentCollection().getRecycleBinRecent(sortType: 'A', sortDescending: false),
            responseBody: documentResultsJson,
            expectedUrlPath: http.apiPaths.documents,
            expectedQueryParams: [
              'recycleBin=true',
              'sortType=A',
              'sortDescending=false',
            ],
            additionalValidationsCallback: (x) {
              expect(x.results.items.length, 1);
            });
      });
    });

    test('getComments method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentsCommentsFormat.replaceFirst('<documentId>', '123');

      // Test with default parameters
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection().getComments(documentId: '123'),
          responseBody: documentCommentsJson,
          expectedUrlPath: expectedUrlPath,
          expectedQueryParams: ['sortDescending=true'],
          additionalValidationsCallback: (x) {
            expect(x.results.items.length, 1);
          });

      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            DocumentCollection().getComments(documentId: '123', sortDescending: false, cursor: 'A'),
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
        httpCallCallback: () => DocumentCollection().postComments(
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
        httpCallCallback: () => DocumentCollection().postComments(
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
        httpCallCallback: () => DocumentCollection().getEvents(documentId: '123'),
        responseBody: documentEventsJson,
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            DocumentCollection().getEvents(documentId: '123', sortDescending: false, cursor: 'A'),
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
                httpCallCallback: () => DocumentCollection().restoreFromRecycleBin([]),
                responseBody: '',
                expectedUrlPath: expectedUrlPath,
                expectedQueryParams: [],
                expectedBody: '',
              ),
          'documentIds');

      // Test with document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => DocumentCollection().restoreFromRecycleBin(['A', 'B']),
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
                httpCallCallback: () => DocumentCollection().sendToRecycleBin([]),
                responseBody: '',
                expectedUrlPath: expectedUrlPath,
                expectedQueryParams: [],
                expectedBody: '',
              ),
          'documentIds');

      // Test with some document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => DocumentCollection().sendToRecycleBin(['A', 'B']),
        responseBody: '',
        expectedUrlPath: expectedUrlPath,
        expectedQueryParams: [],
        expectedBody: '{"IDs":["A","B"]}',
      );
    });
  });
}
