import 'dart:convert';

import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document.dart' as api_mod;
import 'package:nucleus_one_dart_sdk/src/hierarchy/nucleus_one_app_documents.dart';
import 'package:nucleus_one_dart_sdk/src/http.dart' as http;
import 'package:test/test.dart';

import '../../../src/assertions.dart';
import '../../../src/common.dart';
import '../../../src/mocks/http.dart';
import '../../../src/model_helper.dart';
import '../api_model/document.dart';
import '../api_model/document_comments.dart';
import '../api_model/document_content_package.dart';
import '../api_model/document_event.dart';
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
        expect(apiModel.createdByUserID, 'P');
        expect(apiModel.createdByUserEmail, 'Q');
        expect(apiModel.createdByUserName, 'R');
        expect(apiModel.nameLower, 'S');
        expect(apiModel.origin, 'T');
        expect(apiModel.isActive, false);
        expect(apiModel.isClassified, false);
        expect(apiModel.isMarkedForPurge, false);
        expect(apiModel.signatureSessionIsActive, false);
        expect(apiModel.hasSinglePageImages, false);
        expect(apiModel.signaturesCompletedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.purgeMarkedOn, '0001-01-01T00:00:00Z');
        expect(apiModel.failedBuildAttempts, false);
        expect(apiModel.lastError, 'U');
        expect(apiModel.bucketName, 'V');
        expect(apiModel.sourceObjectName, 'W');
        expect(apiModel.thumbnailObjectName, 'X');
        expect(apiModel.classificationNameLower, 'Y');
      }

      final apiModelOrig = api_mod.Document.fromJson(jsonDecode(documentJson));
      performTests(apiModelOrig);

      // Convert it to a model class then back again
      final apiModelCycled = Document.fromApiModel(apiModelOrig).toApiModel();
      performTests(apiModelCycled);
    });

    test('toApiModel method tests', () async {
      expect(
          () => DocumentCollection().toApiModel(),
          throwsA(allOf(
            isUnsupportedError,
            predicate((UnsupportedError e) =>
                e.message.toString() == 'toApiModel() is not supported for this collection type.'),
          )));
    });

    test('getCount method tests', () async {
      final n1App = getStandardN1App();
      await performHttpTest<int>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => NucleusOneAppDocuments(app: n1App).getDocumentCount(true, false),
        responseBody: '1',
        expectedRequestUrlPath: http.apiPaths.documentCounts,
        expectedRequestQueryParams: [
          'ignoreInbox=true',
          'ignoreRecycleBin=false',
        ],
        additionalValidationsCallback: (x) {
          expect(x, 1);
        },
      );
    });

    group('_getRecentInternal method consumers tests', () {
      test('getRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection().getRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              DocumentCollection().getRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=A',
            'sortDescending=false',
          ],
        );

        // Test with optional arguments
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              DocumentCollection().getRecent(offset: 1, cursor: 'B', singleRecord: true),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'sortType=CreatedOn',
            'sortDescending=true',
            'offset=1',
            'cursor=B',
            'singleRecord=true',
          ],
        );
      });

      test('getInboxRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection().getInboxRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'inbox=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              DocumentCollection().getInboxRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'inbox=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
      });

      test('getDocumentSubscriptionsRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection().getDocumentSubscriptionsRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'documentSubscriptions=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection()
              .getDocumentSubscriptionsRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'documentSubscriptions=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
      });

      test('getRecycleBinRecent method test', () async {
        // Test with default parameters
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () => DocumentCollection().getRecycleBinRecent(),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'recycleBin=true',
            'sortType=CreatedOn',
            'sortDescending=true',
          ],
        );

        // Test with custom sorting
        await performHttpTest<QueryResult>(
          httpMethod: HttpMethods.GET,
          httpCallCallback: () =>
              DocumentCollection().getRecycleBinRecent(sortType: 'A', sortDescending: false),
          responseBody: documentResultsJson,
          expectedRequestUrlPath: http.apiPaths.documents,
          expectedRequestQueryParams: [
            'recycleBin=true',
            'sortType=A',
            'sortDescending=false',
          ],
        );
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
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest<QueryResult2<DocumentCommentCollection>>(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            DocumentCollection().getComments(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentCommentsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
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
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":[]}',
      );

      // Test with some comments
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => DocumentCollection().postComments(
          documentId: '123',
          comments: ['A', 'B'],
        ),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"Comments":["A","B"]}',
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
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=true'],
      );

      // Test with custom sorting and optional arguments
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () =>
            DocumentCollection().getEvents(documentId: '123', sortDescending: false, cursor: 'A'),
        responseBody: documentEventsJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: ['sortDescending=false', 'cursor=A'],
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
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      // Test with document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => DocumentCollection().restoreFromRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
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
                expectedRequestUrlPath: expectedUrlPath,
                expectedRequestQueryParams: [],
                expectedRequestBody: '',
              ),
          'documentIds');

      // Test with some document ids
      await performHttpTest(
        httpMethod: HttpMethods.POST,
        httpCallCallback: () => DocumentCollection().sendToRecycleBin(['A', 'B']),
        responseBody: '',
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [],
        expectedRequestBody: '{"IDs":["A","B"]}',
      );
    });

    test('getDocumentContentPackage method tests', () async {
      final expectedUrlPath =
          http.apiPaths.documentContentPackagesFormat.replaceFirst('<documentId>', '123');

      // Test with default parameters
      await performHttpTest(
        httpMethod: HttpMethods.GET,
        httpCallCallback: () => DocumentCollection().getDocumentContentPackage('123'),
        responseBody: documentContentPackageJson,
        expectedRequestUrlPath: expectedUrlPath,
        expectedRequestQueryParams: [
          'displayInline=false',
          'preview=false',
          'singlePage=false',
          'requireSinglePage=false',
          'pageIndex=0',
        ],
      );
    });
  });
}
